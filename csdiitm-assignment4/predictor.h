/* Author: Jared Stark;   Created: Tue Jul 27 13:39:15 PDT 2004
 * Description: This file defines a gshare branch predictor.
*/

#ifndef PREDICTOR_H_SEEN
#define PREDICTOR_H_SEEN

#include <assert.h>
#include <cstddef>
#include <inttypes.h>
#include <vector>
#include "op_state.h"   // defines op_state_c (architectural state) class 
#include "tread.h"      // defines branch_record_c class

class PREDICTOR
{
 public:
  typedef uint32_t address_t;  // type for program counter
  
 private:
  typedef uint32_t history_t;  // type for history register
  typedef uint8_t counter_t;  // type for saturation counters
  
  static const uint32_t LHT_SIZE = 1024;
  static const uint32_t LPT_SIZE = 1024;
  static const uint32_t GPT_SIZE = 4096;
  static const uint32_t CPT_SIZE = 4096;

  history_t local_history_table[LHT_SIZE];
  counter_t local_prediction_table[LPT_SIZE];
  counter_t global_prediction_table[GPT_SIZE];
  counter_t choice_prediction_table[CPT_SIZE];
  history_t path_history;

  static bool bit2_counter_msb(/* 2-bit counter */ counter_t cnt) {
    return (cnt >= 2);
  }

  static counter_t bit2_counter_inc(/* 2-bit counter */ counter_t &cnt) {
    if (cnt != 3) 
      ++cnt; 
    return cnt; 
  }

  static counter_t bit2_counter_dec(/* 2-bit counter */ counter_t &cnt) {
    if (cnt != 0)
      --cnt;
    return cnt;
  }

  static bool bit3_counter_msb(/* 2-bit counter */ counter_t cnt) {
    return (cnt >= 4);
  }

  static counter_t bit3_counter_inc(/* 2-bit counter */ counter_t &cnt) {
    if (cnt != 7) 
      ++cnt;
    return cnt;
  }

  static counter_t bit3_counter_dec(/* 2-bit counter */ counter_t &cnt) {
    if (cnt != 0)
      --cnt;
    return cnt;
  }

  static void update_10bit_history (history_t &history, int is_taken) {
    history = ((history << 1) & (LHT_SIZE - 1)) + is_taken;
  }

  static void update_12bit_history (history_t &history, int is_taken) {
    history = ((history << 1) & (GPT_SIZE - 1)) + is_taken;
  }

 public:
  // uses compiler generated constructor
  // uses compiler generated copy constructor
  // uses compiler generated destructor
  // uses compiler generated assignment operator

  void initPredictor () {
    // assigns all previous local/global branches to 'NOT TAKEN'
    uint32_t i;
    for (i = 0; i < LHT_SIZE; i++) {
      local_history_table[i] = 0;
      local_prediction_table[i] = 0;
    }

    for (i = 0; i < GPT_SIZE; i++) {
      global_prediction_table[i] = 0;
      choice_prediction_table[i] = 0;
    }

    path_history = 0;
  }

  // get_prediction() takes a branch record (br, branch_record_c is defined in
  // tread.h) and architectural state (os, op_state_c is defined op_state.h).
  // Your predictor should use this information to figure out what prediction it
  // wants to make.  Keep in mind you're only obligated to make predictions for
  // conditional branches.
  bool get_prediction(const branch_record_c* br, const op_state_c* os)
  {
    bool prediction = false;
    if (/* conditional branch */ br->is_conditional) {
      address_t pc = br->instruction_addr & (LHT_SIZE - 1);
      assert(pc >= 0 && pc <= LHT_SIZE - 1);

      history_t local_history = local_history_table[pc];
      counter_t local_counter = local_prediction_table[local_history];

      bool local_prediction = bit3_counter_msb(local_counter);

      counter_t global_counter = global_prediction_table[path_history];
      bool global_prediction = bit2_counter_msb(global_counter);

      if (local_prediction == global_prediction) {
	prediction = local_prediction;
      } else {
	counter_t choice_counter = choice_prediction_table[path_history];
	if (bit2_counter_msb(choice_counter)) {
	  prediction = global_prediction;
	} else {
	  prediction = local_prediction;
	}
      }
    }
    return prediction;   // true for taken, false for not taken
  }

  // Update the predictor after a prediction has been made.  This should accept
  // the branch record (br) and architectural state (os), as well as a third
  // argument (taken) indicating whether or not the branch was taken.
  void update_predictor(const branch_record_c* br, const op_state_c* os, bool taken)
  {
    if (/* conditional branch */ br->is_conditional) {
      address_t pc = br->instruction_addr & (LHT_SIZE - 1);
      assert(pc >= 0 && pc <= LHT_SIZE - 1);

      history_t local_history = local_history_table[pc];
      counter_t local_counter = local_prediction_table[local_history];

      bool local_prediction = bit3_counter_msb(local_counter);

      counter_t global_counter = global_prediction_table[path_history];
      bool global_prediction = bit2_counter_msb(global_counter);

      if (local_prediction != global_prediction) {
	if (local_prediction == taken) {
	  bit2_counter_dec(choice_prediction_table[path_history]);
	} else {
	  bit2_counter_inc(choice_prediction_table[path_history]);
	}
      }

      if (taken) {
	bit3_counter_inc(local_prediction_table[local_history]);
      } else {
	bit3_counter_dec(local_prediction_table[local_history]);
      }

      update_10bit_history(local_history_table[pc], taken);

      if (taken) {
	bit2_counter_inc(global_prediction_table[path_history]);
      } else {
	bit2_counter_dec(global_prediction_table[path_history]);
      }
      
      update_12bit_history(path_history, taken);
    }
  }

  void dumpStats () {
  }

};

#endif // PREDICTOR_H_SEEN

