/* pomdp_test.cpp
 * Tests for POMDP implementation
 */

#include <iostream>
#include "pomdp.hpp"
#include <string>

using namespace std;

int NUMSTATES = 11;

void print_result(float *res) {
  cout << "<" <<  res[0] << ", " << res[1] << ", " << res[2] << ", " << res[3] << ", " << res[4] << ", " << res[5] << ", " << res[6] << ", " << res[7] << ", " << res[8] << ", " << res[9] << ", " << res[10] << ">" << endl;
}

int main() {
  cout << "Starting main..." << endl;
  
  float observation_model[11][3] = 
    {
      {.1,.9,0},
      {.1,.9,0},
      {.1,.9,0},
      {.1,.9,0},
      {.1,.9,0},
      {.9,.1,0},
      {.9,.1,0},
      {.9,.1,0},
      {.1,.9,0},
      {0,0,1},
      {0,0,1}
    };

  float transition_model[4][11][11] =
    {
      // transition matrix for UP action
      {
        {.1,.8,0,.1,0,0,0,0,0,0,0},
        {0,.2,.8,0,0,0,0,0,0,0,0},
        {0,0,.9,0,.1,0,0,0,0,0,0},
        {.1,0,0,.8,0,.1,0,0,0,0,0},
        {0,0,.1,0,.8,0,0,.1,0,0,0},
        {0,0,0,.1,0,0,.8,0,.1,0,0},
        {0,0,0,0,0,0,.1,.8,0,.1,0},
        {0,0,0,0,.1,0,0,.8,0,0,.1},
        {0,0,0,0,0,.1,0,0,.1,.8,0},
        {0,0,0,0,0,0,0,0,0,1,0},
        {0,0,0,0,0,0,0,0,0,0,1}
      },

      // transition matrix for DOWN action
      {
        {.9,0,0,.1,0,0,0,0,0,0,0},
        {.8,.2,0,0,0,0,0,0,0,0,0},
        {0,.8,.1,0,.1,0,0,0,0,0,0},
        {.1,0,0,.8,0,.1,0,0,0,0,0},
        {0,0,.1,0,.8,0,0,.1,0,0,0},
        {0,0,0,.1,0,.8,0,0,.1,0,0},
        {0,0,0,0,0,.8,.1,0,0,.1,0},
        {0,0,0,0,.1,0,.8,0,0,0,.1},
        {0,0,0,0,0,.1,0,0,.9,0,0,},
        {0,0,0,0,0,0,0,0,0,1,0},
        {0,0,0,0,0,0,0,0,0,0,1}
      },

      // transition matrix for LEFT action
      {
        {.9,.1,0,0,0,0,0,0,0,0,0},
        {.1,.8,.1,0,0,0,0,0,0,0,0},
        {0,.1,.9,0,0,0,0,0,0,0,0},
        {.8,0,0,.2,0,0,0,0,0,0,0},
        {0,0,.8,0,.2,0,0,0,0,0,0},
        {0,0,0,.8,0,.1,.1,0,0,0,0},
        {0,0,0,0,0,.1,.8,.1,0,0,0},
        {0,0,0,0,.8,.0,.1,.1,0,0,0},
        {0,0,0,0,0,.8,0,0,.1,.1,0},
        {0,0,0,0,0,0,0,0,0,1,0},
        {0,0,0,0,0,0,0,0,0,0,1}
      },

      // transition matrix for RIGHT action
      {
        {.1,.1,0,.8,0,0,0,0,0,0,0},
        {.1,.8,.1,0,0,0,0,0,0,0,0},
        {0,.1,.1,0,.8,0,0,0,0,0,0},
        {0,0,0,.2,0,.8,0,0,0,0,0},
        {0,0,0,0,.2,0,0,.8,0,0,0},
        {0,0,0,0,0,.1,.1,0,.8,0,0},
        {0,0,0,0,0,.1,0,.1,0,.8,0},
        {0,0,0,0,0,0,.1,.1,0,0,.8},
        {0,0,0,0,0,0,0,0,.9,.1,0},
        {0,0,0,0,0,0,0,0,0,1,0},
        {0,0,0,0,0,0,0,0,0,0,1}
      }
    };

  string a1[3] = {"UP","UP","UP"};      
  string a2[3] = {"UP","UP","UP"};
  string a3[3] = {"RIGHT","RIGHT","UP"};
  string a4[4] = {"UP","RIGHT","RIGHT","RIGHT"};

  string o1[3] = {"TWOWALL","TWOWALL","TWOWALL"};
  string o2[3] = {"ONEWALL","ONEWALL","ONEWALL"};
  string o3[3] = {"ONEWALL","ONEWALL","END"};
  string o4[4] = {"TWOWALL","TWOWALL","ONEWALL","ONEWALL"};

  float start1[11] = {1.0/9.0,1.0/9.0,1.0/9.0,1.0/9.0,1.0/9.0,1.0/9.0,1.0/9.0,1.0/9.0,1.0/9.0,0,0};
  float start2[11] = {1.0/9.0,1.0/9.0,1.0/9.0,1.0/9.0,1.0/9.0,1.0/9.0,1.0/9.0,1.0/9.0,1.0/9.0,0,0};
  float start3[11] = {0,0,0,0,1,0,0,0,0,0,0};
  float start4[11] = {1,0,0,0,0,0,0,0,0,0,0};
 
  float ***t_m = new float**[4];
  for(int i = 0; i < 4; i++) {
    t_m[i] = new float*[11];
    for(int j = 0; j < 11; j++) {
      t_m[i][j] = new float[11];
      for(int k = 0; k < 11; k++)
        t_m[i][j][k] = transition_model[i][j][k];
    }
  }

  float **o_m = new float*[11];
  for(int i = 0; i < 11; i++) {
    o_m[i] = new float[3];
    for(int j = 0; j < 3; j++)
      o_m[i][j] = observation_model[i][j];

  }

  cout << "Variables initialized..." << endl;

  POMDP *pomdp = new POMDP(t_m,o_m,11);

  cout << "POMDP intialized..." << endl;
  float *result1 = pomdp->run_sequence(start1,a1,o1,3);
  float *result2 = pomdp->run_sequence(start2,a2,o2,3);
  float *result3 = pomdp->run_sequence(start3,a3,o3,3);
  float *result4 = pomdp->run_sequence(start4,a4,o4,4);

  cout << "Results for sequence 1:" << endl;
  print_result(result1);
  cout << "Results for sequence 2:" << endl;
  print_result(result2);
  cout << "Results for sequence 3:" << endl;
  print_result(result3);
  cout << "Results for sequence 4:" << endl;
  print_result(result4);
  cout << endl;

  delete t_m;
  delete o_m;
}
