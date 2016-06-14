require 'spec_helper'

describe 'watcher' do

  shared_examples 'watcher' do

    context 'with default parameters' do
      it 'contains the logging class' do
        is_expected.to contain_class('watcher::logging')
      end

      it 'contains the db class' do
        is_expected.to contain_class('watcher::db')
      end

      it 'configures rabbit' do
        is_expected.to contain_watcher_config('DEFAULT/rpc_backend').with_value('rabbit')
        is_expected.to contain_watcher_config('DEFAULT/transport_url').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_host').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_password').with_value('<SERVICE DEFAULT>').with_secret(true)
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_port').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_userid').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_login_method').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_virtual_host').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_retry_interval').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_retry_backoff').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_interval_max').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_max_retries').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_transient_queues_ttl').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/heartbeat_timeout_threshold').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/heartbeat_rate').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/kombu_compression').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('DEFAULT/transport_url').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('DEFAULT/rpc_response_timeout').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('DEFAULT/control_exchange').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_notifications/transport_url').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_notifications/driver').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_notifications/topics').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with overridden parameters' do
      let :params do
        {
          :default_transport_url              => 'rabbit://rabbit_user:password@localhost:5673',
          :rabbit_host                        => 'rabbit',
          :rabbit_userid                      => 'rabbit_user',
          :rabbit_port                        => '5673',
          :rabbit_password                    => 'password',
          :rabbit_ha_queues                   => 'undef',
          :rabbit_heartbeat_timeout_threshold => '60',
          :rabbit_heartbeat_rate              => '10',
          :kombu_compression                  => 'gzip',
          :notification_transport_url         => 'rabbit://rabbit_user:password@localhost:5673',
          :notification_topics                => 'notifications',
        }
      end
      it 'configures rabbit' do
        is_expected.to contain_watcher_config('DEFAULT/rpc_backend').with_value('rabbit')
        is_expected.to contain_watcher_config('DEFAULT/transport_url').with_value('rabbit://rabbit_user:password@localhost:5673')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_host').with_value('rabbit')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_password').with_value('password').with_secret(true)
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_port').with_value('5673')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_userid').with_value('rabbit_user')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_virtual_host').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/heartbeat_timeout_threshold').with_value('60')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/heartbeat_rate').with_value('10')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_login_method').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_retry_interval').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_retry_backoff').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_interval_max').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_max_retries').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_transient_queues_ttl').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/kombu_compression').with_value('gzip')
      end

      it 'configures various things' do
        is_expected.to contain_watcher_config('oslo_messaging_notifications/transport_url').with_value('rabbit://rabbit_user:password@localhost:5673')
        is_expected.to contain_watcher_config('oslo_messaging_notifications/topics').with_value('notifications')
      end

    end

    context 'with rabbit_hosts parameter' do
      let :params do
        { :rabbit_hosts => ['rabbit:5673', 'rabbit2:5674'] }
      end

      it 'configures rabbit' do
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_host').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_port').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_hosts').with_value('rabbit:5673,rabbit2:5674')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_ha_queues').with_value(true)
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_use_ssl').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/kombu_reconnect_delay').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/amqp_durable_queues').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with rabbit_hosts parameter (one server)' do
      let :params do
        { :rabbit_hosts => ['rabbit:5673'] }
      end

      it 'configures rabbit' do
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_host').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_port').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_hosts').with_value('rabbit:5673')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_ha_queues').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_use_ssl').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/kombu_reconnect_delay').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/amqp_durable_queues').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/kombu_missing_consumer_retry_timeout').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/kombu_failover_strategy').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with kombu_reconnect_delay set to 5.0' do
      let :params do
        { :kombu_reconnect_delay => '5.0' }
      end

      it 'configures rabbit' do
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/kombu_reconnect_delay').with_value('5.0')
      end
    end

    context 'with rabbit_ha_queues set to true' do
      let :params do
        { :rabbit_ha_queues => 'true' }
      end

      it 'configures rabbit' do
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_ha_queues').with_value(true)
      end
    end

    context 'with rabbit_ha_queues set to false and with rabbit_hosts' do
      let :params do
        { :rabbit_ha_queues => 'false',
          :rabbit_hosts => ['rabbit:5673'] }
      end

      it 'configures rabbit' do
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_ha_queues').with_value(false)
      end
    end

    context 'with amqp_durable_queues parameter' do
      let :params do
        { :rabbit_hosts => ['rabbit:5673'],
          :amqp_durable_queues => 'true' }
      end

      it 'configures rabbit' do
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_host').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_port').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_hosts').with_value('rabbit:5673')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_ha_queues').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_use_ssl').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/amqp_durable_queues').with_value(true)
      end
    end

    context 'with rabbit ssl enabled with kombu' do
      let :params do
        { :rabbit_hosts       => ['rabbit:5673'],
          :rabbit_use_ssl     => true,
          :kombu_ssl_ca_certs => '/etc/ca.cert',
          :kombu_ssl_certfile => '/etc/certfile',
          :kombu_ssl_keyfile  => '/etc/key',
          :kombu_ssl_version  => 'TLSv1', }
      end

      it 'configures rabbit' do
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_use_ssl').with_value(true)
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/kombu_ssl_ca_certs').with_value('/etc/ca.cert')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/kombu_ssl_certfile').with_value('/etc/certfile')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/kombu_ssl_keyfile').with_value('/etc/key')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/kombu_ssl_version').with_value('TLSv1')
      end
    end

    context 'with rabbit ssl enabled without kombu' do
      let :params do
        { :rabbit_hosts       => ['rabbit:5673'],
          :rabbit_use_ssl     => true, }
      end

      it 'configures rabbit' do
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/rabbit_use_ssl').with_value(true)
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/kombu_ssl_ca_certs').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/kombu_ssl_certfile').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/kombu_ssl_keyfile').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('oslo_messaging_rabbit/kombu_ssl_version').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with amqp rpc_backend' do
      let :params do
        { :rpc_backend => 'amqp' }
      end

      context 'with default parameters' do
        it 'configures amqp' do
          is_expected.to contain_watcher_config('DEFAULT/rpc_backend').with_value('amqp')
          is_expected.to contain_watcher_config('oslo_messaging_amqp/server_request_prefix').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('oslo_messaging_amqp/broadcast_prefix').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('oslo_messaging_amqp/group_request_prefix').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('oslo_messaging_amqp/container_name').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('oslo_messaging_amqp/idle_timeout').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('oslo_messaging_amqp/trace').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('oslo_messaging_amqp/ssl_ca_file').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('oslo_messaging_amqp/ssl_cert_file').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('oslo_messaging_amqp/ssl_key_file').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('oslo_messaging_amqp/ssl_key_password').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('oslo_messaging_amqp/allow_insecure_clients').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('oslo_messaging_amqp/sasl_mechanisms').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('oslo_messaging_amqp/sasl_config_dir').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('oslo_messaging_amqp/sasl_config_name').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('oslo_messaging_amqp/username').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('oslo_messaging_amqp/password').with_value('<SERVICE DEFAULT>')
        end
      end
    end

    context 'with overriden amqp parameters' do
      let :params do
        { :rpc_backend           => 'amqp',
          :default_transport_url => 'amqp://amqp_user:password@localhost:5672',
          :amqp_idle_timeout     => '60',
          :amqp_trace            => true,
          :amqp_ssl_ca_file      => '/etc/ca.cert',
          :amqp_ssl_cert_file    => '/etc/certfile',
          :amqp_ssl_key_file     => '/etc/key',
          :amqp_username         => 'amqp_user',
          :amqp_password         => 'password',
        }
      end

      it 'configures amqp' do
        is_expected.to contain_watcher_config('DEFAULT/rpc_backend').with_value('amqp')
        is_expected.to contain_watcher_config('DEFAULT/transport_url').with_value('amqp://amqp_user:password@localhost:5672')
        is_expected.to contain_watcher_config('oslo_messaging_amqp/idle_timeout').with_value('60')
        is_expected.to contain_watcher_config('oslo_messaging_amqp/trace').with_value('true')
        is_expected.to contain_watcher_config('oslo_messaging_amqp/ssl_ca_file').with_value('/etc/ca.cert')
        is_expected.to contain_watcher_config('oslo_messaging_amqp/ssl_cert_file').with_value('/etc/certfile')
        is_expected.to contain_watcher_config('oslo_messaging_amqp/ssl_key_file').with_value('/etc/key')
        is_expected.to contain_watcher_config('oslo_messaging_amqp/username').with_value('amqp_user')
        is_expected.to contain_watcher_config('oslo_messaging_amqp/password').with_value('password')
      end
    end

    context 'with zmq rpc_backend' do
      let :params do
        { :rpc_backend => 'zmq' }
      end

      context 'with default parameters' do
        it 'configures zmq' do
          is_expected.to contain_watcher_config('DEFAULT/rpc_cast_timeout').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('DEFAULT/rpc_poll_timeout').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_bind_address').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_bind_port_retries').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_concurrency').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_contexts').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_host').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_ipc_dir').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_matchmaker').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_max_port').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_min_port').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_topic_backlog').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('DEFAULT/use_pub_sub').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_watcher_config('DEFAULT/zmq_target_expire').with_value('<SERVICE DEFAULT>')
        end
      end
    end

    context 'with overriden zmq parameters' do
      let :params do
        { :rpc_backend               => 'zmq',
          :default_transport_url     => 'zmq://zmq_user:password@localhost:5555',
          :rpc_zmq_min_port          => '49200',
          :rpc_zmq_max_port          => '65000',
          :rpc_zmq_bind_port_retries => '120',
          :rpc_zmq_contexts          => '2',
          :rpc_zmq_host              => 'localhost',
        }
      end

      it 'configures zmq' do
        is_expected.to contain_watcher_config('DEFAULT/transport_url').with_value('zmq://zmq_user:password@localhost:5555')
        is_expected.to contain_watcher_config('DEFAULT/rpc_cast_timeout').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('DEFAULT/rpc_poll_timeout').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_bind_address').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_bind_port_retries').with_value('120')
        is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_concurrency').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_contexts').with_value('2')
        is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_host').with_value('localhost')
        is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_ipc_dir').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_matchmaker').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_max_port').with_value('65000')
        is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_min_port').with_value('49200')
        is_expected.to contain_watcher_config('DEFAULT/rpc_zmq_topic_backlog').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('DEFAULT/use_pub_sub').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_watcher_config('DEFAULT/zmq_target_expire').with_value('<SERVICE DEFAULT>')
      end
    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_behaves_like 'watcher'
    end
  end


end