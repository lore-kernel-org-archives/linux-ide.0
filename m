Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B414B37B007;
	Mon, 11 May 2026 22:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537277; cv=none; b=IdgNxbIi5aoejusCOzJUTG53z/+COoEbi02pE6mZy2T8tefQslThdgHSKDhqT/IbZT2HJyO6STSAVKdt4iNkmsp+vCWQ8nZiiJfkcZA+3OsFIw8nv7egH5wnLksGDJWgTFbPzYXB80eSyp9sbs5HxRYfs5cSGD3Ot4IT6zs8tmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537277; c=relaxed/simple;
	bh=pvx7x1V77MTDg+u0JmyQgUV4QD0pZSlFMY2VJqyLjaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjN5evhcGKDHD6r1690ZMvjgOVc7aYzI76IL23ilkuP9QhkhrGcgVL4Hp0PoHUjw6U6XLPUQ5zwI27AsEZnyrd+HZW1hLUTzlP680yZldoz7ordrwfBNfmBKORH4h0H3zmiCChs2Z49jfSK6HrY9LYJwk7ICv4uKZVXHfHeT22U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFfYBiEX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFfYBiEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B736C2BCB0;
	Mon, 11 May 2026 22:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778537277;
	bh=pvx7x1V77MTDg+u0JmyQgUV4QD0pZSlFMY2VJqyLjaw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tFfYBiEXxlO2H6zMt40lA8ahTvzRSZ+XhuqgCDhHBrDz9Bj5L9hm2iDVj1IrZRhsn
	 oIvLPnhIEJvgEoLgW2JRvDokvDsi/xCGbEHWbCAsyZ1s56bGThB9d4BN8WQOYPaTYy
	 UvhD9568IZzUpNVVc2hO4jMuKhm/8UGRYMPYJk79+2tFI/cXU4pwNJTA8aV4NLNWju
	 6mbqwMW9U9fF9lCq1uJxjuZ5VOcB37/qtxIlVUE85c/4PtGd9a5jAmNsTt9OugGpZv
	 noRwXqnlqtHdwqDbEC4YWKQIkThvE2WJ7qmuMf6eYt0UwOW943jofxPtAv05Ewk/2F
	 hpWcDbW4r+TWg==
Message-ID: <c59c5d0f-6eb9-4fdd-851d-c6d5ba3a9cf8@kernel.org>
Date: Tue, 12 May 2026 07:07:54 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libata: disable device after repeated media errors
To: Chaohai Chen <wdhh6@aliyun.com>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>
References: <20260430073417.1803833-1-wdhh6@aliyun.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260430073417.1803833-1-wdhh6@aliyun.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/26 16:34, Chaohai Chen wrote:
> When a SATA device (particularly those behind SAS HBAs using libsas)
> hits unrecoverable media errors, it can trigger an infinite EH loop:
> the device returns medium error, libata performs a hard reset (which
> succeeds since the device is functional), then the upper layer retries
> the read to the same bad sector, triggering another EH cycle.

This loop is *not* infinite. By default, commands will be retried 5 times at
most. The loop may seem infinite if the device user, despite receiving I/O
errors, continues trying accessing the bad area of the disk.

> This loop is particularly harmful for SATA devices behind SAS HBAs
> because all devices sharing the same Scsi_Host are blocked during
> SHOST_RECOVERY, not just the faulty device.

This is a different issue, which is that SCSI EH is a very big hammer that
operates on the host instead of on only the device that is the source of an
error, when the error at hand concerns only the device (which is the case for a
media access error).

> Fix this by tracking media error frequency per device. If a device
> triggers more than media_err_limit (default 10) media errors within
> a media_err_window (default 60 seconds), disable the device. This
> allows the SCSI layer to offline the faulty device and restore I/O
> to healthy devices on the same HBA.

That is not acceptable. The reason is that disabling and dropping the device
prevents any sort of forensic/debugging or recovery (e.g. with head depop) of
the device. So no on this.

A better approach would be to modernize/improve SCSI EH to be more fine grained
and operate on a single device only when the error allows. Some work was
on-going on this, but I do not think it is completed yet.

John, Hannes,

I lost track... Did you see any progress with the SCSI EH improvements ?

> 
> The parameters are exposed via sysfs for runtime tuning:
>   /sys/class/ata_device/devX.Y/media_err_limit  (rw, 0=disable)
>   /sys/class/ata_device/devX.Y/media_err_window (rw, seconds)
>   /sys/class/ata_device/devX.Y/media_err_count  (ro, current count)
> 
> Signed-off-by: Chaohai Chen <wdhh6@aliyun.com>
> ---
>  drivers/ata/libata-core.c      |  2 +
>  drivers/ata/libata-eh.c        | 35 ++++++++++++++++
>  drivers/ata/libata-transport.c | 76 ++++++++++++++++++++++++++++++++++
>  include/linux/libata.h         | 12 ++++++
>  4 files changed, 125 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e76d15411e2a..9ea32ed53156 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5559,6 +5559,8 @@ void ata_dev_init(struct ata_device *dev)
>  	dev->pio_mask = UINT_MAX;
>  	dev->mwdma_mask = UINT_MAX;
>  	dev->udma_mask = UINT_MAX;
> +	dev->media_err_limit = ATA_EH_MEDIA_ERR_LIMIT;
> +	dev->media_err_window = ATA_EH_MEDIA_ERR_WINDOW;
>  }
>  
>  /**
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 9a4b67b90b17..9fc78020ac7e 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2419,12 +2419,47 @@ static void ata_eh_link_autopsy(struct ata_link *link)
>  		      ata_dev_enabled(link->device))))
>  	    dev = link->device;
>  
> +	/*
> +	 * Track repeated media errors. If the same device hits media errors
> +	 * too many times within a configurable time window, disable it to
> +	 * prevent infinite EH loops that block other devices sharing the
> +	 * same Scsi_Host (particularly relevant for SATA devices behind
> +	 * SAS HBAs using libsas).
> +	 *
> +	 * media_err_limit == 0 means this feature is disabled.
> +	 */
> +	if (dev && (all_err_mask & AC_ERR_MEDIA) && dev->media_err_limit) {
> +		unsigned long now = jiffies;
> +		unsigned long window = (unsigned long)dev->media_err_window * HZ;
> +
> +		if (!dev->media_err_count ||
> +		    time_after(now, dev->media_err_first_jiffies + window)) {
> +			dev->media_err_count = 1;
> +			dev->media_err_first_jiffies = now;
> +		} else {
> +			dev->media_err_count++;
> +		}
> +
> +		if (dev->media_err_count >= dev->media_err_limit) {
> +			ata_dev_err(dev,
> +				"too many media errors (%u in %u seconds), disabling device\n",
> +				dev->media_err_count,
> +				jiffies_to_msecs(now - dev->media_err_first_jiffies) / 1000);
> +			ata_dev_disable(dev);
> +			dev->media_err_count = 0;
> +			/* skip speed_down for disabled device */
> +			goto out_autopsy;
> +		}
> +	}
> +
>  	if (dev) {
>  		if (dev->flags & ATA_DFLAG_DUBIOUS_XFER)
>  			eflags |= ATA_EFLAG_DUBIOUS_XFER;
>  		ehc->i.action |= ata_eh_speed_down(dev, eflags, all_err_mask);
>  		trace_ata_eh_link_autopsy(dev, ehc->i.action, all_err_mask);
>  	}
> +out_autopsy:
> +	return;
>  }
>  
>  /**
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index 95862dc34419..c73a0bf0eeb7 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -477,6 +477,79 @@ show_ata_dev_trim(struct device *dev,
>  
>  static DEVICE_ATTR(trim, S_IRUGO, show_ata_dev_trim, NULL);
>  
> +static ssize_t
> +media_err_limit_show(struct device *dev,
> +		     struct device_attribute *attr, char *buf)
> +{
> +	struct ata_device *ata_dev = transport_class_to_dev(dev);
> +
> +	return sysfs_emit(buf, "%u\n", ata_dev->media_err_limit);
> +}
> +
> +static ssize_t
> +media_err_limit_store(struct device *dev,
> +		      struct device_attribute *attr,
> +		      const char *buf, size_t count)
> +{
> +	struct ata_device *ata_dev = transport_class_to_dev(dev);
> +	unsigned int val;
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	ata_dev->media_err_limit = val;
> +	ata_dev->media_err_count = 0;
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(media_err_limit);
> +
> +static ssize_t
> +media_err_window_show(struct device *dev,
> +		      struct device_attribute *attr, char *buf)
> +{
> +	struct ata_device *ata_dev = transport_class_to_dev(dev);
> +
> +	return sysfs_emit(buf, "%u\n", ata_dev->media_err_window);
> +}
> +
> +static ssize_t
> +media_err_window_store(struct device *dev,
> +		       struct device_attribute *attr,
> +		       const char *buf, size_t count)
> +{
> +	struct ata_device *ata_dev = transport_class_to_dev(dev);
> +	unsigned int val;
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	/* window=0 would prevent the counter from ever accumulating */
> +	if (!val)
> +		return -EINVAL;
> +
> +	ata_dev->media_err_window = val;
> +	ata_dev->media_err_count = 0;
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(media_err_window);
> +
> +static ssize_t
> +media_err_count_show(struct device *dev,
> +		     struct device_attribute *attr, char *buf)
> +{
> +	struct ata_device *ata_dev = transport_class_to_dev(dev);
> +
> +	return sysfs_emit(buf, "%u\n", ata_dev->media_err_count);
> +}
> +
> +static DEVICE_ATTR_RO(media_err_count);
> +
>  static const struct attribute *const ata_device_attr_attrs[] = {
>  	&dev_attr_class.attr,
>  	&dev_attr_pio_mode.attr,
> @@ -487,6 +560,9 @@ static const struct attribute *const ata_device_attr_attrs[] = {
>  	&dev_attr_id.attr,
>  	&dev_attr_gscr.attr,
>  	&dev_attr_trim.attr,
> +	&dev_attr_media_err_limit.attr,
> +	&dev_attr_media_err_window.attr,
> +	&dev_attr_media_err_count.attr,
>  	NULL
>  };
>  
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 5c085ef4eda7..8715704e06a6 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -419,6 +419,11 @@ enum {
>  	ATA_EH_PMP_TRIES	= 5,
>  	ATA_EH_PMP_LINK_TRIES	= 3,
>  
> +	/* default: disable device after this many media errors in time window */
> +	ATA_EH_MEDIA_ERR_LIMIT	= 10,
> +	/* default: time window in seconds */
> +	ATA_EH_MEDIA_ERR_WINDOW	= 60,
> +
>  	SATA_PMP_RW_TIMEOUT	= 3000,		/* PMP read/write timeout */
>  
>  	/* This should match the actual table size of
> @@ -786,6 +791,13 @@ struct ata_device {
>  
>  	/* error history */
>  	int			spdn_cnt;
> +
> +	/* media error tracking for repeated EH */
> +	unsigned int		media_err_count;
> +	unsigned long		media_err_first_jiffies;
> +	unsigned int		media_err_limit;
> +	unsigned int		media_err_window;
> +
>  	/* ering is CLEAR_END, read comment above CLEAR_END */
>  	struct ata_ering	ering;
>  


-- 
Damien Le Moal
Western Digital Research
