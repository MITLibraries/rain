# Remove Existing ElementTypes
ElementType.delete_all

# Setup ElementTypes
ElementType.create(id: 1, name: 'form')
ElementType.create(id: 2, name: 'fieldset')
ElementType.create(id: 3, name: 'text')
ElementType.create(id: 4, name: 'textarea')
ElementType.create(id: 5, name: 'select')
ElementType.create(id: 6, name: 'option')
ElementType.create(id: 7, name: 'checkbox')
ElementType.create(id: 8, name: 'radio_group')
ElementType.create(id: 9, name: 'radio')
ElementType.create(id: 10, name: 'submit')

# Remove Existing ElementTypeAccepts
ElementTypeAccept.delete_all

# Setup ElementTypeAccepts
ElementTypeAccept.create(element_type_id: 1, accepts_element_type_id: 2)
ElementTypeAccept.create(element_type_id: 1, accepts_element_type_id: 3)
ElementTypeAccept.create(element_type_id: 1, accepts_element_type_id: 4)
ElementTypeAccept.create(element_type_id: 1, accepts_element_type_id: 5)
ElementTypeAccept.create(element_type_id: 1, accepts_element_type_id: 7)
ElementTypeAccept.create(element_type_id: 1, accepts_element_type_id: 8)
ElementTypeAccept.create(element_type_id: 1, accepts_element_type_id: 10)

ElementTypeAccept.create(element_type_id: 2, accepts_element_type_id: 2)
ElementTypeAccept.create(element_type_id: 2, accepts_element_type_id: 3)
ElementTypeAccept.create(element_type_id: 2, accepts_element_type_id: 4)
ElementTypeAccept.create(element_type_id: 2, accepts_element_type_id: 5)
ElementTypeAccept.create(element_type_id: 2, accepts_element_type_id: 7)
ElementTypeAccept.create(element_type_id: 2, accepts_element_type_id: 8)

ElementTypeAccept.create(element_type_id: 5, accepts_element_type_id: 6)

ElementTypeAccept.create(element_type_id: 8, accepts_element_type_id: 9)
