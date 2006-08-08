From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 2/2] libata: implement setting _SDD
Date: Tue, 8 Aug 2006 11:36:43 -0700
Message-ID: <20060808113643.5920d692.rdunlap@xenotime.net>
References: <1153899440.4957.62.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:18877 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750800AbWHHSeC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Aug 2006 14:34:02 -0400
Received: from midway.site ([71.117.253.75]) by xenotime.net for <linux-ide@vger.kernel.org>; Tue, 8 Aug 2006 11:33:59 -0700
In-Reply-To: <1153899440.4957.62.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, htejun@gmail.com, linux-ide@vger.kernel.org

On Wed, 26 Jul 2006 15:37:05 +0800 zhao, forrest wrote:

> 1 implement ata_acpi_push_id(), which is used to set _SDD
> 2 invoke ata_acpi_push_id() in ata_dev_configure()
> 
> 
> Signed-off-by: Zhao Forrest <forrest.zhao@intel.com>
> 
Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

However, don't some of the printk's need to be updated to use
the new printk macros with debugging levels?


> ---
> 
>  drivers/scsi/libata-acpi.c |   97 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/scsi/libata-core.c |    8 ++++
>  drivers/scsi/libata.h      |    5 ++
>  3 files changed, 110 insertions(+), 0 deletions(-)
> 
> a52b4e04c0b9467f0993ed4c367fcd575e6a936f
> diff --git a/drivers/scsi/libata-acpi.c b/drivers/scsi/libata-acpi.c
> index cf7eeb1..d0b7c44 100644
> --- a/drivers/scsi/libata-acpi.c
> +++ b/drivers/scsi/libata-acpi.c
> @@ -652,3 +652,100 @@ int ata_acpi_exec_tfs(struct ata_port *a
>  }
>  EXPORT_SYMBOL_GPL(ata_acpi_exec_tfs);
>  
> +/**
> + * ata_acpi_push_id - send Identify data to a drive
> + * @ap: the ata_port for the drive
> + * @ix: drive index
> + *
> + * _SDD ACPI object:  for SATA mode only.
> + * Must be after Identify (Packet) Device -- uses its data.
> + */
> +int ata_acpi_push_id(struct ata_port *ap, unsigned int ix)
> +{
> +	acpi_handle			handle;
> +	acpi_integer			pcidevfn;
> +	int				err = -ENODEV;
> +	struct device			*dev = ap->host_set->dev;
> +	struct ata_device		*atadev = &ap->device[ix];
> +	u32				dev_adr;
> +	acpi_status			status;
> +	struct acpi_object_list		input;
> +	union acpi_object 		in_params[1];
> +
> +	if (noacpi)
> +		return 0;
> +
> +	if (!(ap->flags & ATA_FLAG_SATA)) {
> +		printk(KERN_DEBUG "%s: skipping for PATA mode\n",
> +			__FUNCTION__);
> +		return 0;
> +	}
> +
> +	if (ata_msg_probe(ap))
> +		printk(KERN_DEBUG
> +			"%s: ap->id: %d, ix = %d, port#: %d, hard_port#: %d\n",
> +			__FUNCTION__, ap->id, ix,
> +			ap->port_no, ap->hard_port_no);
> +
> +	/* Don't continue if not a SATA device. */
> +	if (!ata_id_is_sata(atadev->id)) {
> +		if (ata_msg_probe(ap))
> +			printk(KERN_DEBUG "%s: ata_id_is_sata is False\n",
> +				__FUNCTION__);
> +		goto out;
> +	}
> +
> +	/* Don't continue if device has no _ADR method.
> +	 * _SDD is intended for known motherboard devices. */
> +	err = sata_get_dev_handle(dev, &handle, &pcidevfn);
> +	if (err < 0) {
> +		if (ata_msg_probe(ap))
> +			printk(KERN_DEBUG
> +				"%s: sata_get_dev_handle failed (%d\n",
> +				__FUNCTION__, err);
> +		goto out;
> +	}
> +
> +	/* Get this drive's _ADR info. if not already known. */
> +	if (!atadev->obj_handle) {
> +		dev_adr = SATA_ADR_RSVD;
> +		err = get_sata_adr(dev, handle, pcidevfn, ix, ap, atadev,
> +				&dev_adr);
> +		if (err < 0 || dev_adr == SATA_ADR_RSVD ||
> +		    !atadev->obj_handle) {
> +			if (ata_msg_probe(ap))
> +				printk(KERN_DEBUG "%s: get_sata_adr failed: "
> +					"err=%d, dev_adr=%u, obj_handle=0x%p\n",
> +					__FUNCTION__, err, dev_adr,
> +					atadev->obj_handle);
> +			goto out;
> +		}
> +	}
> +
> +	/* Give the drive Identify data to the drive via the _SDD method */
> +	/* _SDD: set up input parameters */
> +	input.count = 1;
> +	input.pointer = in_params;
> +	in_params[0].type = ACPI_TYPE_BUFFER;
> +	in_params[0].buffer.length = sizeof(atadev->id);
> +	in_params[0].buffer.pointer = (u8 *)atadev->id;
> +	/* Output buffer: _SDD has no output */
> +
> +	/* It's OK for _SDD to be missing too. */
> +	swap_buf_le16(atadev->id, ATA_ID_WORDS);
> +	status = acpi_evaluate_object(atadev->obj_handle, "_SDD", &input, NULL);
> +	swap_buf_le16(atadev->id, ATA_ID_WORDS);
> +
> +	err = ACPI_FAILURE(status) ? -EIO : 0;
> +	if (err < 0) {
> +		if (ata_msg_probe(ap))
> +			printk(KERN_DEBUG
> +				"ata%u(%u): %s _SDD error: status = 0x%x\n",
> +				ap->id, ap->device->devno,
> +				__FUNCTION__, status);
> +	}
> +out:
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(ata_acpi_push_id);
> +
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index cd4cf97..1c60369 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -1505,6 +1505,14 @@ int ata_dev_configure(struct ata_device 
>  	if (ap->ops->dev_config)
>  		ap->ops->dev_config(ap, dev);
>  
> +	/* set _SDD */
> +	rc = ata_acpi_push_id(ap, dev->devno);
> +	if (rc) {
> +		ata_dev_printk(dev, KERN_WARNING, "failed to set _SDD(%d)\n",
> +				rc);
> +		goto err_out_nosup;
> +	}
> +
>  	if (ata_msg_probe(ap))
>  		ata_dev_printk(dev, KERN_DEBUG, "%s: EXIT, drv_stat = 0x%x\n",
>  			__FUNCTION__, ata_chk_status(ap));


---
~Randy
