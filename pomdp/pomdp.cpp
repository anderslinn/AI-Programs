/* pomdp.cpp
 * 
 * Partially Observable Markov Decision Process Algorithm
 *
 * Basic implemenation of a POMDP. For simulation only.
 */

#include "pomdp.hpp"
#include <string.h>
#include <iostream>
#include <string>

using std::string;
using std::endl;

POMDP::POMDP(float ***transition_model, float **observation_model, int numstates) {
  tm = transition_model;
  om = observation_model;
  NUMSTATES = numstates;
}

float* POMDP::run_sequence(float *initial_state, string *actions, string *observations, int num_rounds) {
  float *bs = initial_state;
 
  for(int i = 0; i < num_rounds; i++) {
    update(bs,actions[i],observations[i]); 
  }
  return bs;
}

void POMDP::update(float *belief_state, string action, string observation) {
  float **trans = select_transition_matrix(action);
  float *obs = select_observation_vector(observation);
  matrix_multiply(trans,belief_state);
  element_multiply(obs,belief_state);
  normalize(belief_state);
}
  
float** POMDP::select_transition_matrix(string action) {
  if(action == "UP")
    return tm[UP];
  else if(action == "DOWN")
    return tm[DOWN];
  else if(action == "LEFT")
    return tm[LEFT];
  else
    return tm[RIGHT];
}

float* POMDP::select_observation_vector(string obs) {
  float *ret = new float[11];
  if(obs == "ONEWALL") {
    for(int i = 0; i < 11; i++)
      ret[i] = om[i][ONEWALL];
    return ret;
  } else if(obs == "TWOWALL") {
    for(int i = 0; i < 11; i++)
      ret[i] = om[i][TWOWALL];
    return ret;
  } else {
     for(int i = 0; i < 11; i++)
      ret[i] = om[i][END];
    return ret;
  }
}

void POMDP::matrix_multiply(float **matrix, float *vector) {
  float temp[NUMSTATES];
  for(int i = 0; i < NUMSTATES; i++) {
    temp[i] = 0;
    for(int j = 0; j < NUMSTATES; j++)
      temp[i] += matrix[j][i] * vector[j];
  }
  for(int i = 0; i < NUMSTATES; i++)
    vector[i] = temp[i];
}

void POMDP::element_multiply(float *vec1, float *vec2) {
  for(int i = 0; i < NUMSTATES; i++)
    vec2[i] = vec2[i]*vec1[i];
}

void POMDP::normalize(float *vector) {
  float sum = 0;
  for(int i = 0; i < NUMSTATES; i++)
    sum += vector[i];
  for(int i = 0; i < NUMSTATES; i++)
    vector[i] = vector[i]/sum;
}
