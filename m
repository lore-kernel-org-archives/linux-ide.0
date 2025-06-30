Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEEF72633
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294821; cv=none; b=GKnUwst7P8FkAoprWKZ/WLed4O0hTfaoO+y7Ah2Iix3bArTcwck5eHZ6xOZkPov9g1HmsXvHvyA84JBWPurn+qjdTN2+HXg9oxBYMWy2ox6p+SdHkTYHrJSrnjnxohzM0TtkRfewx4pPeVzS6kqMVfgs63zBTBhHlIQV4LMA0PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294821; c=relaxed/simple;
	bh=9C68ErcM7KpE99JpJIWWQttsR2bQsRptM81CTmrdN28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVPW/qq7iWzITrJ2I/Ckgp4BYhG3RXTmCZQcLVFmUeCVKvmyAg3cgv6sJat2sTso1JBJTiiM84zUWPzh4BXk33rdDk3Us1aKKZNfoSTe5p5ZpP2Xod5AiazoJTQ4CbfreZFpv5+yumA98GkuNaRKrd5+65cnbbn1vAFXzdjmvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs7rhylG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs7rhylG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8525CC4CEE3;
	Mon, 30 Jun 2025 14:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751294820;
	bh=9C68ErcM7KpE99JpJIWWQttsR2bQsRptM81CTmrdN28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vs7rhylGdxyBSobGpa6CTpVyOpWuliTL4Wq58zfXP9ADRJY8IYJ+zs3Odc0dOP2em
	 E98zdLACCHZwAk21DfQJ2v9z8c73jzY1EiEV+UNHcFacYLCIQJtgm4g1jk5Sd0JTER
	 pCq+Bdduc6f2g+W4QNnh6wNtd3By8BPFYYVyc5J062PceL9m6Umwo4n7iNmhJzaurW
	 OlDfxilZ9RpfW702P1UDA2QjwYRr5F9jWgffgqRrqxe0QlOv3AmdjWf5bh26D6Bg9W
	 02pb0WixE/6fQya0luoXct0nmHcX/WaeglsWktwEWmOr+Ki7gxaLEEyKoXSH/0voVj
	 S8JNm/hKz25gg==
Date: Mon, 30 Jun 2025 16:46:56 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 01/10] ata: libata-core: Introduce ata_dev_config_lpm()
Message-ID: <aGKjYDVMWnk1n6Ip@ryzen>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630062637.258329-2-dlemoal@kernel.org>

On Mon, Jun 30, 2025 at 03:26:28PM +0900, Damien Le Moal wrote:
> If the port of a device does not support Device Initiated Power
> Management (DIPM), that is, the port is flagged with ATA_FLAG_NO_DIPM,
> the DIPM feature of a device should be disabled when the device is first
> configured.
> 
> Introduce the function ata_dev_config_lpm() to disable DIPM on a
> device that supports this feature if the port of the device is flagged
> with ATA_FLAG_NO_DIPM. ata_dev_config_lpm() is called from
> ata_dev_configure(), ensuring that a device DIPM feature is disabled
> when it cannot be used.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-core.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 3918ea624e0b..0d85474f6640 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2790,6 +2790,27 @@ static void ata_dev_config_cpr(struct ata_device *dev)
>  	kfree(buf);
>  }
>  
> +/*
> + * Configure features related to link power management.
> + */
> +static void ata_dev_config_lpm(struct ata_device *dev)
> +{
> +	struct ata_port *ap = dev->link->ap;
> +	unsigned int err_mask;
> +
> +	/*
> +	 * If the device port does not support Device Initiated Power Management
> +	 * (DIPM), and the device supports this feature, disable it.

Perhaps mention in the comment that even though DIPM is disabled by default,
because of the "Software Settings Preservation feature", DIPM can be enabled
(even across a COMRESET) when using LPM policy "Keep FW settings".


> +	 */
> +	if (ap->flags & ATA_FLAG_NO_DIPM && ata_id_has_dipm(dev->id)) {
> +		err_mask = ata_dev_set_feature(dev,
> +					SETFEATURES_SATA_DISABLE, SATA_DIPM);
> +		if (err_mask && err_mask != AC_ERR_DEV)
> +			ata_dev_err(dev, "Disable DIPM failed, Emask 0x%x\n",
> +				    err_mask);
> +	}
> +}
> +
>  static void ata_dev_print_features(struct ata_device *dev)
>  {
>  	if (!(dev->flags & ATA_DFLAG_FEATURES_MASK))
> @@ -2963,6 +2984,7 @@ int ata_dev_configure(struct ata_device *dev)
>  			ata_dev_config_chs(dev);
>  		}
>  
> +		ata_dev_config_lpm(dev);
>  		ata_dev_config_fua(dev);
>  		ata_dev_config_devslp(dev);
>  		ata_dev_config_sense_reporting(dev);
> -- 
> 2.50.0
> 
