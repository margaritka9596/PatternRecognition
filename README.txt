The idea.
To recognize 3D digits we implemented 2 main steps:
1)Preprocessing step
2)Recognition using Neural Network with Back propagation error

For the first step we decided that 2dims of input data will be enough for the prediction, because this task can be reduced to the popular task of digits recognition.
So, we took only 2 dims, which are points in 2dims space and plotted them into figure, then we save them into the file system as jpeg images.
After this step we could work with image object, we implemented next steps:
- resizing (important to resize all objects to particular size for the reason that we need to give it afterwards to the neural net)
- binarization
- reshaping (transforming array to vector)

For the second step we used neural network with the Backpropagation algorithm.
There is only 1 hidden layer, but then it turned out that it's enough for recognition.
There are 16 neurons in it and output layer consists of 10 neurons. Also we use sigma function as activation function.



There is a description of files
1)Step1.m
Code for preprocessing input data

2)Step2.m
Consists from several steps:
- getting preprocessed data
- creating outputs for input data
- call of function 'divide_data.m'
- call of function 'train_net.m'
- call of function 'test_net.m' for training data
- call of function 'test_net.m' for test data

3)divide_data.m
Divides the input data (of 1000 samples) into test and train ones.
Alsodivides the outputs(labels for each sample) into the same sets.

4)train_net.m
Consists from several steps:
- initialization of variables
- setting the parametres for net
- building net and estimating the output and error of it for each sample (Forward step)
- Backpropagating step: we correct the weights of net based on the error values moving back on layers
- Continue to make last to steps until we reach 3 states
	1)The error in the epoch will decrease significantly
	2)The number of max epochs is reached 
	3)The difference between epochs doesn't change more than eps

5)sigma.m
Activation function for neurons (using parametr a)

6)test_net.m
Implementing forward step of training algorithm for given samples using evaluated weights from the train_net function

7)output_transformation.m
Transforming output vector to zeros and one vector

8)num_true_predicted.m
Counting true and false predictions

9)online_img_prediction.m
Code for representing the work of program
Shows the plots of imput data and the predictions for them usig test_net function with beforehand evaluated weights