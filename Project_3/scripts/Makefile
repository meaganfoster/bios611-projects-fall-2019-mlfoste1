dockerfile:
	docker build -t tag -f scripts/Dockerfile
	
master.csv:
	docker run -d --rm -v "$(pwd):$(pwd)" -w "$(pwd)" Dockerfile && touch $@
	python wrangling.ipynb $@

disability.csv:
	docker run -d --rm -v "$(pwd):$(pwd)" -w "$(pwd)" Dockerfile && touch $@
	python wrangling.ipynb $@

../results/master_df.html: disability.csv master.csv
	docker run -d --rm -v "$(pwd):$(pwd)" -w "$(pwd)" Dockerfile && touch $@
	Rscript -e "library(rmarkdown); rmarkdown::render('master_df.Rmd', 'html_document')"  && mv master_df.html ../results