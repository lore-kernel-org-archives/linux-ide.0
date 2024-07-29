Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D861C157E6C
	for <linux-ide@vger.kernel.org>; Mon, 29 Jul 2024 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278808; cv=none; b=P8l74YoebuENd/RCmKMmUcBwiGHljSSDaMqn22mu+txgV8sgcaGx/3FLjoGnBlNkzkn4K8MRwSjexR+sYQHh16c5bOtsCjdS0C1Ue+EcLSo3Y5hohTL/CoO4MMFU96yvvA0DBOyzm8ArmjMUl9UEjO++UiXOu4/mt+z4gJLJAng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278808; c=relaxed/simple;
	bh=Z/EQW8mMvrr6UYIOEpMxbAvFAIw/cGf1vYULNu575Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKhUoaEaJn9e6Oah45+iu9AO4IFSZ8BoLs3uXDFaDrIjJQwh3H27A1eRGL2E8U3+yUahgG5LGWyV05cy/WAgvw07XykWp7aHPlYqhnREP10Ofq/gPCLDpni3Ja8W75KVdYgzJxK8Z3BmdwzbZKoLPFa1472DNXVan8sJfWq4ELg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X0VToJIz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X0VToJIz"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fdd6d81812so27922725ad.1
        for <linux-ide@vger.kernel.org>; Mon, 29 Jul 2024 11:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722278806; x=1722883606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s3qEY4MnxRgmrNM0EOzjy0dChVSMZOFmD0JXihUsg9A=;
        b=X0VToJIzuVfTB2ftJkSI3GlIPnKcf/kSTVeG0Lc6/jMWtSOLCZ0MmemteogrJxTDZX
         tjWOwHxQ59itPim9yYjhzp+HZofwYUHTbu1aL8RtRjd8lA7MgZt/n7oIFghtzH2DZcfx
         DFMhyslCLqlBLk2l+rHQ64ugHEXjGUEYQjG60o0e/H0cBA/wuV9DBwJ20mrkE/I+36iD
         /MkBY/8lzUVK8NE6NKEhimkoFIuNFLO7zMb2OatPXDTlSzeQOyEcz59Fa4gYZntP+lZi
         mcYaCOArhtw4cWQIPG4DCuOXDDUS9hhBoPPEADsTOuixozr0/8JbMDVq/x2DwWv/cBPP
         YuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722278806; x=1722883606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3qEY4MnxRgmrNM0EOzjy0dChVSMZOFmD0JXihUsg9A=;
        b=ahR3RkAds8u3/zCfZre+prKp4GaKO/WnjsRfgErgOP0E3LhjHjdLrgNrhbBxk1tI+q
         SkngrDgSRwLaPfuAYdWF3lH27v4NEAC6j/gDU5MCYx64Jcl8KuviRa3SXd7Z2VwTYEr+
         DImXrGL/4zViDONXzVoNCP365eQNuCgs1QpwALb8byTPTGWCEshKarHFS34c7bhmbkbV
         B3rxXs5VfispwU7F6xYWZxtUyuOhNfCRWDVPbRVjDcrIURoPWl6UFaBVQWZrvjYR29Wv
         CshPz78ah+wSLMFzsdB0LPa+i2mCGQW4juR/RIFnLMpY7BLmUdZWl9oRf30diXeTZrip
         uI4A==
X-Gm-Message-State: AOJu0Yz2fpdzbQ6HO6mTx+SmJlgxDCQUkS1urdLvKOGKqljzgxSDbkg7
	GVaoIjmPwP9E0yFaJoK/KeiPmqGrWjWvaLAd4Hn7pQEdct0bPN1NbKnS9k8u6Q==
X-Google-Smtp-Source: AGHT+IESmohLN05YIXW4dji33ss9E8ALPv5Xu23SVYNbVwqVYp2lNM8h3n3f32i1nX/CPBqQkJX9RA==
X-Received: by 2002:a17:902:ecc1:b0:1fd:9e44:e5e9 with SMTP id d9443c01a7336-1ff04918e04mr120933175ad.53.1722278805834;
        Mon, 29 Jul 2024 11:46:45 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fb67e4sm86194245ad.265.2024.07.29.11.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 11:46:45 -0700 (PDT)
Date: Mon, 29 Jul 2024 18:46:41 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 10/11] ata: pata_hpt366: Rename hpt_dma_blacklisted()
Message-ID: <ZqfjkfRKat9qF9bV@google.com>
References: <20240726031954.566882-1-dlemoal@kernel.org>
 <20240726031954.566882-11-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726031954.566882-11-dlemoal@kernel.org>

On Fri, Jul 26, 2024 at 12:19:53PM +0900, Damien Le Moal wrote:
> Rename the function hpt_dma_blacklisted() to the more neutral
> hpt_dma_broken().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor

> ---
>  drivers/ata/pata_hpt366.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
> index bdccd1ba1524..5280e9960025 100644
> --- a/drivers/ata/pata_hpt366.c
> +++ b/drivers/ata/pata_hpt366.c
> @@ -170,8 +170,8 @@ static const char * const bad_ata66_3[] = {
>  	NULL
>  };
>  
> -static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
> -			       const char * const list[])
> +static int hpt_dma_broken(const struct ata_device *dev, char *modestr,
> +			  const char * const list[])
>  {
>  	unsigned char model_num[ATA_ID_PROD_LEN + 1];
>  	int i;
> @@ -197,11 +197,11 @@ static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
>  static unsigned int hpt366_filter(struct ata_device *adev, unsigned int mask)
>  {
>  	if (adev->class == ATA_DEV_ATA) {
> -		if (hpt_dma_blacklisted(adev, "UDMA",  bad_ata33))
> +		if (hpt_dma_broken(adev, "UDMA",  bad_ata33))
>  			mask &= ~ATA_MASK_UDMA;
> -		if (hpt_dma_blacklisted(adev, "UDMA3", bad_ata66_3))
> +		if (hpt_dma_broken(adev, "UDMA3", bad_ata66_3))
>  			mask &= ~(0xF8 << ATA_SHIFT_UDMA);
> -		if (hpt_dma_blacklisted(adev, "UDMA4", bad_ata66_4))
> +		if (hpt_dma_broken(adev, "UDMA4", bad_ata66_4))
>  			mask &= ~(0xF0 << ATA_SHIFT_UDMA);
>  	} else if (adev->class == ATA_DEV_ATAPI)
>  		mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
> -- 
> 2.45.2
> 
> 
