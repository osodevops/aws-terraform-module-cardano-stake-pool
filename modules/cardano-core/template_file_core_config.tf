// Topology  template
data "template_file" "config_template" {
  template = <<EOF
{
  \"ApplicationName\": \"cardano-sl\",
  \"ApplicationVersion\": 0,
  \"GenesisFile\": \"shelley_testnet-genesis.json\",
  \"LastKnownBlockVersion-Alt\": 0,
  \"LastKnownBlockVersion-Major\": 0,
  \"LastKnownBlockVersion-Minor\": 0,
  \"Protocol\": \"TPraos\",
  \"RequiresNetworkMagic\": \"RequiresMagic\",
  \"TraceBlockFetchClient\": false,
  \"TraceBlockFetchDecisions\": false,
  \"TraceBlockFetchProtocol\": false,
  \"TraceBlockFetchProtocolSerialised\": false,
  \"TraceBlockFetchServer\": false,
  \"TraceChainDb\": true,
  \"TraceChainSyncBlockServer\": false,
  \"TraceChainSyncClient\": false,
  \"TraceChainSyncHeaderServer\": false,
  \"TraceChainSyncProtocol\": false,
  \"TraceDNSResolver\": true,
  \"TraceDNSSubscription\": true,
  \"TraceErrorPolicy\": true,
  \"TraceForge\": true,
  \"TraceHandshake\": false,
  \"TraceIpSubscription\": true,
  \"TraceLocalChainSyncProtocol\": false,
  \"TraceLocalErrorPolicy\": true,
  \"TraceLocalHandshake\": false,
  \"TraceLocalTxSubmissionProtocol\": false,
  \"TraceLocalTxSubmissionServer\": false,
  \"TraceMempool\": true,
  \"TraceMux\": false,
  \"TraceTxInbound\": false,
  \"TraceTxOutbound\": false,
  \"TraceTxSubmissionProtocol\": false,
  \"TracingVerbosity\": \"NormalVerbosity\",
  \"TurnOnLogMetrics\": true,
  \"TurnOnLogging\": true,
  \"ViewMode\": \"SimpleView\",
  \"defaultBackends\": [
    \"KatipBK\"
  ],
  \"defaultScribes\": [
    [
      \"FileSK\",
      \"${local.log_path}/node.log\"
    ]
  ],
  \"hasEKG\": 12788,
  \"hasPrometheus\": [
    \"127.0.0.1\",
    12798
  ],
  \"minSeverity\": \"Info\",
  \"options\": {
    \"mapBackends\": {
      \"cardano.node-metrics\": [
        \"EKGViewBK\",
        {
          \"kind\": \"UserDefinedBK\",
          \"name\": \"LiveViewBackend\"
        }
      ],
      \"cardano.node.BlockFetchDecision.peers\": [
        \"EKGViewBK\",
        {
          \"kind\": \"UserDefinedBK\",
          \"name\": \"LiveViewBackend\"
        }
      ],
      \"cardano.node.ChainDB.metrics\": [
        \"EKGViewBK\",
        {
          \"kind\": \"UserDefinedBK\",
          \"name\": \"LiveViewBackend\"
        }
      ],
      \"cardano.node.Forge.metrics\": [
        \"EKGViewBK\"
      ],
      \"cardano.node.metrics\": [
        \"EKGViewBK\",
        {
          \"kind\": \"UserDefinedBK\",
          \"name\": \"LiveViewBackend\"
        }
      ]
    },
    \"mapSubtrace\": {
      \"#ekgview\": {
        \"contents\": [
          [
            {
              \"contents\": \"cardano.epoch-validation.benchmark\",
              \"tag\": \"Contains\"
            },
            [
              {
                \"contents\": \".monoclock.basic.\",
                \"tag\": \"Contains\"
              }
            ]
          ],
          [
            {
              \"contents\": \"cardano.epoch-validation.benchmark\",
              \"tag\": \"Contains\"
            },
            [
              {
                \"contents\": \"diff.RTS.cpuNs.timed.\",
                \"tag\": \"Contains\"
              }
            ]
          ],
          [
            {
              \"contents\": \"#ekgview.#aggregation.cardano.epoch-validation.benchmark\",
              \"tag\": \"StartsWith\"
            },
            [
              {
                \"contents\": \"diff.RTS.gcNum.timed.\",
                \"tag\": \"Contains\"
              }
            ]
          ]
        ],
        \"subtrace\": \"FilterTrace\"
      },
      \"benchmark\": {
        \"contents\": [
          \"GhcRtsStats\",
          \"MonotonicClock\"
        ],
        \"subtrace\": \"ObservableTrace\"
      },
      \"cardano.epoch-validation.utxo-stats\": {
        \"subtrace\": \"NoTrace\"
      },
      \"cardano.node-metrics\": {
        \"subtrace\": \"Neutral\"
      },
      \"cardano.node.metrics\": {
        \"subtrace\": \"Neutral\"
      }
    }
  },
  \"rotation\": {
    \"rpKeepFilesNum\": 10,
    \"rpLogLimitBytes\": 5000000,
    \"rpMaxAgeHours\": 24
  },
  \"setupBackends\": [
    \"KatipBK\"
  ],
  \"setupScribes\": [
    {
      \"scFormat\": \"ScText\",
      \"scKind\": \"FileSK\",
      \"scName\": \"${local.log_path}/node.log\",
      \"scRotation\": null
    }
  ]
}
EOF
}