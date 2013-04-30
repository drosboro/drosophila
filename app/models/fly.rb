class Fly
  @@chromosomes = [ 
      [ {:name => :yellow,        :symbol => "y", :map_units => 0.0}, 
        {:name => :white,         :symbol => "w", :map_units => 1.5} ], 
      [ {:name => :curly,         :symbol => "c", :map_units => 6.1 }, 
        {:name => :eyes_absent,   :symbol => "a", :map_units => 16.5 }, 
        {:name => :vestigial,     :symbol => "v", :map_units => 67.0 } ], 
      [ {:name => :antennapedia,  :symbol => "p", :map_units => 58.5 }, 
        {:name => :ebony,         :symbol => "e", :map_units => 70.7} ],
      [ {:name => :x,             :symbol => "x", :map_units => 0 }]
    ]
                    
    
  def self.chromosomes
    @@chromosomes
  end
  
  def self.known_genes
    genes = {}
    @@chromosomes.each do |c|
      c.each do |g|
        genes[g[:name]] = {:symbol => g[:symbol], :map_units => g[:map_units], :chromosome => @@chromosomes.index(c) + 1}
      end
    end
    return genes
  end
  
  def self.create_offspring(father, mother)
    offspring_genes = {}
    self.chromosomes.each do |c|
      last_map = 0.0
      father_chromosome = [0, 1].sample
      mother_chromosome = [0, 1].sample
      c.each do |g|
        if rand() < ((g[:map_units] - last_map) / 100.0)
          father_chromosome = (father_chromosome - 1).abs       
        end
        if rand() < ((g[:map_units] - last_map) / 100.0)
          mother_chromosome = (mother_chromosome - 1).abs
        end
        offspring_genes[g[:name].to_sym] = [father.alleles_for_gene(g[:name])[father_chromosome], mother.alleles_for_gene(g[:name])[mother_chromosome]]
        last_map = g[:map_units]
      end  
    end
    # :white => [@p_male.alleles_for_gene(:white).sample, @p_female.alleles_for_gene(:white).sample], :x => [@p_male.alleles_for_gene(:x).sample, @p_female.alleles_for_gene(:x).sample]
    Fly.new( offspring_genes )
  end
  
  def initialize(genes={})
    self.genes = genes
  end
  
  def alleles_for_gene(gene)
    return @alleles[gene] || [Fly.known_genes[gene.to_sym][:symbol].upcase, Fly.known_genes[gene.to_sym][:symbol].upcase]
  end
  
  def eye_phenotype
    white_alleles = self.alleles_for_gene(:white)
    eyeless = self.alleles_for_gene(:eyes_absent)
    return "eyeless" if (eyeless[0] == Fly.known_genes[:eyes_absent][:symbol].downcase and eyeless[1] == Fly.known_genes[:eyes_absent][:symbol].downcase)
    return "white" if (white_alleles[0] == Fly.known_genes[:white][:symbol].downcase and white_alleles[1] == Fly.known_genes[:white][:symbol].downcase)
    return "red"
  end
  
  def abdomen_phenotype
    yellow_alleles = self.alleles_for_gene(:yellow)
    return "yellow" if (yellow_alleles[0] == Fly.known_genes[:yellow][:symbol].downcase and yellow_alleles[1] == Fly.known_genes[:yellow][:symbol].downcase)
    return "normal"
  end
  
  def wing_phenotype
    v_alleles = self.alleles_for_gene(:vestigial)
    return "vestigial" if (v_alleles[0] == Fly.known_genes[:vestigial][:symbol].downcase and v_alleles[1] == Fly.known_genes[:vestigial][:symbol].downcase)
    return "normal"
  end
  
  def antenna_phenotype
    a_all = self.alleles_for_gene(:antennapedia)
    return "antennapedia" if (a_all[0] == Fly.known_genes[:antennapedia][:symbol].downcase and a_all[1] == Fly.known_genes[:antennapedia][:symbol].downcase)
  end
  
  def gender
    x = self.alleles_for_gene(:x)
    
    return "female" if (x[0] == 'x' && x[1] == 'x')
    return "male"
  end
  
  def gender_symbol
    return "\u2640" if self.gender == "female"
    return "\u2642"
  end
  
  def gender=(g)
    @alleles[:x] = [true, g == "female"]
  end
  
  def has_gene?(gene)
    return true if @alleles.has_key?(gene)
    return false
  end
  
  def genes
    return @alleles
  end
  
  def genes=(values)
    @alleles = values
  end
  
  def alleles
    return @alleles
  end
  
  def alleles=(values)
    @alleles = values
  end
end