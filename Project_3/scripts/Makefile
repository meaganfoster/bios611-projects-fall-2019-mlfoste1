Dockerfile:
	docker build -t tag -f scripts/Dockerfile .
	
../data/master.csv:
	docker run -d --rm -v "$(pwd):$(pwd)" -w "$(pwd)" Dockerfile && touch $@
	python tax.py $@

../data/disability.csv:
	docker run -d --rm -v "$(pwd):$(pwd)" -w "$(pwd)" Dockerfile && touch $@
	python patientsdata.py $@

../results/Project3.html: disability.csv master.csv
	docker run -d --rm -v "$(pwd):$(pwd)" -w "$(pwd)" Dockerfile && touch $@
	Rscript -e "library(rmarkdown); rmarkdown::render('master_df.Rmd', 'html_document')"  && mv Project3.html ../results