{
  waste-cpus = {
    apiVersion = "apps/v1";
    kind = "deployment";
    metadata = {
      name = "waste-cpus";
      labels.app = "waste-cpus";
    };

    spec = {
      replicas = 10;
      selector.matchLabels.app = "waste-cpus";
      template = {
        metadata.labels.app = "waste-cpus";

        spec.containers = [
          {
            name = "waste-cpus";
            image = "ghcr.io/mehbark/waste-cpus";
          }
        ];
      };
    };
  };
}
