class GroupMailer < ApplicationMailer
  def notice_event(group, subject, body)
    @group = group
    @body = body
    mail(
      to: group.all_members.map(&:email),
      subject: subject
    )
  end
end