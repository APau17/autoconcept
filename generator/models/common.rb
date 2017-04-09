class Unity < Struct.new(:id,
                       :nom,
                       :ratio,
                       :Unite_base_id
                        )

  def initialize(id = 0)
    self.id = id
  end

  def next
    Unity.new(seld.id + 1)
  end
end

