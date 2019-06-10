class MessageDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      subject: { source: "Message.subject", cond: :like },
      from: { source: "Message.from", cond: :like },
      created_at: { source: "Message.created_at"},
      profile_id: { source: "Message.profile_id"}
    }
  end

  def data
    records.map do |record|
      {
        id:       record.id,
        from:     link_to(record.from, record, class: 'text-info'),
        subject:  link_to(record.subject, record, class: 'text-info'),
        profile_id:  link_to(record.profile.name, record.profile, class: 'text-info'),
        created_at: record.created_at.strftime('%H:%M %d/%m/%Y'),
        DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    user = User.find params["user_id"]
    user.messages.order(created_at: :desc)
  end

end