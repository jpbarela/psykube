require "./concerns/resource"

class Psykube::Kubernetes::PodTemplate
  include Resource
  definition("v1", "PodTemplate", {
    template: Template,
  })
end

require "./pod_template/*"
