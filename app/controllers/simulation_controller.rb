class SimulationController < ApplicationController
  def index
    @p_male = Fly.new(:white => ["w", "w"], :yellow => ["y", "y"], :x => ["X", "x"])
    @p_female = Fly.new(:white => ["W", "W"], :yellow => ["y", "y"], :x => ["x", "x"])
    @f1_flies = []
    r = RandomGaussian.new(80, 12)
    
    # r.rand.to_i.times do
    #   fly = Fly.new(:white => [@p_male.alleles_for_gene(:white).sample, @p_female.alleles_for_gene(:white).sample], :x => [@p_male.alleles_for_gene(:x).sample, @p_female.alleles_for_gene(:x).sample])
    #   @f1_flies.append(fly)
    # end
    
    r.rand.to_i.times do
      fly = Fly.create_offspring(@p_male, @p_female)
      @f1_flies.append(fly)
    end
    
    @eyes = @f1_flies.map { |f| f.eye_phenotype }
    @gender = @f1_flies.map { |f| f.gender }
  end
  
  def cross
    # raise params.inspect
    # male_attr = params[]
    @p_male = Fly.new(params[:p_male])
    @p_female = Fly.new(params[:p_female])
    @f1_flies = []
    r = RandomGaussian.new(80, 12)
    
    r.rand.to_i.times do
      fly = Fly.create_offspring(@p_male, @p_female)
      @f1_flies.append(fly)
    end
    @eyes = @f1_flies.map { |f| f.eye_phenotype }
    @abdomen = @f1_flies.map { |f| f.abdomen_phenotype }
    @gender = @f1_flies.map { |f| f.gender }
    render :action => :index
  end
end
