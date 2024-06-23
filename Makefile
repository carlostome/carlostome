OUTDIR := site.out
GIT := git -C $(OUTDIR)

$(OUTDIR):
	mkdir $(OUTDIR)
	mkdir $(OUTDIR)/css

$(OUTDIR)/css/style.css: $(OUTDIR) css/style.css
	cp css/style.css $(OUTDIR)/css/style.css

$(OUTDIR)/index.html: $(OUTDIR) index.md
	pandoc --strip-comments --standalone --css=css/style.css -V lang=en --from=markdown --to=html5 index.md -o $(OUTDIR)/index.html

all: $(OUTDIR)/index.html $(OUTDIR)/css/style.css

.PHONY: clean deploy

clean:
	rm -rf $(OUTDIR)

deploy:
	$(GIT) init
	$(GIT) remote add origin git@github.com:carlostome/carlostome.github.io.git
	$(GIT) add --all
	$(GIT) commit -m "Initial commit"
	$(GIT) push -f origin main:gh-pages
