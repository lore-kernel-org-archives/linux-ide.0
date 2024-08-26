Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81333C17
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686645; cv=none; b=A6NRNiak0D4RfjpylLLZj2dFL1+2h/ID9CUTAma7DxA5V/F3Gaw01+lhj+2BlHoi+kXYexuTISdYHv224k0gdC4Z6vdt7fk3udNMItr+ep5NSDrUmz2+SGc14LuGoSinjFcGyrM7lmKH2fm77p/mjn/qFp4EQERnyh9T0YBt6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686645; c=relaxed/simple;
	bh=FrX6KUuS+w0KBgjspnCWTsNT36mxKktfl5uGPRDSlSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESeyQQ5WMDHyBjcro5hssS1cpD4Xz4OdGvi+RUNI2o6jJCGhO8lj3U3oLpVN2A7yDlbweH3eEKHvqAb0xsuKYde0+JTWAIAso+0WzRyirBklS/vhqKkE+t6GN9F3/1Q7HI1S6Ie1Lypcuj350t0jR3EqsgBfqnrLtaPax89i4uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BymzO3lD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BymzO3lD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D75C52FD4;
	Mon, 26 Aug 2024 15:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724686645;
	bh=FrX6KUuS+w0KBgjspnCWTsNT36mxKktfl5uGPRDSlSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BymzO3lDfxwej+eE286Ac4+F0mn23KFPRRGXsvwIgO6jAghV2OTMfHYG4RIzR/clu
	 3SuULzGgkOW9RpzH99CEsNjXXRxIoVxI+0SQfhZF+9vswaKimATVgltOF2iuD1J+wd
	 eSsH1Grw1oHPgaXlZL2XEgJcue3EGZ56CbxLe3+bf7BhcXftuQRL9OzH4dR7d5jTJ6
	 0JHsbfVyQzuEX4Pwvx3Ie+X3+Bo9AetVJjC5XxEY9vAavlC3l8dQ9OuMjTCT/27sdH
	 RonhacPFf9AixKV3YFMT0aDIKoGLGDGT3SrgRfjKS1nB+8YGcokRI3fUwQUUOiayaG
	 Sfa6mKUobOlVw==
Date: Mon, 26 Aug 2024 17:37:21 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 7/7] ata: libata: Improve CDL resource management
Message-ID: <ZsyhMdG_Z1o5EbFv@ryzen.lan>
References: <20240826073106.56918-1-dlemoal@kernel.org>
 <20240826073106.56918-8-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826073106.56918-8-dlemoal@kernel.org>

On Mon, Aug 26, 2024 at 04:31:06PM +0900, Damien Le Moal wrote:
> The command duration limits (CDL) log buffer of struct ata_device is
> needed only if a device actually supports CDL. The same applies to the
> ncq_sense_log buffer.
> 
> Group these 2 buffers into a new structure ata_cdl defining both buffers
> as embedded buffers (no allocation needed) and allocate this structure
> from ata_dev_config_cdl() only for devices that support CDL.
> 
> The functions ata_dev_init_cdl_resources() and
> ata_dev_cleanup_cdl_resources() are defined to manage this new structure
> allocation, initialization and cleanup when a device is removed.
> ata_dev_cleanup_cdl_resources() is called from ata_tdev_free().
> 
> Note that the cdl log buffer name is changed to desc_log_buf to make it
> clearer what it is.
> 
> This change reduces the size of struct ata_device and reduces memory
> usage for ATA devices that do not support CDL.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Like previous comment, as long as sector_buf belongs to struct ata_port,
it seems a bit weird to keep this in struct ata_device.

Perhaps we can move sector_buf to struct ata_device?
(and modify the ata_read_log() functions to not take a buffer,
as the buffer would not be in the struct ata_device, which we already
supply to the ata_read_log() functions as the first argument.)


If we do that, then I think it is okay to keep a struct ata_cdl
in struct ata_device. Although I still don't like cleaning this
up in ata_tdev_() functions.

Perhaps we could call ata_device_cleanup()/ata_device_free_resource()
from ata_port_free() ?

ata_tport_release() will call ata_host_put().
ata_host_put() calls kref_put(&host->kref, ata_host_release);
ata_host_release() calls ata_port_free().

But ata_tport_add() is simply adding the sysfs entry IMO.

The sysfs entry takes a ata_host reference.
Once the refcount is zero, it will be freed.

Which is why I think that it makes more sense to clean this up in in
ata_port_free() (at least with the current design where the fixed size
ata_device array is part of struct ata_port (via struct ata_link)).


Perhaps something like:

void ata_port_free(struct ata_port *ap)
{
	....

	 ata_for_each_link (link, ap, ...) {
	 	ata_for_each_dev (dev, link, ...) {
			ata_device_cleanup(dev);
		}
	}
}


Kind regards,
Niklas


> ---
>  drivers/ata/libata-core.c      | 56 +++++++++++++++++++++-------------
>  drivers/ata/libata-sata.c      |  2 +-
>  drivers/ata/libata-scsi.c      |  2 +-
>  drivers/ata/libata-transport.c |  4 +--
>  drivers/ata/libata.h           |  1 +
>  include/linux/libata.h         | 18 +++++++++--
>  6 files changed, 54 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 6a1d300dd1f5..bcee96e29b34 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2475,12 +2475,41 @@ static void ata_dev_config_trusted(struct ata_device *dev)
>  		dev->flags |= ATA_DFLAG_TRUSTED;
>  }
>  
> +static int ata_dev_init_cdl_resources(struct ata_device *dev)
> +{
> +	struct ata_cdl *cdl = dev->cdl;
> +	unsigned int err_mask;
> +
> +	if (!cdl) {
> +		cdl = kzalloc(sizeof(struct ata_cdl), GFP_KERNEL);
> +		if (!cdl)
> +			return -ENOMEM;
> +		dev->cdl = cdl;
> +	}
> +
> +	err_mask = ata_read_log_page(dev, ATA_LOG_CDL, 0, cdl->desc_log_buf,
> +				     ATA_LOG_CDL_SIZE / ATA_SECT_SIZE);
> +	if (err_mask) {
> +		ata_dev_warn(dev, "Read Command Duration Limits log failed\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +void ata_dev_cleanup_cdl_resources(struct ata_device *dev)
> +{
> +	kfree(dev->cdl);
> +	dev->cdl = NULL;
> +}
> +
>  static void ata_dev_config_cdl(struct ata_device *dev)
>  {
>  	struct ata_port *ap = dev->link->ap;
>  	unsigned int err_mask;
>  	bool cdl_enabled;
>  	u64 val;
> +	int ret;
>  
>  	if (ata_id_major_version(dev->id) < 11)
>  		goto not_supported;
> @@ -2575,37 +2604,20 @@ static void ata_dev_config_cdl(struct ata_device *dev)
>  		}
>  	}
>  
> -	/*
> -	 * Allocate a buffer to handle reading the sense data for successful
> -	 * NCQ Commands log page for commands using a CDL with one of the limit
> -	 * policy set to 0xD (successful completion with sense data available
> -	 * bit set).
> -	 */
> -	if (!dev->ncq_sense_buf) {
> -		dev->ncq_sense_buf = kmalloc(ATA_LOG_SENSE_NCQ_SIZE, GFP_KERNEL);
> -		if (!dev->ncq_sense_buf)
> -			goto not_supported;
> -	}
> -
> -	/*
> -	 * Command duration limits is supported: cache the CDL log page 18h
> -	 * (command duration descriptors).
> -	 */
> -	err_mask = ata_read_log_page(dev, ATA_LOG_CDL, 0, ap->sector_buf, 1);
> -	if (err_mask) {
> -		ata_dev_warn(dev, "Read Command Duration Limits log failed\n");
> +	/* CDL is supported: allocate and initialize needed resources. */
> +	ret = ata_dev_init_cdl_resources(dev);
> +	if (ret) {
> +		ata_dev_warn(dev, "Initialize CDL resources failed\n");
>  		goto not_supported;
>  	}
>  
> -	memcpy(dev->cdl, ap->sector_buf, ATA_LOG_CDL_SIZE);
>  	dev->flags |= ATA_DFLAG_CDL;
>  
>  	return;
>  
>  not_supported:
>  	dev->flags &= ~(ATA_DFLAG_CDL | ATA_DFLAG_CDL_ENABLED);
> -	kfree(dev->ncq_sense_buf);
> -	dev->ncq_sense_buf = NULL;
> +	ata_dev_cleanup_cdl_resources(dev);
>  }
>  
>  static int ata_dev_config_lba(struct ata_device *dev)
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 50ea254a213d..e05fb09af061 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1505,7 +1505,7 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
>  {
>  	struct ata_device *dev = link->device;
>  	struct ata_port *ap = dev->link->ap;
> -	u8 *buf = dev->ncq_sense_buf;
> +	u8 *buf = dev->cdl->ncq_sense_log_buf;
>  	struct ata_queued_cmd *qc;
>  	unsigned int err_mask, tag;
>  	u8 *sense, sk = 0, asc = 0, ascq = 0;
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index a3ffce4b218d..7fed924d6561 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2259,7 +2259,7 @@ static inline u16 ata_xlat_cdl_limit(u8 *buf)
>  static unsigned int ata_msense_control_spgt2(struct ata_device *dev, u8 *buf,
>  					     u8 spg)
>  {
> -	u8 *b, *cdl = dev->cdl, *desc;
> +	u8 *b, *cdl = dev->cdl->desc_log_buf, *desc;
>  	u32 policy;
>  	int i;
>  
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index 14f50c91ceb9..add230c0d51e 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -671,9 +671,7 @@ static int ata_tdev_match(struct attribute_container *cont,
>   */
>  static void ata_tdev_free(struct ata_device *dev)
>  {
> -	kfree(dev->ncq_sense_buf);
> -	dev->ncq_sense_buf = NULL;
> -
> +	ata_dev_cleanup_cdl_resources(dev);
>  	transport_destroy_device(&dev->tdev);
>  	put_device(&dev->tdev);
>  }
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 5ca17784a350..df11f923e1a2 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -89,6 +89,7 @@ extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
>  extern const char *sata_spd_string(unsigned int spd);
>  extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>  				      u8 page, void *buf, unsigned int sectors);
> +void ata_dev_cleanup_cdl_resources(struct ata_device *dev);
>  
>  #define to_ata_port(d) container_of(d, struct ata_port, tdev)
>  
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 3fb6980c8aa1..37a5509adc77 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -700,6 +700,21 @@ struct ata_cpr_log {
>  	struct ata_cpr		cpr[] __counted_by(nr_cpr);
>  };
>  
> +struct ata_cdl {
> +	/*
> +	 * Buffer to cache the CDL log page 18h (command duration descriptors)
> +	 * for SCSI-ATA translation.
> +	 */
> +	u8			desc_log_buf[ATA_LOG_CDL_SIZE];
> +
> +	/*
> +	 * Buffer to handle reading the sense data for successful NCQ Commands
> +	 * log page for commands using a CDL with one of the limits policy set
> +	 * to 0xD (successful completion with sense data available bit set).
> +	 */
> +	u8			ncq_sense_log_buf[ATA_LOG_SENSE_NCQ_SIZE];
> +};
> +
>  struct ata_device {
>  	struct ata_link		*link;
>  	unsigned int		devno;		/* 0 or 1 */
> @@ -763,8 +778,7 @@ struct ata_device {
>  	struct ata_cpr_log	*cpr_log;
>  
>  	/* Command Duration Limits support */
> -	u8			*ncq_sense_buf;
> -	u8			cdl[ATA_LOG_CDL_SIZE];
> +	struct ata_cdl		*cdl;
>  
>  	/* error history */
>  	int			spdn_cnt;
> -- 
> 2.46.0
> 
