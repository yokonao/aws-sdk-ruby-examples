require 'aws-sdk-sqs'

METADATA_REF =
  begin
    request_id =
      Seahorse::Model::Shapes::ShapeRef.new(shape: Seahorse::Model::Shapes::StringShape.new, location_name: 'RequestId')
    response_metadata = Seahorse::Model::Shapes::StructureShape.new
    response_metadata.struct_class = ::Struct.new(:request_id)
    response_metadata.add_member(:request_id, request_id)
    Seahorse::Model::Shapes::ShapeRef.new(shape: response_metadata, location_name: 'ResponseMetadata')
  end

def make_shape(context)
  shape = Seahorse::Model::Shapes::StructureShape.new
  shape.add_member(
    :result,
    Seahorse::Model::Shapes::ShapeRef.new(
      shape: context.operation.output.shape,
      location_name: context.operation.name + 'Result',
    ),
  )
  shape.struct_class = ::Struct.new(:result, :response_metadata)
  shape.add_member(:response_metadata, METADATA_REF)
  Seahorse::Model::Shapes::ShapeRef.new(shape: shape)
end

context = Aws::SQS::Client.new.build_request(:receive_message, queue_url: 'dummy').context
content = File.read('sqs-xml/dummy.xml')
puts Aws::Xml::Parser.new(make_shape(context)).parse(content)
