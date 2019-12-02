build:
	docker build -t dockerbuild	.	-f scripts/Dockerfile && \
	touch $@
	
master.csv:
	docker run -d --rm -v "$(pwd):$(pwd)" -w "$(pwd)" dockerfile && touch $@
	python wrangling.ipynb $@

disability.csv:
	docker run -d --rm -v "$(pwd):$(pwd)" -w "$(pwd)" dockerfile && touch $@
	python wrangling.ipynb $@

results/master_df.html: disability.csv master.csv
	docker run -d --rm -v "$(pwd):$(pwd)" -w "$(pwd)" dockerfile && touch $@
	Rscript -e "library(rmarkdown); rmarkdown::render('scripts/master_df.rmd', 'html_document')"  && mv master_df.html ../results