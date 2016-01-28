class  Translation
  AMINO_ACIDE_TABLE = {
    'AUG' => 'Methionine', 'UUU' => 'Phenylalanine',
    'UUC' => 'Phenylalanine', 'UUA' => 'Leucine',
    'UUG' => 'Leucine', 'UCU' => 'Serine',
    'UCC' => 'Serine', 'UCA' => 'Serine', 'UCG' => 'Serine',
    'UAU' => 'Tyrosine', 'UAC' => 'Tyrosine',
    'UGU' => 'Cysteine', 'UGC' => 'Cysteine',
    'UGG' => 'Tryptophan',
    'UAA' => 'STOP', 'UAG' => 'STOP', 'UGA' => 'STOP'
  }
  def self.of_codon(codon)
    AMINO_ACIDE_TABLE[codon]
  end
  
  def self.of_rna(strand)
    result = []
    strand.scan(/.../).each do |codon|
      raise InvalidCodonError if AMINO_ACIDE_TABLE[codon] == nil
      return result if AMINO_ACIDE_TABLE[codon] == 'STOP'
      result << AMINO_ACIDE_TABLE[codon]
    end
    result
  end
end

class InvalidCodonError < StandardError
end
