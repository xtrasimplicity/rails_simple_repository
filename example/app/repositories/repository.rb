class Repository
  attr_accessor :class_type

  def initialize(cls_type)
    raise 'Unable to initialize Repository. A class type must be specified!' if cls_type.nil?

    @class_type = cls_type
  end

  def find(id)
    @class_type.find(id)
  end

  def find_by(hash_arg)
    @class_type.find_by(hash_arg)
  end

  def all
    @class_type.all
  end

  def create(attributes={})
    @class_type.create(attributes)
  end

  def update(instance, attrs={})
    instance.update(attrs)
  end

  def save(instance)
    instance.save
  end

  def increment(instance, attr, increment_by)
    instance.increment!(attr, increment_by)
  end

  def new_cls_instance(attrs={})
    @class_type.new(attrs)
  end

  def destroy_all
    @class_type.destroy_all
  end

  def count
    @class_type.count
  end

  def errors(instance)
    instance.errors
  end
  
end
