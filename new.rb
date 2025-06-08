class NotionCreatePageService
  def initialize(notion_client, database_id, page_data)
    @notion_client = notion_client
    @database_id = database_id
    @page_data = page_data
  end

  def call
    @notion_client.pages.create(
      parent: { database_id: @database_id },
      properties: @page_data[:properties],
      children: @page_data[:children]
    )
  end
end