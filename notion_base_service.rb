class NotionBaseService
  def initialize(notion_client)
    @notion_client = notion_client
  end

  def get_database(database_id)
    @notion_client.databases.retrieve(database_id: database_id)
  end

  def query_database(database_id, filter: nil, sorts: nil, start_cursor: nil, page_size: nil)
    @notion_client.databases.query(
      database_id: database_id,
      filter: filter,
      sorts: sorts,
      start_cursor: start_cursor,
      page_size: page_size
    )
  end
end