1  mkdir akeemat
  2  mkdir biocomputing && cd biocomputing
  3  wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.fna 
  4  wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk
  5  wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk
  6  mv wildtype.fna /home/akeematayinla/akeemat
  7  rm wildtype.gbk.1
  8  grep 'tatatata' wildtype.fna
  9  grep "tatatata" wildtype.fna > mutant_sequences.fna
  10  wget "https://www.ncbi.nlm.nih.gov/sviewer/viewer.cgi?db=nucleotide&id=NC_000017.11&report=fasta" -O TP53.fasta
  11  grep -v '^>' TP53.fasta | wc -l
  12  grep -v '^>' TP53.fasta | tr -d '\n' | grep -o 'A' | wc -l
  13  grep -v '^>' TP53.fasta | tr -d '\n' | grep -o 'G' | wc -l
  14  grep -v '^>' TP53.fasta | tr -d '\n' | grep -o 'C' | wc -l
  15  grep -v '^>' TP53.fasta | tr -d '\n' | grep -o 'T' | wc -l
  16  sudo apt-get install bc
  17  total_bases=$(grep -v '^>' TP53.fasta | tr -d '\n' | awk '{print length}')
  18  gc_bases=$(grep -v '^>' TP53.fasta | tr -d '\n' | grep -o '[GC]' | wc -l)
  19  gc_content=$(echo "scale=2; ($gc_bases / $total_bases) * 100" | bc)
  20  echo "%GC content: $gc_content%"
  21  touch akeemat.fasta
  22  A_COUNT=$(grep -v ">" TP53.fasta | tr -d '\n' | grep -o "A" | wc -l)
  23  G_COUNT=$(grep -v ">" TP53.fasta | tr -d '\n' | grep -o "G" | wc -l)
  24  T_COUNT=$(grep -v ">" TP53.fasta | tr -d '\n' | grep -o "T" | wc -l)
  25  C_COUNT=$(grep -v ">" TP53.fasta | tr -d '\n' | grep -o "C" | wc -l)
  26  echo "A: $A_COUNT" >> akeemat.fasta
  27  echo "G: $G_COUNT" >> akeemat.fasta
  28  echo "T: $T_COUNT" >> akeemat.fasta
  29  echo "C: $C_COUNT" >> akeemat.fasta
  30  history
  31  cat akeemat. fasta
  32  cat akeemat.fasta
  33  mkdir output
  34  cp akeemat.fasta output/
  35  ls output
  36  mkdir script
  37  touch akeemat.sh
  38  cp akeemat.sh script/
  39  clear
  40  history
  41  ls output
  42  ls script
