require "./concerns/resource"

class Psykube::Kubernetes::PersistentVolume
  include Resource
  definition("v1", "PersistentVolume", {
    spec:   Spec?,
    status: {type: Status, nilable: true, clean: true},
  })
end

require "./persistent_volume/*"
