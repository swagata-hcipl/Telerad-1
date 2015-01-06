$(document).on "page:fetch", ->
  NProgress.start()
  return

$(document).on "page:change", ->
  NProgress.done()
  return

$(document).on "page:restore", ->
  NProgress.remove()
  return

# handleFileSelect = (evt) ->
#   files = evt.target.files # FileList object
#   # files is a FileList of File objects. List some properties.
#   output = []
#   i = 0
#   f = undefined
#   alert "ret"
#   while f = files[i]
#     byteArray = new Uint8Array(f)
#     parseByteArray byteArray
#     i++
#   return
# parseByteArray = (byteArray) ->
  
#   # We need to setup a try/catch block because parseDicom will throw an exception
#   # if you attempt to parse a non dicom part 10 file (or one that is corrupted)
#   try
    
#     # parse byteArray into a DataSet object using the parseDicom library
#     dataSet = dicomParser.parseDicom(byteArray)
    
#     # dataSet contains the parsed elements.  Each element is available via a property
#     # in the dataSet.elements object.  The property name is based on the elements group
#     # and element in the following format: xggggeeee where gggg is the group number
#     # and eeee is the element number with lowercase hex characters.
    
#     # To access the data for an element, we need to know its type and its tag.
#     # We will get the sopInstanceUid from the file which is a string and
#     # has the tag (0020,000D)
#     sopInstanceUid = dataSet.string("x0020000d")
    
#     # Now that we have the sopInstanceUid, lets add it to the DOM
#     $("#sopInstanceUid").text sopInstanceUid
    
#     # Next we will get the Patient Id (0010,0020).  This is a type 2 attribute which means
#     # that the element must be present but it can be empty.  If you attempt to get the string
#     # for an element that has data of zero length (empty) , parseDicom will return
#     # undefined so we need to check for that to avoid a script error
#     patientId = dataSet.string("x00100020")
#     if patientId isnt `undefined`
#       $("#patientId").text patientId
#     else
#       $("#patientId").text "element has no data"
    
#     # Next we will try to get the Other Patient IDs Sequence (0010,1002).  This is a type 3 attribute
#     # which means it may or may not be present.  If you attempt to get the string
#     # for an element that is not present, parseDicom will return
#     # undefined so we need to check for that to avoid a script error
#     otherPatientIds = dataSet.string("x00101002")
#     if otherPatientIds isnt `undefined`
#       $("#otherPatientIds").text patientId
#     else
#       $("#otherPatientIds").text "element not present"
    
#     # Next we will try get the Rows (0028,0010) attribute which is required for images.  This
#     # is stored with VR type US which is a 16 bit unsigned short field.  To access this, we need
#     # to use the uint16 funciton instead:
#     rows = dataSet.uint16("x00280010")
#     if rows isnt `undefined`
#       $("#rows").text rows
#     else
#       $("#rows").text "element not present or has no data"
    
#     # the DataSet object has functions to support every VR type:
#     # All string types - string()
#     # US - uint16()
#     # SS - int16()
#     # UL - uint32()
#     # SL - int32()
#     # FL - float()
#     # FD - double()
#     # DS - floatString()
#     # IS - intString()
#     # DA - date() - returns a Javascript Date object
#     # TM - time() - returns an object with properties for hours, minutes, seconds and fractionalSeconds
#     # PN - personName() - returns an object with properties for familyName, givenName, middleName, prefix and suffix
    
#     # next we will access the ReferencedImageSequence (0008,1140) element which is of type VR.  A sequence contains one
#     # or more items each of which is a DataSet object.  This attribute is not required so may not be present
#     referencedImageSequence = dataSet.elements.x00081140
#     if referencedImageSequence isnt `undefined`
      
#       # sequence items can be empty so we need to check that first
#       if referencedImageSequence.items.length > 0
        
#         # get the first sequence item dataSet
#         firstItem = referencedImageSequence.items[0]
#         firstItemDataSet = firstItem.dataSet
        
#         # now we can access the elements in the sequence data set just like
#         # we did above.  In this case we will access the ReferencedSOPClassUID
#         # (0008,1150):
#         referencedSOPClassUID = firstItemDataSet.string("x00081150")
#         $("#referencedSOPClassUID").text referencedSOPClassUID
    
#     # Next we will access values from a multi valued element.  A multi valued element contains multiple values
#     # like an array.  We will access the ImagePositionPatient x00200032 element and extract the X, Y and Z
#     # values from it;
#     if dataSet.elements.x00200032 isnt `undefined`
#       imagePositionPatientX = dataSet.floatString("x00200032", 0)
#       imagePositionPatientY = dataSet.floatString("x00200032", 1)
#       imagePositionPatientZ = dataSet.floatString("x00200032", 2)
#       $("#imagePositionPatientX").text imagePositionPatientX
#       $("#imagePositionPatientY").text imagePositionPatientY
#       $("#imagePositionPatientZ").text imagePositionPatientZ
    
#     # In some cases the number of values in a multi valued element varies.  We can ask
#     # for the number of values and the iterate over them
#     if dataSet.elements.x00200032 isnt `undefined`
#       numValues = dataSet.numStringValues("x00200032")
#       text = numValues + " ("
#       i = 0

#       while i < numValues
#         value = dataSet.floatString("x00200032", i)
#         text += value + " "
#         i++
#       text += ")"
#       $("#imagePositionPatientNumValues").text text
    
#     # parseDicom keeps track of the length of each element and its offset into the byte array
#     # it was parsed from.  Here we show how we can obtain this by accessing the element directly:
#     sopInstanceUidElement = dataSet.elements.x0020000d
#     text = "dataOffset = " + sopInstanceUidElement.dataOffset + "; length = " + sopInstanceUidElement.length
#     $("#sopInstanceUidDataOffsetAndLength").text text
    
#     # The element also has some other properties that may or not be present:
#     # vr - the VR of the element.  Only available for explicit transfer syntaxes
#     # hadUndefinedLength - true if the element had an undefined length.
#     $("#sopInstanceUidVR").text sopInstanceUidElement.vr  if sopInstanceUidElement.vr isnt `undefined`
#   catch err
    
#     # we catch the error and display it to the user
#     $("#parseError").text err
#   return
# $(document).ready handleFileSelect
# # $("#study_dicom_file_upload").click "page:load", handleFileSelect
# # document.getElementById("study_dicom_file_upload").addEventListener 'change', handleFileSelect
# $(document).ready $("#study_dicom_file_upload").bind "click", handleFileSelect, false