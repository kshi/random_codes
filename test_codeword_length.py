import ensemble_substitute_attack as ens
import sys
import os.path

NB_CLASSES = 10
BATCH_SIZE = 128
LEARNING_RATE = .001
NB_EPOCHS = 10
HOLDOUT = 150
DATA_AUG = 6
NB_EPOCHS_S = 10
LMBDA = .1
AUG_BATCH_SIZE = 512

save_path = "results/codeword_length.csv"

if not os.path.exists(save_path):
    with open(save_path, "w") as outfile:
        outfile.write("code_length,accuracy,adv_accuracy\n")

CODEWORD_LENGTHS = ['32', '64', '128', '256']
if len(sys.argv) > 1:
    CODEWORD_LENGTHS = sys.argv[1:]

for NB_CODEWORDS_STR in CODEWORD_LENGTHS:
    print('Training ensemble with codeword length ' + NB_CODEWORDS_STR)    
    NB_CODEWORDS = int(NB_CODEWORDS_STR)
    accuracies = ens.mnist_blackbox(
        nb_codewords = NB_CODEWORDS, nb_classes = NB_CLASSES,
        batch_size = BATCH_SIZE, learning_rate = LEARNING_RATE,
        nb_epochs = NB_EPOCHS, holdout = HOLDOUT,
        data_aug = DATA_AUG, nb_epochs_s = NB_EPOCHS_S,
        lmbda = LMBDA, aug_batch_size = AUG_BATCH_SIZE)
    result = '{0},{1},{2}\n'.format(
        NB_CODEWORDS, accuracies['bbox'], accuracies['bbox_on_sub_adv_ex'])
    with open(save_path, "a") as outfile:
        outfile.write(result)
