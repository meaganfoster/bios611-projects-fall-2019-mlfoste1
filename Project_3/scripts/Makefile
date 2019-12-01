Dockerfile:
	docker build -t tag -f scripts/Dockerfile .
	
../data/master.csv:
	docker run -d --rm -v "$(pwd):$(pwd)" -w "$(pwd)" Dockerfile && touch $@
	python wrangling.ipynb $@

../data/disability.csv:
	docker run -d --rm -v "$(pwd):$(pwd)" -w "$(pwd)" Dockerfile && touch $@
	python wrangling.ipynb $@

../results/master_df.html: ../data/disability.csv ../data/master.csv
	docker run -d --rm -v "$(pwd):$(pwd)" -w "$(pwd)" Dockerfile && touch $@
	Rscript -e "library(rmarkdown); rmarkdown::render('master_df.Rmd', 'html_document')"  && mv master_df.html ../results