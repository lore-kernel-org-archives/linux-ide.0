Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039E52BD591
	for <linux-ide@vger.kernel.org>; Thu,  3 Jul 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751536201; cv=none; b=oZeciHAEmfjwWKtFeFmP7nX7dCGUISCPdHIf1RLFBVikLtneka6rQRKMTz0PDggQiBsOouYdSOSpbLnDB2qwgQAIOHZ/JFnf8jDQrZ29YVamE1keEL3ZQmlSAOXJZxwC5vk9E90ridxMtdoRc7JYGwXGykHhfr3JODg/5ALGAGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751536201; c=relaxed/simple;
	bh=9IxGM8BgbIbZjdrhUd2e7mkBQvb49L3C2MAqFg4ruGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLGnTSpmmBXiWhH9FEyxIqgzU1myFBiIsfYGVxZhEXmETR4EhjV89hX62Sx8wEg0LvQr1fk0Le6cPQLk9EQUVLEg+157w/ROcYUuookvhFpQ/tmSJCbFGg2Ei7c9KJS3PlSisD6SSVxwkM7Xf2caDUucp2AdwRd+1FspqDtv+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1UsFKF5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1UsFKF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1DFC4CEE3;
	Thu,  3 Jul 2025 09:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751536200;
	bh=9IxGM8BgbIbZjdrhUd2e7mkBQvb49L3C2MAqFg4ruGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J1UsFKF5noLvy1nimUHQH06HCiuHfSV5fLWChaQK2DaXGdo997YgQSyPlS4Frnih2
	 ANI2DcOoqmSaRyRM7pnMyQIL4QZxOj8zSCBQawS/1YJIdAVNl4KRoxr9MUjCF9y9UP
	 MQAOBXAYwysdibs8CNtypDpZId9sdUGAMB7Vd1X5AyTdfwRaX40oN2i75j8yQrk1Mo
	 61KSSY5ewZOExZpF1XGgC5uExZcxGv1+CCD9azieEa0xDtX+BN+hSQG2dcTKKTrxGy
	 QggMSmXOLrdzgPJOXV+T9hJSipM1eTX3vPnbcSIe5bXQYV2Rueb7DPKGMvFRNCEK9u
	 njDCf+ToqRVXg==
Date: Thu, 3 Jul 2025 11:49:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/3] ata: libata-core: Cache the general purpose log
 directory
Message-ID: <aGZSRX8K_0jUqZAj@ryzen>
References: <20250703071541.278243-1-dlemoal@kernel.org>
 <20250703071541.278243-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703071541.278243-2-dlemoal@kernel.org>

On Thu, Jul 03, 2025 at 04:15:39PM +0900, Damien Le Moal wrote:
> The function ata_log_supported() tests if a log page is supported by a
> device using the General Purpose Log Directory log page, which lists the
> size of all surported log pages. However, this log page is read from the
> device using ata_read_log_page() every time ata_log_supported() is
> called. That is not necessary.
> 
> Avoid reading the General Purpose Log Directory log page by caching its
> content in the gp_log_dir buffer defined as part of struct ata_device.
> The functions ata_read_log_directory() and ata_clear_log_directory() are
> introduced to manage this buffer. ata_clear_log_directory() zero-fill
> the gp_log_dir buffer every time ata_dev_configure() is called, that is,
> when the device is first scanned and when it is being revalidated.
> The function ata_log_supported() is modified to call
> ata_read_log_directory() instead of ata_read_log_page().
> 
> The function ata_read_log_directory() calls ata_read_log_page() to read
> the General Purpose Log Directory log page from the device only if the
> first 16-bits word of the log is not equal to 0x0001, that is, it is not
> equal to the ACS mandated value for the log version.
> 
> With this, the log page is read from the device only once for every
> ata_dev_configure() call. For instance, with pr_debug enabled, a call
> to ata_dev_configure() before this patch generates the following log
> page accesses:
> 
> ata3.00: read log page - log 0x0, page 0x0
> ata3.00: read log page - log 0x13, page 0x0
> ata3.00: read log page - log 0x0, page 0x0
> ata3.00: read log page - log 0x12, page 0x0
> ata3.00: read log page - log 0x0, page 0x0
> ata3.00: read log page - log 0x30, page 0x0
> ata3.00: read log page - log 0x30, page 0x8
> ata3.00: read log page - log 0x0, page 0x0
> ata3.00: read log page - log 0x0, page 0x0
> ata3.00: read log page - log 0x0, page 0x0
> ata3.00: read log page - log 0x30, page 0x0
> ata3.00: read log page - log 0x0, page 0x0
> ata3.00: read log page - log 0x30, page 0x0
> ata3.00: read log page - log 0x30, page 0x3
> ata3.00: read log page - log 0x30, page 0x4
> ata3.00: read log page - log 0x18, page 0x0
> 
> That is, the general purpose log directory page is read 7 times.
> With this patch applied, the number of accesses to this log page is
> reduced to one:
> 
> ata3.00: read log page - log 0x0, page 0x0
> ata3.00: read log page - log 0x13, page 0x0
> ata3.00: read log page - log 0x12, page 0x0
> ata3.00: read log page - log 0x30, page 0x0
> ata3.00: read log page - log 0x30, page 0x8
> ata3.00: read log page - log 0x30, page 0x0
> ata3.00: read log page - log 0x30, page 0x0
> ata3.00: read log page - log 0x30, page 0x3
> ata3.00: read log page - log 0x30, page 0x4
> ata3.00: read log page - log 0x18, page 0x0
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-core.c | 37 +++++++++++++++++++++++++++++++++++--
>  include/linux/libata.h    |  3 +++
>  2 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 7f6cebe61b33..806ff5cee2b4 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2154,14 +2154,44 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>  	return err_mask;
>  }
>  
> +static inline void ata_clear_log_directory(struct ata_device *dev)
> +{
> +	memset(dev->gp_log_dir, 0, ATA_SECT_SIZE);
> +}
> +
> +static int ata_read_log_directory(struct ata_device *dev)
> +{
> +	u16 version;
> +
> +	/* If the log page is already cached, do nothing. */
> +	version = get_unaligned_le16(&dev->gp_log_dir[0]);
> +	if (version == 0x0001)
> +		return 0;
> +
> +	if (ata_read_log_page(dev, ATA_LOG_DIRECTORY, 0, dev->gp_log_dir, 1)) {
> +		ata_clear_log_directory(dev);

Why do we need to clear the log here?

If we had something cached, we would have returned in the if-statement above
already.

And if the read failed, wouldn't the buffer be unmodified?

Since we are only reading a single sector, which is the smallest unit we
can read, I would expect the buffer to be unmodified on failure.

Is that an incorrect assumption?


> +		return -EIO;
> +	}
> +
> +	version = get_unaligned_le16(&dev->gp_log_dir[0]);
> +	if (version != 0x0001) {
> +		ata_dev_err(dev, "Invalid log directory version 0x%04x\n",
> +			    version);
> +		return -EINVAL;

Don't you want to call ata_clear_log_directory() here?


> +	}
> +
> +	return 0;
> +}
> +
>  static int ata_log_supported(struct ata_device *dev, u8 log)
>  {
>  	if (dev->quirks & ATA_QUIRK_NO_LOG_DIR)
>  		return 0;
>  
> -	if (ata_read_log_page(dev, ATA_LOG_DIRECTORY, 0, dev->sector_buf, 1))
> +	if (ata_read_log_directory(dev))
>  		return 0;
> -	return get_unaligned_le16(&dev->sector_buf[log * 2]);
> +
> +	return get_unaligned_le16(&dev->gp_log_dir[log * 2]);
>  }
>  
>  static bool ata_identify_page_supported(struct ata_device *dev, u8 page)
> @@ -2890,6 +2920,9 @@ int ata_dev_configure(struct ata_device *dev)
>  		return 0;
>  	}
>  
> +	/* Clear the general purpose log directory cache. */
> +	ata_clear_log_directory(dev);
> +
>  	/* Set quirks */
>  	dev->quirks |= ata_dev_quirks(dev);
>  	ata_force_quirks(dev);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 7462218312ad..78a4addc6659 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -761,6 +761,9 @@ struct ata_device {
>  		u32		gscr[SATA_PMP_GSCR_DWORDS]; /* PMP GSCR block */
>  	} ____cacheline_aligned;
>  
> +	/* General Purpose Log Directory log page */
> +	u8			gp_log_dir[ATA_SECT_SIZE] ____cacheline_aligned;

Why align this to a cacheline?

It shouldn't be needed for get_unaligned_le16() to work correctly.

Is it just to increase the chance of this being in the cache?

If so, do we really access this that often that it needs to be
cacheline aligned? (We mostly access it during probe time, no?)


Kind regards,
Niklas
