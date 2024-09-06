Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860435FB9C
	for <linux-ide@vger.kernel.org>; Fri,  6 Sep 2024 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612704; cv=none; b=qtSd3t7wwu6wlL4UTaiS3ixbZa2mF6aVUOi2bR/4V8lUotCGArffa1r5ElZhDTITrBMMA1M2Ixaq0ZTOFpCHVTWC1OKVjAwchQdk3/y5C2eTFLDpXNv4RGllFz4wnEE1gVKYftrinZ2JrRuLLRMbFJmRzdioYYX/NWGxw8uGV9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612704; c=relaxed/simple;
	bh=RWEb9iN2YDff9VXitr+v5L7MabZ7CGPc19o4KzBNX7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7s9QOrdWmkqMwbEwGYQX8vqvg268HDoTTx/qSqzIYeojpDIfosjHjBJxtGCok5/SGy+oGoZ4Wgq7IT6z3xIRQB7hP3IdeUB5FNJT0+bujj3fR2yUc+DXsBhB5IJ0tDSTCfuWF+snzNShDCavNlaxMoK1142xRUqI1Vev9mX4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgS+V8n0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgS+V8n0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5871FC4CEC4;
	Fri,  6 Sep 2024 08:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725612704;
	bh=RWEb9iN2YDff9VXitr+v5L7MabZ7CGPc19o4KzBNX7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgS+V8n0YHDXroKpqr/N8yzbNPuwscrv5CltDGGTjJwohuFAbTK24trAu32TTBSL9
	 U3cLl18SsK4tTia/3JubjWzLHtIpUAtI51yDxMIGoocwut1n3ZvBZDMIIGc1nuWN7B
	 iLR/1Mq1wsGTmFjICzSGUujwGIY8UOQepYLgxkYmWXO1hk7KWoEd0vBuVb7lzl2VMK
	 VJXSnK0/59B6edXZwQasvsVOCo1qeupj1efzoki8GyOqn+R+0ANAN1F/iuF8eQoPk9
	 nuPrK9icgHuI9tmlKbVcT1pF1gfhx3FzMIrUUQh7dnLgjU4AZS/1aUp/SsVgN065Hl
	 2aWsApK98qKIg==
Date: Fri, 6 Sep 2024 10:51:40 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v5 9/9] ata: libata: Improve CDL resource management
Message-ID: <ZtrCnMOLAfR5uoUz@ryzen.lan>
References: <20240906015847.229539-1-dlemoal@kernel.org>
 <20240906015847.229539-10-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906015847.229539-10-dlemoal@kernel.org>

On Fri, Sep 06, 2024 at 10:58:47AM +0900, Damien Le Moal wrote:
> The ncq_sense_buf buffer field of struct ata_port is allocated and used
> only for devices that support the Command Duration Limits (CDL) feature.
> However, the cdl buffer of struct ata_device, which is used to cache the
> command duration limits log page for devices supporting CDL is always
> allocated as part of struct ata_device, which is wasteful of memory for
> devices that do not support this feature.
> 
> Clean this up by defining both buffers as part of the new ata_cdl
> structure and allocating this structure only for devices that support
> the CDL feature. This new structure is attached to struct ata_device
> using the cdl pointer.
> 
> The functions ata_dev_init_cdl_resources() and
> ata_dev_cleanup_cdl_resources() are defined to manage this new structure
> allocation, initialization and freeing when a port is removed or a
> device disabled. ata_dev_init_cdl_resources() is called from
> ata_dev_config_cdl() only for devices that support CDL.
> ata_dev_cleanup_cdl_resources() is called from ata_dev_free_resources()
> to free the ata_cdl structure when a device is being disabled by EH.
> 
> Note that the name of the former cdl log buffer of struct ata_device is
> changed to desc_log_buf to make it clearer that it is a buffer for the
> limit descriptors log page.
> 
> This change reduces the size of struct ata_device, thus reducing memory
> usage for ATA devices that do not support the CDL feature.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-core.c | 60 +++++++++++++++++++++++----------------
>  drivers/ata/libata-sata.c |  2 +-
>  drivers/ata/libata-scsi.c |  2 +-
>  drivers/ata/libata.h      |  1 +
>  include/linux/libata.h    | 21 +++++++++++---
>  5 files changed, 56 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index bfd452b0d46d..bd2f8e442b14 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2464,12 +2464,40 @@ static void ata_dev_config_trusted(struct ata_device *dev)
>  		dev->flags |= ATA_DFLAG_TRUSTED;
>  }
>  
> +static int ata_dev_init_cdl_resources(struct ata_device *dev)
> +{
> +	struct ata_cdl *cdl = dev->cdl;
> +	unsigned int err_mask;
> +
> +	if (!cdl) {
> +		cdl = kzalloc(sizeof(*cdl), GFP_KERNEL);
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

Usually when a function return error, you expect it to have freed the
resources that it might have allocated, so perhaps free and set
dev->cdl to NULL here.


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
> -	struct ata_port *ap = dev->link->ap;
>  	unsigned int err_mask;
>  	bool cdl_enabled;
>  	u64 val;
> +	int ret;
>  
>  	if (ata_id_major_version(dev->id) < 11)
>  		goto not_supported;
> @@ -2564,37 +2592,20 @@ static void ata_dev_config_cdl(struct ata_device *dev)
>  		}
>  	}
>  
> -	/*
> -	 * Allocate a buffer to handle reading the sense data for successful
> -	 * NCQ Commands log page for commands using a CDL with one of the limit
> -	 * policy set to 0xD (successful completion with sense data available
> -	 * bit set).
> -	 */
> -	if (!ap->ncq_sense_buf) {
> -		ap->ncq_sense_buf = kmalloc(ATA_LOG_SENSE_NCQ_SIZE, GFP_KERNEL);
> -		if (!ap->ncq_sense_buf)
> -			goto not_supported;
> -	}
> -
> -	/*
> -	 * Command duration limits is supported: cache the CDL log page 18h
> -	 * (command duration descriptors).
> -	 */
> -	err_mask = ata_read_log_page(dev, ATA_LOG_CDL, 0, dev->sector_buf, 1);
> -	if (err_mask) {
> -		ata_dev_warn(dev, "Read Command Duration Limits log failed\n");
> +	/* CDL is supported: allocate and initialize needed resources. */
> +	ret = ata_dev_init_cdl_resources(dev);
> +	if (ret) {
> +		ata_dev_warn(dev, "Initialize CDL resources failed\n");
>  		goto not_supported;
>  	}
>  
> -	memcpy(dev->cdl, dev->sector_buf, ATA_LOG_CDL_SIZE);
>  	dev->flags |= ATA_DFLAG_CDL;
>  
>  	return;
>  
>  not_supported:
>  	dev->flags &= ~(ATA_DFLAG_CDL | ATA_DFLAG_CDL_ENABLED);
> -	kfree(ap->ncq_sense_buf);
> -	ap->ncq_sense_buf = NULL;
> +	ata_dev_cleanup_cdl_resources(dev);

Considering that you now do ata_dev_init_cdl_resources() at the end,
if you implement my suggestion above, we can remove the call to
ata_dev_cleanup_cdl_resources() here, since we will only jump here
if the ata_dev_init_cdl_resources() call failed.

Either way:
Reviewed-by: Niklas Cassel <cassel@kernel.org>


>  }
>  
>  static int ata_dev_config_lba(struct ata_device *dev)
