module Utils
  def self.round(price)
    return price if price % 5 == 0
    price + 5 - (price % 5)
  end

  def self.fake_decimal(price)
    price = price.to_i.to_s
    price.insert(-3, ".")
  end
end

class Product
  include Utils
  def initialize(qty, name, price)
    @qty = qty
    @name = name
    @price = price * 100
  end
  def qty
    @qty
  end
  def name
    @name
  end
  def subtotal
    @qty * @price
  end
    def sales_tax
      Utils::round(subtotal * tax_rate)
    end
  def item_total
    subtotal + sales_tax
  end
    def tax_rate
      0.1
    end
end

class Exempt < Product
  def tax_rate
    0
  end
end

class Imported < Product
  def tax_rate
    super + 0.05
  end
end

class ExemptImported < Exempt
  def tax_rate
    super + 0.05
  end
end

class Basket
  include Utils

  def initialize
    @container = []
  end
  def add(item)
    @container << item
  end
  def total_tax
    tot = 0
    @container.each do |x|
      tot += x.sales_tax
    end
    return tot
  end
  def total
    final = 0
    @container.each do |x|
      final += x.subtotal
    end
    return Utils::fake_decimal(final + total_tax)
  end
  def print_receipt
    @container.each {|x| puts "#{x.qty} #{x.name}: #{Utils::fake_decimal(x.item_total)}"}
    puts "Sales Taxes: #{Utils::fake_decimal(total_tax)}"
    puts "Total: #{total}"
  end
end

book = Exempt.new(1, "book", 12.49)
cd = Product.new(1, "music cd", 14.99)
choc_bar = Exempt.new(1, "chocolate bar", 0.85)

imp_choc = ExemptImported.new(1, "imported box of chocolates", 10.00)
imp_perfume = Imported.new(1, "imported bottle of perfume", 47.50)

imp_perfume2 = Imported.new(1, "imported bottle of perfume", 27.99)
perfume = Product.new(1, "bottle of perfume", 18.99)
pills = Exempt.new(1, "packet of headache pills", 9.75)
imp_choc2 = ExemptImported.new(1, "box of imported chocolates", 11.25)

cart1 = Basket.new
cart1.add(book)
cart1.add(cd)
cart1.add(choc_bar)
cart1.print_receipt

cart2 = Basket.new
cart2.add(imp_choc)
cart2.add(imp_perfume)
cart2.print_receipt

cart3 = Basket.new
cart3.add(imp_perfume2)
cart3.add(perfume)
cart3.add(pills)
cart3.add(imp_choc2)
cart3.print_receipt