# Simple python class for creating events and pushing them to a Kafka topic
# Can be easily modified to talk to a topic on Confluent Cloud Platform, just change
# the connection details
from confluent_kafka import Producer
import json
import sys

p = Producer({
    'bootstrap.servers': 'localhost:9092',
    'broker.version.fallback': '0.10.0.0',
    'api.version.fallback.ms': 0
})

def acked(err, msg):
    """Delivery report callback called (from flush()) on successful or failed delivery of the message."""
    if err is not None:
        print('Failed to deliver message: {}'.format(err.str()))
    else:
        print('Produced to: {} [{}] @ {}'.format(msg.topic(), msg.partition(), msg.offset()))


for line in sys.stdin:
    # Produce message: this is an asynchronous operation.
    # Upon successful or permanently failed delivery to the broker the
    # callback will be called to propagate the produce result.
    # The delivery callback is triggered from poll() or flush().
    # For long running
    # produce loops it is recommended to call poll() to serve these
    # delivery report callbacks.
    p.produce('mytopic', value=json.dumps(line),
              callback=acked)

    # Trigger delivery report callbacks from previous produce calls.
    p.poll(0)

# flush() is typically called when the producer is done sending messages to wait
# for outstanding messages to be transmitted to the broker and delivery report
# callbacks to get called. For continous producing you should call p.poll(0)
# after each produce() call to trigger delivery report callbacks.
p.flush(10)