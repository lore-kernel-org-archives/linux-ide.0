From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH] libata: Export AHCI capabilities
Date: Fri, 17 Jul 2009 22:49:15 -0600
Message-ID: <4A61544B.5030403@gmail.com>
References: <1247854427-3315-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751523AbZGREr3@vger.kernel.org>
In-Reply-To: <1247854427-3315-1-git-send-email-mjg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

On 07/17/2009 12:13 PM, Matthew Garrett wrote:
> AHCI exports various capability bits that may be of interest to userspace
> such as whether the BIOS claims a port is hotpluggable or eSATA. Providing
> these via sysfs along with the version of the AHCI spec implemented by
> the host allows userspace to make policy decisions for things like ALPM.
>
> Signed-off-by: Matthew Garrett<mjg@redhat.com>
> ---
>   drivers/ata/ahci.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
>   1 files changed, 44 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 336eb1e..5a5c160 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -327,10 +327,24 @@ static ssize_t ahci_activity_store(struct ata_device *dev,
>   				   enum sw_activity val);
>   static void ahci_init_sw_activity(struct ata_link *link);
>
> +static ssize_t ahci_show_host_caps(struct device *dev,
> +				   struct device_attribute *attr, char *buf);
> +static ssize_t ahci_show_host_version(struct device *dev,
> +				      struct device_attribute *attr, char *buf);
> +static ssize_t ahci_show_port_cmd(struct device *dev,
> +				  struct device_attribute *attr, char *buf);
> +
> +DEVICE_ATTR(ahci_host_caps, S_IRUGO, ahci_show_host_caps, NULL);
> +DEVICE_ATTR(ahci_host_version, S_IRUGO, ahci_show_host_version, NULL);
> +DEVICE_ATTR(ahci_port_cmd, S_IRUGO, ahci_show_port_cmd, NULL);
> +
>   static struct device_attribute *ahci_shost_attrs[] = {
>   	&dev_attr_link_power_management_policy,
>   	&dev_attr_em_message_type,
>   	&dev_attr_em_message,
> +	&dev_attr_ahci_host_caps,
> +	&dev_attr_ahci_host_version,
> +	&dev_attr_ahci_port_cmd,
>   	NULL
>   };
>
> @@ -696,6 +710,36 @@ static void ahci_enable_ahci(void __iomem *mmio)
>   	WARN_ON(1);
>   }
>
> +static ssize_t ahci_show_host_caps(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct Scsi_Host *shost = class_to_shost(dev);
> +	struct ata_port *ap = ata_shost_to_port(shost);
> +	struct ahci_host_priv *hpriv = ap->host->private_data;
> +
> +	return sprintf(buf, "%x\n", hpriv->cap);
> +}
> +
> +static ssize_t ahci_show_host_version(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct Scsi_Host *shost = class_to_shost(dev);
> +	struct ata_port *ap = ata_shost_to_port(shost);
> +	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
> +
> +	return sprintf(buf, "%x\n", readl(mmio + HOST_VERSION));
> +}
> +
> +static ssize_t ahci_show_port_cmd(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct Scsi_Host *shost = class_to_shost(dev);
> +	struct ata_port *ap = ata_shost_to_port(shost);
> +	void __iomem *port_mmio = ahci_port_base(ap);
> +
> +	return sprintf(buf, "%x\n", readl(port_mmio + PORT_CMD));
> +}
> +
>   /**
>    *	ahci_save_initial_config - Save and fixup initial config values
>    *	@pdev: target PCI device

Surely there's a better format for exporting this information to 
userspace than making it parse out the bits from the raw register 
contents.. how about separate sysfs files for ESP, HPCP, etc? Or 
something more abstracted at a higher level that other drivers (if they 
have access to similar information) could use?
