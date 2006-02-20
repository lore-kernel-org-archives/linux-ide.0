From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/7] libata: separate out ata_dev_read_id()
Date: Mon, 20 Feb 2006 05:35:19 -0500
Message-ID: <43F99B67.5050504@pobox.com>
References: <1139995449455-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:37585 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964854AbWBTKf1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 05:35:27 -0500
In-Reply-To: <1139995449455-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Separate out ata_dev_read_id() from ata_dev_identify().  This is the
> first half of splitting ata_dev_identify().  ata_dev_read_id() will
> also be used for revalidation.  This patch does not make any behavior
> change.
> 
> ata_dev_read_id() doesn't modify any of libata-internal data
> structures.  It simply reads IDENTIFY page and returns error code on
> failure.  INIT_DEV_PARAMS and EDD wrong class code are also handled by
> this function.
> 
> Re-reading IDENTIFY after INIT_DEV_PARAMS is performed by jumping to
> retry: instead of calling ata_dev_reread_id().  This is done because
> 1. there's retry label anyway 2. ata_dev_reread_id() cannot be used
> anywhere else so there's no reason to keep it.
> 
> This function is probably the place to set transfer mode to PIO0
> before IDENTIFY.  However, reset -> identify -> init_dev_params order
> should be kept for pre-ATA4 devices so we cannot set transfer mode
> before IDENTIFY for them.  How do we know if a device is post-ATA4
> before IDENTIFY?
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/libata-core.c |  219 +++++++++++++++++++++++++++-----------------
>  1 files changed, 135 insertions(+), 84 deletions(-)
> 
> 44fd0f6a248de6216af9ee63ee1ccb2bb438bf7b
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index a435454..6de78d1 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -903,42 +903,37 @@ unsigned int ata_pio_need_iordy(const st
>  }
>  
>  /**
> - *	ata_dev_identify - obtain IDENTIFY x DEVICE page
> - *	@ap: port on which device we wish to probe resides
> - *	@device: device bus address, starting at zero
> - *
> - *	Following bus reset, we issue the IDENTIFY [PACKET] DEVICE
> - *	command, and read back the 512-byte device information page.
> - *	The device information page is fed to us via the standard
> - *	PIO-IN protocol, but we hand-code it here. (TODO: investigate
> - *	using standard PIO-IN paths)
> - *
> - *	After reading the device information page, we use several
> - *	bits of information from it to initialize data structures
> - *	that will be used during the lifetime of the ata_device.
> - *	Other data from the info page is used to disqualify certain
> - *	older ATA devices we do not wish to support.
> + *	ata_dev_read_id - Read ID data from the specified device
> + *	@ap: port on which target device resides
> + *	@dev: target device
> + *	@p_class: pointer to class of the target device (may be changed)
> + *	@post_reset: is this read ID post-reset?
> + *	@p_id: read IDENTIFY page (newly allocated)
> + *
> + *	Read ID data from the specified device.  ATA_CMD_ID_ATA is
> + *	performed on ATA devices and ATA_CMD_ID_ATAPI on ATAPI
> + *	devices.  This function also takes care of EDD signature
> + *	misreporting (to be removed once EDD support is gone) and
> + *	issues ATA_CMD_INIT_DEV_PARAMS for pre-ATA4 drives.
>   *
>   *	LOCKING:
> - *	Inherited from caller.  Some functions called by this function
> - *	obtain the host_set lock.
> + *	Kernel thread context (may sleep)
> + *
> + *	RETURNS:
> + *	0 on success, -errno otherwise.
>   */
> -
> -static void ata_dev_identify(struct ata_port *ap, unsigned int device)
> +static int ata_dev_read_id(struct ata_port *ap, struct ata_device *dev,
> +			   unsigned int *p_class, int post_reset, u16 **p_id)
>  {
> -	struct ata_device *dev = &ap->device[device];
> -	unsigned int major_version;
> -	unsigned long xfer_modes;
> +	unsigned int class = *p_class;
>  	unsigned int using_edd;
>  	struct ata_taskfile tf;
> -	unsigned int err_mask;
> -	int i, rc;
> +	unsigned int err_mask = 0;
> +	u16 *id;
> +	const char *reason;
> +	int rc;
>  
> -	if (!ata_dev_present(dev)) {
> -		DPRINTK("ENTER/EXIT (host %u, dev %u) -- nodev\n",
> -			ap->id, device);
> -		return;
> -	}
> +	DPRINTK("ENTER, host %u, dev %u\n", ap->id, dev->devno);
>  
>  	if (ap->ops->probe_reset ||
>  	    ap->flags & (ATA_FLAG_SRST | ATA_FLAG_SATA_RESET))
> @@ -946,34 +941,40 @@ static void ata_dev_identify(struct ata_
>  	else
>  		using_edd = 1;
>  
> -	DPRINTK("ENTER, host %u, dev %u\n", ap->id, device);
> -
> -	WARN_ON(dev->class != ATA_DEV_ATA && dev->class != ATA_DEV_ATAPI &&
> -		dev->class != ATA_DEV_NONE);
> +	ata_dev_select(ap, dev->devno, 1, 1); /* select device 0/1 */
>  
> -	ata_dev_select(ap, device, 1, 1); /* select device 0/1 */
> -
> -	dev->id = kmalloc(sizeof(dev->id[0]) * ATA_ID_WORDS, GFP_KERNEL);
> -	if (dev->id == NULL)
> +	id = kmalloc(sizeof(id[0]) * ATA_ID_WORDS, GFP_KERNEL);
> +	if (id == NULL) {
> +		rc = -ENOMEM;
> +		reason = "out of memory";
>  		goto err_out;
> +	}
>  
> -retry:
> -	ata_tf_init(ap, &tf, device);
> + retry:
> +	ata_tf_init(ap, &tf, dev->devno);
>  
> -	if (dev->class == ATA_DEV_ATA) {
> +	switch (class) {
> +	case ATA_DEV_ATA:
>  		tf.command = ATA_CMD_ID_ATA;
> -		DPRINTK("do ATA identify\n");
> -	} else {
> +		break;
> +	case ATA_DEV_ATAPI:
>  		tf.command = ATA_CMD_ID_ATAPI;
> -		DPRINTK("do ATAPI identify\n");
> +		break;
> +	default:
> +		rc = -ENODEV;
> +		reason = "unsupported class";
> +		goto err_out;
>  	}
>  
>  	tf.protocol = ATA_PROT_PIO;
>  
>  	err_mask = ata_exec_internal(ap, dev, &tf, DMA_FROM_DEVICE,
> -				     dev->id, sizeof(dev->id[0]) * ATA_ID_WORDS);
> +				     id, sizeof(id[0]) * ATA_ID_WORDS);
>  
>  	if (err_mask) {
> +		rc = -EIO;
> +		reason = "I/O error";
> +
>  		if (err_mask & ~AC_ERR_DEV)
>  			goto err_out;
>  
> @@ -988,25 +989,106 @@ retry:
>  		 * ATA software reset (SRST, the default) does not appear
>  		 * to have this problem.
>  		 */
> -		if ((using_edd) && (dev->class == ATA_DEV_ATA)) {
> +		if ((using_edd) && (class == ATA_DEV_ATA)) {
>  			u8 err = tf.feature;
>  			if (err & ATA_ABORTED) {
> -				dev->class = ATA_DEV_ATAPI;
> +				class = ATA_DEV_ATAPI;
>  				goto retry;
>  			}
>  		}
>  		goto err_out;
>  	}
>  
> -	swap_buf_le16(dev->id, ATA_ID_WORDS);
> +	swap_buf_le16(id, ATA_ID_WORDS);
>  
>  	/* print device capabilities */
>  	printk(KERN_DEBUG "ata%u: dev %u cfg "
>  	       "49:%04x 82:%04x 83:%04x 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
> -	       ap->id, device, dev->id[49],
> -	       dev->id[82], dev->id[83], dev->id[84],
> -	       dev->id[85], dev->id[86], dev->id[87],
> -	       dev->id[88]);
> +	       ap->id, dev->devno,
> +	       id[49], id[82], id[83], id[84], id[85], id[86], id[87], id[88]);
> +
> +	/* sanity check */
> +	if ((class == ATA_DEV_ATA) != ata_id_is_ata(id)) {
> +		rc = -EINVAL;
> +		reason = "device reports illegal type";
> +		goto err_out;
> +	}
> +
> +	if (post_reset && class == ATA_DEV_ATA) {
> +		/*
> +		 * The exact sequence expected by certain pre-ATA4 drives is:
> +		 * SRST RESET
> +		 * IDENTIFY
> +		 * INITIALIZE DEVICE PARAMETERS
> +		 * anything else..
> +		 * Some drives were very specific about that exact sequence.
> +		 */
> +		if (ata_id_major_version(id) < 4 || !ata_id_has_lba(id)) {
> +			err_mask = ata_dev_init_params(ap, dev);
> +			if (err_mask) {
> +				rc = -EIO;
> +				reason = "INIT_DEV_PARAMS failed";
> +				goto err_out;
> +			}
> +
> +			/* current CHS translation info (id[53-58]) might be
> +			 * changed. reread the identify device info.
> +			 */
> +			post_reset = 0;
> +			goto retry;
> +		}
> +	}
> +
> +	*p_class = class;
> +	*p_id = id;
> +	return 0;

I think you should order this patch before the dev->id[0] reworked patch.

In particular, "p_id = id" appears to stomp on the existing dev->id 
allocation.

	Jeff



