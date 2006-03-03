From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/4] libata: implement ata_dev_revalidate()
Date: Fri, 03 Mar 2006 17:39:23 -0500
Message-ID: <4408C59B.4040509@pobox.com>
References: <11412012391678-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:10391 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751011AbWCCWj0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Mar 2006 17:39:26 -0500
In-Reply-To: <11412012391678-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> ata_dev_revalidate() re-reads IDENTIFY PAGE of the given device and
> makes sure it's the same device as the configured one.  Once it's
> verified that it's the same device, @dev is configured according to
> newly read IDENTIFY PAGE.  Note that revalidation currently doesn't
> invoke transfer mode reconfiguration.
> 
> Criteria for 'same device'
> 
> * same class (of course)
> * same model string
> * same serial string
> * if ATA, same n_sectors (to catch geometry parameter changes)
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/libata-core.c |  115 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/libata.h     |    2 +
>  2 files changed, 117 insertions(+), 0 deletions(-)
> 
> 5f157f520bce43bee189d18e0736065ce7997334
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 64e087b..d599e8f 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -2341,6 +2341,120 @@ int ata_drive_probe_reset(struct ata_por
>  	return rc;
>  }
>  
> +/**
> + *	ata_dev_same_device - Determine whether new ID matches configured device
> + *	@ap: port on which the device to compare against resides
> + *	@dev: device to compare against
> + *	@new_class: class of the new device
> + *	@new_id: IDENTIFY page of the new device
> + *
> + *	Compare @new_class and @new_id against @dev and determine
> + *	whether @dev is the device indicated by @new_class and
> + *	@new_id.
> + *
> + *	LOCKING:
> + *	None.
> + *
> + *	RETURNS:
> + *	1 if @dev matches @new_class and @new_id, 0 otherwise.
> + */
> +static int ata_dev_same_device(struct ata_port *ap, struct ata_device *dev,
> +			       unsigned int new_class, const u16 *new_id)
> +{
> +	const u16 *old_id = dev->id;
> +	unsigned char model[2][41], serial[2][21];
> +	u64 new_n_sectors;
> +
> +	if (dev->class != new_class) {
> +		printk(KERN_WARNING
> +		       "ata%u: dev %u class mismatch %d != %d\n",
> +		       ap->id, dev->devno, dev->class, new_class);
> +		return 0;
> +	}
> +
> +	ata_id_c_string(old_id, model[0], ATA_ID_PROD_OFS, sizeof(model[0]));
> +	ata_id_c_string(new_id, model[1], ATA_ID_PROD_OFS, sizeof(model[1]));
> +	ata_id_c_string(old_id, serial[0], ATA_ID_SERNO_OFS, sizeof(serial[0]));
> +	ata_id_c_string(new_id, serial[1], ATA_ID_SERNO_OFS, sizeof(serial[1]));
> +	new_n_sectors = ata_id_n_sectors(new_id);
> +
> +	if (strcmp(model[0], model[1])) {
> +		printk(KERN_WARNING
> +		       "ata%u: dev %u model number mismatch '%s' != '%s'\n",
> +		       ap->id, dev->devno, model[0], model[1]);
> +		return 0;
> +	}
> +
> +	if (strcmp(serial[0], serial[1])) {
> +		printk(KERN_WARNING
> +		       "ata%u: dev %u serial number mismatch '%s' != '%s'\n",
> +		       ap->id, dev->devno, serial[0], serial[1]);
> +		return 0;
> +	}
> +
> +	if (dev->class == ATA_DEV_ATA && dev->n_sectors != new_n_sectors) {
> +		printk(KERN_WARNING
> +		       "ata%u: dev %u n_sectors mismatch %llu != %llu\n",
> +		       ap->id, dev->devno, (unsigned long long)dev->n_sectors,
> +		       (unsigned long long)new_n_sectors);
> +		return 0;
> +	}
> +
> +	return 1;

For the hotplug case, its inaccurate to call these warnings.


> + *	ata_dev_revalidate - Revalidate ATA device
> + *	@ap: port on which the device to revalidate resides
> + *	@dev: device to revalidate
> + *	@post_reset: is this revalidation after reset?
> + *
> + *	Re-read IDENTIFY page and make sure @dev is still attached to
> + *	the port.
> + *
> + *	LOCKING:
> + *	Kernel thread context (may sleep)
> + *
> + *	RETURNS:
> + *	0 on success, negative errno otherwise
> + */
> +int ata_dev_revalidate(struct ata_port *ap, struct ata_device *dev,
> +		       int post_reset)
> +{
> +	unsigned int class;
> +	u16 *id;
> +	int rc;
> +
> +	if (!ata_dev_present(dev))
> +		return 0;

I would think the proper return value for this case is -ENODEV.

Otherwise OK.

	Jeff


