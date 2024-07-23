Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFA013D504
	for <linux-ide@vger.kernel.org>; Tue, 23 Jul 2024 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721762921; cv=none; b=D2fgUVzH3uWOsW+c0IWqwNrMZ9FuksHHhq0JAt8x7yorBcPn1Zj/DMbINl+exBoO/92ESiibCDEZYS4LJ7SEUZCBed8XJuSjSeMRu0y7AShMGLL1H19NwFa8PSeRGUPSAAC/CxF+qOI3dtIhIOc1qSX+Xgn7TtGc3/49PSkHjpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721762921; c=relaxed/simple;
	bh=G6Hsht2guR4abAT60+jSKItfmkPAuFWgyttdR/IKkRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUfyUZzZ85YQZifZr5iYdRogUFx4BwfBvBaH5UZJ4ilJCTW6/bV7V+/ug+CtSDKCEi0af/VBLJADZNTagQKm/zJordDP0z9JtTKl35H+2vjWWyyQWZgCWymQxUIW0Pjbr3ktiLRaE2jlK31VgbpFLPcaSdWyAWBfssZYIrkOg3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mFuUNiJ4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mFuUNiJ4"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d1dadd5e9so1939867b3a.2
        for <linux-ide@vger.kernel.org>; Tue, 23 Jul 2024 12:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721762920; x=1722367720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iznQPoU2UTiUPgVAZzOyMU2d5FI3+fgjTR8kRfcM5Ts=;
        b=mFuUNiJ4Se5yZAPy32b2aPHuvkv3p4KkE4GMIGsxhkQGHpDILSOg01YkIvlwvvs7v9
         MObjLSjTO4P3tjcPaBhjqjibSHzoBAtgsnRcdxSFQhP1o3QDxrUIOrbX8WfKq6mcFDpu
         kHcgAZLdpQhq6coHDkubT76ejfvZ+SoeosCN2ex13lxZq2Xvg+J2ZV5Lvc3Q6bEMsYZd
         K36+GrtmbvM99nC0Xw184YzYfN+UFie231OVzvCrG0eXhJIIr6RWCizvXNP+YF2debrv
         RHGT8OSOirk3CPVTvTxd5yf4hGwZWrZfSnYQgnwIFgSM3gZ8f7q9avLeRSIKEp0qG6mJ
         pIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721762920; x=1722367720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iznQPoU2UTiUPgVAZzOyMU2d5FI3+fgjTR8kRfcM5Ts=;
        b=gtA/yUtd6HtJGzcE+zVx2YAHlNF391H3f2dIaFlEzDfiKHe0PmQv6OOyPt3XnPmbmt
         p0MpduQ/1gVerJ6BllJdKMcqz/Zo+6NNOrc99V2hcatwzG0M6HiX2CfMJOL0GbHg0M4W
         JcTrCtBswrIFfQr0B8ptQ0/Mrko81cvehMmhCHnS/s6LlJJStm7B/JFI8x1z2WNeUtVS
         ZWVVDxVjElqvpMhbycokojy3S2nNH7+ZWJFFRWYXzOETBVian5TGfinOthz0qlck0gdh
         1kkFExMbBAEowv713ALPfrexhpPguxFzZqbKfpf4i/Fx35shzhrz2rMapt7cyegfdqV9
         uu/Q==
X-Gm-Message-State: AOJu0YxMYa6PY1db1VgA1zAvTiP90PXlFMRdFnCtnmexH/ZMWi8QXF3y
	nT52kl/t/TlF20CDJ2maSS0nCItsIe/e2PydumMcOgFlWmT2pr5/Ed4b35U4m24FsYczLWhDMJR
	MYQ==
X-Google-Smtp-Source: AGHT+IFXKKNeFNRQoe2Wdn1hOIQnrDqEP3oh8bBu3F6lRiwLCYERYTmz6WvEKLP225g+0uNUvPl9KA==
X-Received: by 2002:a05:6a00:2446:b0:70d:27e0:a946 with SMTP id d2e1a72fcca58-70d27e0abb2mr6689306b3a.9.1721762919029;
        Tue, 23 Jul 2024 12:28:39 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d35de3274sm2453261b3a.83.2024.07.23.12.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 12:28:38 -0700 (PDT)
Date: Tue, 23 Jul 2024 19:28:35 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 1/3] ata: libata: Rename ata_dma_blacklisted()
Message-ID: <ZqAEY-pzN7bQ0Pin@google.com>
References: <20240723103406.294462-1-dlemoal@kernel.org>
 <20240723103406.294462-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723103406.294462-2-dlemoal@kernel.org>

On Tue, Jul 23, 2024 at 07:34:04PM +0900, Damien Le Moal wrote:
> Rename the function ata_dma_blacklisted() to ata_dev_nodma() as this new
> name is more neutral. The function signature is also changed to return a
> boolean instead of an int.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor
> ---
>  drivers/ata/libata-core.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index c7752dc80028..286e1bc02540 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4287,16 +4287,17 @@ static unsigned long ata_dev_blacklisted(const struct ata_device *dev)
>  	return 0;
>  }
>  
> -static int ata_dma_blacklisted(const struct ata_device *dev)
> +static bool ata_dev_nodma(const struct ata_device *dev)
>  {
> -	/* We don't support polling DMA.
> -	 * DMA blacklist those ATAPI devices with CDB-intr (and use PIO)
> -	 * if the LLDD handles only interrupts in the HSM_ST_LAST state.
> +	/*
> +	 * We do not support polling DMA. Deny DMA for those ATAPI devices
> +	 * with CDB-intr (and use PIO) if the LLDD handles only interrupts in
> +	 * the HSM_ST_LAST state.
>  	 */
>  	if ((dev->link->ap->flags & ATA_FLAG_PIO_POLLING) &&
>  	    (dev->flags & ATA_DFLAG_CDB_INTR))
> -		return 1;
> -	return (dev->horkage & ATA_HORKAGE_NODMA) ? 1 : 0;
> +		return true;
> +	return !!(dev->horkage & ATA_HORKAGE_NODMA);
>  }
>  
>  /**
> @@ -4404,7 +4405,7 @@ static void ata_dev_xfermask(struct ata_device *dev)
>  		xfer_mask &= ~(0x03 << (ATA_SHIFT_MWDMA + 3));
>  	}
>  
> -	if (ata_dma_blacklisted(dev)) {
> +	if (ata_dev_nodma(dev)) {
>  		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
>  		ata_dev_warn(dev,
>  			     "device is on DMA blacklist, disabling DMA\n");
> -- 
> 2.45.2
> 
> 
