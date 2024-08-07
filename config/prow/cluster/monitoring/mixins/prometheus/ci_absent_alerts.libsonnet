{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'ci-absent',
        rules: [
          {
            alert: '%sDown' % name,
            expr: |||
              absent(up{job="%s"} == 1)
            ||| % name,
            'for': '10m',
            labels: {
              severity: 'critical',
              slo: name,
            },
            annotations: {
              message: 'The service %s has been down for 10 minutes.' % name,
            },
          }
          for name in $._config.ciAbsents.components
        ],
      },
    ],
  },
}
