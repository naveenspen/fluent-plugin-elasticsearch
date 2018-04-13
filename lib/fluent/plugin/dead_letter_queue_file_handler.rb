# encoding: UTF-8

module Fluent::DeadLetterQueueFileHandler

  def handle_chunk_error(out_plugin, tag, error, time, record)
      begin
        @dlq_file.info({processed_at: Time.now.utc, tag: tag, error: "#{error.message}", time: time, record: record}.to_json)
      rescue=>e
        log.error("Error while trying to log and drop message from chunk '#{tag}' #{e.message}")
      end
  end

end
