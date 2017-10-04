class CreateKudos < Rectify::Command
  def initialize(form)
    @form = form
  end

  def call
    return broadcast(:invalid) if @form.invalid?
    transaction do
      @kudo = create_kudo
      create_kudos_receivers
    end

    broadcast(:ok, kudo)
  end

  private

  attr_reader :form, :kudo

  def create_kudo
    Kudo.create!(description: @form.description, sender_id: current_user.id)
  end

  def create_kudos_receivers
    @form.receivers_ids.each do |id|
      KudosReceiver.create!(user_id: id, kudo: @kudo)
    end
  end
end
