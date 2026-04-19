PANDOC   := pandoc
DEFAULTS := defaults.yaml
TEMPLATE := template.tex
META     := meta.yaml
TOC      := toc.txt
BOOKDIR  := book
MDDIR    := $(BOOKDIR)/md
IMGDIR   := $(BOOKDIR)/img

PDF := book.pdf
TEX := book.tex

# Read toc.txt:
# - ignore blank lines
# - ignore lines starting with #
# - prepend book/md/
BOOK_PARTS := $(shell awk 'NF && $$1 !~ /^#/ { print "$(MDDIR)/" $$0 }' $(TOC))

.PHONY: all pdf tex clean distclean rebuild view check vars parts

all: pdf

pdf: $(PDF)

tex: $(TEX)

parts:
	@printf '%s\n' $(BOOK_PARTS)

$(TEX): $(META) $(TOC) $(BOOK_PARTS) $(DEFAULTS) $(TEMPLATE)
	$(PANDOC) \
		--defaults=$(DEFAULTS) \
		--metadata-file=$(META) \
		$(BOOK_PARTS) \
		-o $@

$(PDF): $(META) $(TOC) $(BOOK_PARTS) $(DEFAULTS) $(TEMPLATE)
	$(PANDOC) \
		--defaults=$(DEFAULTS) \
		--metadata-file=$(META) \
		$(BOOK_PARTS) \
		-o $@

rebuild: clean all

clean:
	rm -f $(PDF) $(TEX)

distclean: clean
	rm -rf $(BOOKDIR)

check:
	command -v $(PANDOC) >/dev/null
	test -f $(META)
	test -f $(TOC)
	test -f $(DEFAULTS)
	test -f $(TEMPLATE)
	test -d $(MDDIR)
	test -d $(IMGDIR)

view: $(PDF)
	xdg-open $(PDF) 2>/dev/null

vars:
	@echo PANDOC=$(PANDOC)
	@echo DEFAULTS=$(DEFAULTS)
	@echo TEMPLATE=$(TEMPLATE)
	@echo META=$(META)
	@echo TOC=$(TOC)
	@echo BOOKDIR=$(BOOKDIR)
	@echo MDDIR=$(MDDIR)
	@echo IMGDIR=$(IMGDIR)
	@echo PDF=$(PDF)
	@echo TEX=$(TEX)
	@echo BOOK_PARTS=$(BOOK_PARTS)
