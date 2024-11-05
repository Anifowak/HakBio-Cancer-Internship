mkdir Mary
mkdir biocomputing && cd biocomputing
wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.fna > wildtype.fna  
wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk > wildtype.gbk
wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk > wildtype.gbk
mv wildtype.fna /home/alo/Mary
rm wildtype.gbk.1
grep tatatata wildtype.fna
grep tatatata wildtype.fna.1 > mutant_sequences.fna
wget "https://www.ncbi.nlm.nih.gov/nuccore/NC_000009.12?report=fasta" -O JAK2.fasta
grep -v "^>" JAK2.fasta | wc -l
grep -v "^>" JAK2.fasta | grep -o "A" | wc -l
grep -v "^>" JAK2.fasta | grep -o "G" | wc -l
grep -v "^>" JAK2.fasta | grep -o "C" | wc -l
grep -v "^>" JAK2.fasta | grep -o "T" | wc -l
sudo apt-get install bc
GC=$(grep -v "^>" JAK2.fasta | grep -o "[GC]" | wc -l)
TOTAL=$(grep -v "^>" JAK2.fasta | grep -o "[ATGC]" | wc -l)
GC=$(grep -v "^>" JAK2.fasta | grep -o "[GC]" | wc -l)
"GC: $GC, TOTAL: $TOTAL"
GC_CONTENT=$(echo "scale=2; ($GC/$TOTAL)*100" | bc)
echo "GC Content: $GC_CONTENT%"
touch Mary.fasta
A_COUNT=$(grep -v ">" JAK2.fasta | tr -d '\n' | grep -o "A" | wc -l)
G_COUNT=$(grep -v ">" JAK2.fasta | tr -d '\n' | grep -o "G" | wc -l)
T_COUNT=$(grep -v ">" JAK2.fasta | tr -d '\n' | grep -o "T" | wc -l)
C_COUNT=$(grep -v ">" JAK2.fasta | tr -d '\n' | grep -o "C" | wc -l)
echo "A: $A_COUNT" >> Mary.fasta
echo "G: $G_COUNT" >> Mary.fasta
echo "T: $T_COUNT" >> Mary.fasta
echo "C: $C_COUNT" >> Mary.fasta 



