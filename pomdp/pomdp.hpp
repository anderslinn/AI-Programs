/* pomdp.hpp
 * 
 * Partially Observable Markov Decision Process Algorithm
 *
 * Basic implemenation of a POMDP. For simulation only.
 */

#include <string>

using std::string;

class POMDP {
  public:
    POMDP(float ***transition_model, float **observation_model, int numstates);
    float *run_sequence(float *initial_state, string *actions, string *observations, int num_rounds);
 // private:
    static const int UP = 0;
    static const int DOWN = 1;
    static const int LEFT = 2;
    static const int RIGHT = 3;
    static const int ONEWALL = 0;
    static const int TWOWALL = 1;
    static const int END = 2;

    int NUMSTATES;

    float ***tm;
    float **om;
    void update(float *belief_state, string action, string observation);
    float** select_transition_matrix(string action);
    float* select_observation_vector(string obs);
    void matrix_multiply(float **matrix, float *vector);
    void element_multiply(float *vector1, float *vector2);
    void normalize(float *vector);
};
