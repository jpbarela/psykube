require "../../kubernetes/concerns/mapping"
require "./claim"
require "../../kubernetes/pod/spec/volume"

class Psykube::Manifest::Volume::Spec
  alias KubeVolume = Kubernetes::Pod::Spec::Volume
  Kubernetes.mapping({
    host_path:               {type: KubeVolume::Source::HostPath, nilable: true, key: "hostPath"},
    empty_dir:               {type: KubeVolume::Source::EmptyDir, nilable: true, key: "emptyDir"},
    gce_persistent_disk:     {type: KubeVolume::Source::GcePersistentDisk, nilable: true, key: "gcePersistentDisk"},
    aws_elastic_block_store: {type: KubeVolume::Source::AwsElasticBlockStore, nilable: true, key: "awsElasticBlockStore"},
    git_repo:                {type: KubeVolume::Source::GitRepo, nilable: true, key: "gitRepo"},
    secret:                  {type: KubeVolume::Source::Secret, nilable: true},
    nfs:                     {type: KubeVolume::Source::Nfs, nilable: true},
    iscsi:                   {type: KubeVolume::Source::Iscsi, nilable: true},
    glusterfs:               {type: KubeVolume::Source::Glusterfs, nilable: true},
    persistent_volume_claim: {type: KubeVolume::Source::PersistentVolumeClaim, nilable: true, key: "persistentVolumeClaim"},
    rbd:                     {type: KubeVolume::Source::Rbd, nilable: true},
    flex_volume:             {type: KubeVolume::Source::FlexVolume, nilable: true, key: "flexVolume"},
    cinder:                  {type: KubeVolume::Source::Cinder, nilable: true},
    cephfs:                  {type: KubeVolume::Source::Cephfs, nilable: true},
    flocker:                 {type: KubeVolume::Source::Flocker, nilable: true},
    downward_api:            {type: KubeVolume::Source::DownwardAPI, nilable: true, key: "downwardAPI"},
    fc:                      {type: KubeVolume::Source::Fc, nilable: true},
    azure_file:              {type: KubeVolume::Source::AzureFile, nilable: true, key: "azureFile"},
    config_map:              {type: KubeVolume::Source::ConfigMap, nilable: true, key: "configMap"},
    vsphere_volume:          {type: KubeVolume::Source::VsphereVolume, nilable: true, key: "vsphereVolume"},
    quobyte:                 {type: KubeVolume::Source::Quobyte, nilable: true},
    azure_disk:              {type: KubeVolume::Source::AzureDisk, nilable: true, key: "azureDisk"},
  })

  def set_persistent_volume_claim(claim : Claim?, volume_name : String)
    persistent_volume_claim = KubeVolume::Source::PersistentVolumeClaim.new(volume_name, claim.read_only) if claim
  end

  def set_secret(items : String | Array(String) | KubeVolume::Source::Secret::KeyToPath, name : String)
    @secret = KubeVolume::Source::Secret.new(name, items)
  end

  def set_secret(secret : KubeVolume::Source::Secret?, name : String)
    self.secret = secret
  end

  def set_config_map(items : String | Array(String) | KubeVolume::Source::ConfigMap::KeyToPath, name : String)
    @config_map = KubeVolume::Source::ConfigMap.new(name, items)
  end

  def set_config_map(config_map : KubeVolume::Source::ConfigMap?, name : String)
    self.config_map = config_map
  end

  def to_deployment_volume(volume_name : String)
    KubeVolume.new(volume_name).tap do |kube_vol|
      kube_vol.host_path = self.host_path
      kube_vol.empty_dir = self.empty_dir
      kube_vol.gce_persistent_disk = self.gce_persistent_disk
      kube_vol.aws_elastic_block_store = self.aws_elastic_block_store
      kube_vol.git_repo = self.git_repo
      kube_vol.secret = self.secret
      kube_vol.nfs = self.nfs
      kube_vol.iscsi = self.iscsi
      kube_vol.glusterfs = self.glusterfs
      kube_vol.persistent_volume_claim = self.persistent_volume_claim
      kube_vol.rbd = self.rbd
      kube_vol.flex_volume = self.flex_volume
      kube_vol.cinder = self.cinder
      kube_vol.cephfs = self.cephfs
      kube_vol.flocker = self.flocker
      kube_vol.downward_api = self.downward_api
      kube_vol.fc = self.fc
      kube_vol.azure_file = self.azure_file
      kube_vol.config_map = self.config_map
      kube_vol.vsphere_volume = self.vsphere_volume
      kube_vol.quobyte = self.quobyte
      kube_vol.azure_disk = self.azure_disk
    end
  end
end
