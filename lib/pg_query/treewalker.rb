class PgQuery::ParserResult
  private

  def treewalker!(tree)
    nodes = [[tree.dup, []]]

    loop do
      parent_node, parent_location = nodes.shift

      case parent_node
      when Google::Protobuf::MessageExts
        parent_node.to_h.keys.each do |parent_field|
          node = parent_node[parent_field.to_s]
          location = parent_location + [parent_field]

          yield(parent_node, parent_field, node, location) if node.kind_of?(Google::Protobuf::MessageExts)

          nodes << [node, location] unless node.nil?
        end
      when Google::Protobuf::RepeatedField
        nodes += parent_node.map.with_index { |e, idx| [e, parent_location + [idx]] }
      end

      break if nodes.empty?
    end
  end

  def find_tree_location(tree, searched_location)
    treewalker! tree do |parent_node, parent_field, node, location|
      next unless location == searched_location
      yield(parent_node, parent_field, node)
    end
  end
end
