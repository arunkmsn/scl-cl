# Introduction
Command line tools to do batch processing of commonly used features in [samsaadhani](http://scl.samsaadhanii.in/).

All the tools should be in the home directory of the vagrant virtual machine which has a working samsaadhani instance deployed. For more information on installing samsaadhani, please take a look at [samsaadhani-deploy](https://www.github.com/arunkmsn/samsadhani-deploy).

# Usage
All the tools are in `/home/vagrant/scl-cl` folder. The list of words should be in Unicode format and the words must be separated by newline.

## Morphological analyser
```
$ cd ~/scl-cl
$ ./morph.pl <path-to-file-with-words-seperated-by-newline> Unicode
```

Examples:

### Input file
```
रामः
रमा
गच्छति
```

### Output
```
राम{वर्गः ना} पुं 1 एक{लेवेल् 1}
रा1 कर्तरि लट् उ बहु परस्मैपदी{धातुः रा}{गणः अदादिः}{लेवेल् 1}

रमा{वर्गः ना} स्त्री 1 एक{लेवेल् 1}

गच्छत्{वर्गः ना} पुं 7 एक{लेवेल् 2}(गम्1 शतृ_लट्{धातुः गमॢँ}{गणः भ्वादिः})
गच्छत्{वर्गः ना} नपुं 7 एक{लेवेल् 2}(गम्1 शतृ_लट्{धातुः गमॢँ}{गणः भ्वादिः})
गम्1 कर्तरि लट् प्र एक परस्मैपदी{धातुः गमॢँ}{गणः भ्वादिः}{लेवेल् 1}
```

## Sandhi Splitter
```
$ cd ~/scl-cl
$ ./sandhi_splitter.pl <path-to-file-with-words-seperated-by-newline> [s|S|b] Unicode
```
NOTE:

```
s - pada cheda (sandhi split)
S - samasa cheda (samasa split)
b - ubhaya (both)
```

Example:

### Input file

```
सर्वेन्द्रियम्
ग्राममागच्छ
```

### Output

```
सर्वेन्द्रियम् =  [षर्व्1 कर्तरि लोट् म एक परस्मैपदी<धातुः:षर्वँ><गणः:भ्वादिः>] सर्व + [इन्द्रिय<वर्गः:ना> पुं 2 एक/इन्द्रिय<वर्गः:ना> नपुं 1 एक/इन्द्रिय<वर्गः:ना> नपुं 2 एक] इन्द्रियम्
ग्राममागच्छ =  [ग्राम<वर्गः:ना> पुं 2 एक/ग्राम<वर्गः:ना> नपुं 1 एक/ग्राम<वर्गः:ना> नपुं 2 एक] ग्रामम् + [आङ्_गम्1 कर्तरि लोट् म एक परस्मैपदी<धातुः:गमॢँ><गणः:भ्वादिः>] आगच्छ
```

## Sandhi Joiner
```
$ cd ~/scl-cl
$ ./sandhi_joiner.pl <path-to-file-with-words-joined-by-colon> Unicode
```

Example:

### Input file

```
लक्ष्मीवान्:शुभलक्षणः

```

### Output

```
लक्ष्मीवान् + शुभलक्षणः =
लक्ष्मीवाञ्छुभलक्षणः			तुगागम->श्चुत्व->चर्त्व->छत्व->लोपः			शि तुक् (8।3।31)->स्तोः श्चुना श्चुः (8।4।40)->खरि च (8।4।55)->शश्छोऽटि (8।4।63)->झरो झरि सवर्णे (8।4।65)
लक्ष्मीवाञ्च्छुभलक्षणः			तुगागम->श्चुत्व->चर्त्व->छत्व->लोपाभावः			शि तुक् (8।3।31)->स्तोः श्चुना श्चुः (8।4।40)->खरि च (8।4।55)->शश्छोऽटि (8।4।63)
लक्ष्मीवाञ्च्शुभलक्षणः			तुगागम -> श्चुत्व-> चर्त्व			शि तुक् (8।3।31)-> स्तोः श्चुना श्चुः (8।4।40)-> खरि च (8।4।55)
लक्ष्मीवाञ्शुभलक्षणः			श्चुत्व			स्तोः श्चुना श्चुः (8।4।40)


```
