module GenerationsHelper
  def cell(status)
    class_names = ["outline outline-1 rounded-md w-full pb-[100%]"]
    class_names << (alive?(status) ? "outline-yellow-700 bg-yellow-800" : "outline-gray-200 bg-gray-50")
    content_tag :div, "", class: class_names
  end

  def alive?(status)
    status == Generation::ALIVE
  end
end
