mkdir -p output
papermill input/dataloader.ipynb output/dataloader_output_$EPOCHSECONDS.ipynb 
papermill input/model.ipynb output/model_output_$EPOCHSECONDS.ipynb