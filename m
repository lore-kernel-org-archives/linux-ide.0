Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FE413D504
	for <linux-ide@vger.kernel.org>; Tue, 23 Jul 2024 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721762951; cv=none; b=FEMehcFDpYd1LcJ0NbJK+kS8FhTbTib5QUyQRGq/HOafU3bPF3aiZf9FQpUr14OuapJADeiYGNtYF67OfrH6ib8+c77zNI3OHk+inIaCi3cz3HMGjAKUAlpSxbQ3dNgO7/YsZn2qWbu6o1Td9yHPN0cgoNn0EwhGPiSC+iXaY5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721762951; c=relaxed/simple;
	bh=Wi1raB/RQrIr0Xiw6FYCgoV1L0hhMPyt/WqDo+LPdPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+28pyJ4aTs+UzjvyKDNcl3BJbgq+2QaIeFjJE3Lj0HzBBC/1ix9dBZlHt+Syi5Wo8R9HUT595LGVvK9vG2nJXByeoVpXB1rZgZAp/g34orTfhf+QXSdGbnKkOABwR//99MXYePA/gogYxv1AIbAm6J29mhQaOyW/WJ7P30NCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PljQY6Mo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PljQY6Mo"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb3b7d0d56so1788795ad.1
        for <linux-ide@vger.kernel.org>; Tue, 23 Jul 2024 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721762949; x=1722367749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hq4ePaQjV61IR62oj6LKkqhKUIZPqMy82wRPdfRempc=;
        b=PljQY6MoqO6/ydUibZyloDAmNVhLoNu4xUcC3WDP5x06DX8DXiFOssmfHQ7HiPj8lt
         McuUQp65t7+27RwrGr2vG/z3/LBJobdQHtYpN5tNvfVxYnthXUwbyOriM34emtDtrVti
         X3TGQ6GPlOSPWxDKiZt6EYPLfKPiWjKudnNSQmyDxELHAr55l2d1yGgrGRoiPDXsU86B
         kxhg6Egmplg360MKfcciMJLj7BLyVnbmZXoC/DDLbJzScGomrDk+LAZY+YMOja+Ej5IB
         8Bfyk8fURWavJ6qsmmGrf9W8fyFFqQtlaXLrBDo0eSmRo2eMiF+nR+7nEPc2qFcOWLs5
         I8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721762949; x=1722367749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hq4ePaQjV61IR62oj6LKkqhKUIZPqMy82wRPdfRempc=;
        b=cH9M5kArDT0htPuSHuXodnmW+2fCsz23S5DI9iNe0oJKeYwTvdpO4W+0gcNqg52KOV
         /+2JOVWeLthutG1igiTLotoffZKgqndXh9DmzykMRWvIMUNz5WeEuSr9AboZ27cTttZr
         8lfFi8lbimhZ6PzpevJAOI+0vPTMlx5G8VdAr6oLBLDM2/dB3LmEpbwL3a+oRrdrGDGQ
         aT3Gx1IgssUO+M3FpGOmChHyn4JGPjWl/tJDpGEZL6Nvzz7gfkSrR4m1hE91oKTEBzD8
         v2xbUCIMRuHVBKsGRS0F26G0/bvXGaTgCPJvw4t+Y+LmKIImdXEqzZSoigSuZCRBYiCD
         jdMw==
X-Gm-Message-State: AOJu0Ywoj9YDrj73Fb0t0kNfopqTAnyZ3M/6rvvOZsa5JtuY57xKT/rs
	W27KmicnIMHStnj4pAVUltlboNp+ItM+6xkHZ2uNIwk+/gxwwyIk4tiB+zPvTT2A5hDa2ocs6dr
	ipg==
X-Google-Smtp-Source: AGHT+IHQL6godSRQXaPnesM5tyMVXObpzWtdwR9mm/ATQDhvyVj0VCtvJ/kpOThGm1ox/cPredAxZg==
X-Received: by 2002:a17:902:d507:b0:1fc:6339:2641 with SMTP id d9443c01a7336-1fd74685928mr67091495ad.62.1721762948726;
        Tue, 23 Jul 2024 12:29:08 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25713esm78551735ad.25.2024.07.23.12.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 12:29:08 -0700 (PDT)
Date: Tue, 23 Jul 2024 19:29:05 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 2/3] ata: libata: Rename ata_dev_blacklisted()
Message-ID: <ZqAEgbBuDx-KVc5l@google.com>
References: <20240723103406.294462-1-dlemoal@kernel.org>
 <20240723103406.294462-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723103406.294462-3-dlemoal@kernel.org>

On Tue, Jul 23, 2024 at 07:34:05PM +0900, Damien Le Moal wrote:
> Rename the function ata_dev_blacklisted() to ata_dev_horkage() as this
> new name:
> 1) Does not use an expression that can be considered as negatively loaded.
> 2) The name does not reflect what the function actually does, which is
>    returning a set of horkage flag for the device, of which only one
>    flag will completely disable the device.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor
>
> ---
>  drivers/ata/libata-core.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 286e1bc02540..ee958d2893e6 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -84,7 +84,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
>  					u16 heads, u16 sectors);
>  static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
>  static void ata_dev_xfermask(struct ata_device *dev);
> -static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
> +static unsigned long ata_dev_horkage(const struct ata_device *dev);
>  
>  static DEFINE_IDA(ata_ida);
>  
> @@ -2223,7 +2223,7 @@ static inline u8 ata_dev_knobble(struct ata_device *dev)
>  {
>  	struct ata_port *ap = dev->link->ap;
>  
> -	if (ata_dev_blacklisted(dev) & ATA_HORKAGE_BRIDGE_OK)
> +	if (ata_dev_horkage(dev) & ATA_HORKAGE_BRIDGE_OK)
>  		return 0;
>  
>  	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
> @@ -2830,7 +2830,7 @@ int ata_dev_configure(struct ata_device *dev)
>  	}
>  
>  	/* set horkage */
> -	dev->horkage |= ata_dev_blacklisted(dev);
> +	dev->horkage |= ata_dev_horkage(dev);
>  	ata_force_horkage(dev);
>  
>  	if (dev->horkage & ATA_HORKAGE_DISABLE) {
> @@ -3987,13 +3987,13 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
>  	return rc;
>  }
>  
> -struct ata_blacklist_entry {
> +struct ata_dev_horkage_entry {
>  	const char *model_num;
>  	const char *model_rev;
>  	unsigned long horkage;
>  };
>  
> -static const struct ata_blacklist_entry ata_device_blacklist [] = {
> +static const struct ata_dev_horkage_entry ata_dev_horkages[] = {
>  	/* Devices with DMA related problems under Linux */
>  	{ "WDC AC11000H",	NULL,		ATA_HORKAGE_NODMA },
>  	{ "WDC AC22100H",	NULL,		ATA_HORKAGE_NODMA },
> @@ -4111,7 +4111,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  
>  	/* Devices which get the IVB wrong */
>  	{ "QUANTUM FIREBALLlct10 05", "A03.0900", ATA_HORKAGE_IVB },
> -	/* Maybe we should just blacklist TSSTcorp... */
> +	/* Maybe we should just add all TSSTcorp devices... */
>  	{ "TSSTcorp CDDVDW SH-S202[HJN]", "SB0[01]",  ATA_HORKAGE_IVB },
>  
>  	/* Devices that do not need bridging limits applied */
> @@ -4266,11 +4266,11 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ }
>  };
>  
> -static unsigned long ata_dev_blacklisted(const struct ata_device *dev)
> +static unsigned long ata_dev_horkage(const struct ata_device *dev)
>  {
>  	unsigned char model_num[ATA_ID_PROD_LEN + 1];
>  	unsigned char model_rev[ATA_ID_FW_REV_LEN + 1];
> -	const struct ata_blacklist_entry *ad = ata_device_blacklist;
> +	const struct ata_dev_horkage_entry *ad = ata_dev_horkages;
>  
>  	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
>  	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
> @@ -4372,8 +4372,7 @@ static int cable_is_40wire(struct ata_port *ap)
>   *
>   *	Compute supported xfermask of @dev and store it in
>   *	dev->*_mask.  This function is responsible for applying all
> - *	known limits including host controller limits, device
> - *	blacklist, etc...
> + *	known limits including host controller limits, device horkages, etc...
>   *
>   *	LOCKING:
>   *	None.
> -- 
> 2.45.2
> 
> 
