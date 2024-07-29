Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3053183084
	for <linux-ide@vger.kernel.org>; Mon, 29 Jul 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278841; cv=none; b=P2hOdOiHIPE1IJYqFFkySzvn6xCCL4P6ES0xaOOP/JtHqB9hQkxXBYhb5JYxuTVboFOoJyrJ/SxZUJXhe+PDauDqgmOZtMMg/Q/D+j+53Ue3t9n8UBoJmIuSk+O63K60KB7SedHsu6gOfSvjwfqmgSs7FCeMdVxjZBpsAdLu/5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278841; c=relaxed/simple;
	bh=3kfybPHSqcm/nfsLdwG9NqxZBh0N3LbSvgvKW3FepII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvGLzEhKX2xaJNoL5sfD8CjsukUvpU7g17k5jNVxxN8sopGsX4DVjMtclfSg9p7jyXvMlph1t8McwH9fQBPYGOB3VYp+Mu1/7CNk37PRWQtV786WwCYrfAgrwwsW791Akc1D1JSYPgz0S67TRyBZunxAFSEACccqJqzC2YNJiFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2S1y5f9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2S1y5f9"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d1c8d7d95so2192652b3a.2
        for <linux-ide@vger.kernel.org>; Mon, 29 Jul 2024 11:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722278839; x=1722883639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RnnfBPyGM8nc3PRKVbDGUt6onMAdNtDeFLqCS/V5ty4=;
        b=I2S1y5f9FcGbeBqaUSP2Lx2ybFuiQdof5oE7VrrA9gi0uspwuwcjH4g+P7Eqdl8Qsx
         LlJZlFMpt1sofskc+O44WwVUOguQxIrqpq9bO8yc1ZJMX3RBxSk2t8ohGjGwQ4wxTigZ
         JWBQ2XhMq6bqaiZif9cOPH5Shbv8cDTJ++lIqmdU99XwtIzCJlJYPm9rbro+LYfVRO/Y
         jcSDS4qRQ6bpMRYaT3hVc2Sy9zVxBeaV/JVHhgPdAJWaPULbbnutuq3DsaxWcuLZbjij
         +iL1rZxd37yzy5jcx3gTGB+7NGsgh9QPrOMen9M52JdtKwCq0J3NhfaoaxNivpjT2Nun
         Ykug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722278839; x=1722883639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnnfBPyGM8nc3PRKVbDGUt6onMAdNtDeFLqCS/V5ty4=;
        b=YoiHzqtYnpNzk65Ae7vRJsgoWVJuIzVYh3Wr1iD2TbtdO1xDZ7xnAj3DS/BKx6EBWP
         iRaI6T9vLoQAwEjOqB8ISV9W69Hm+oKLkXtFS1kMkqBF4GVoy1u2QsRjKo5Ohx1OXmeO
         df2JgU5ypzwbmFHKdXZJ3LywKl67WZMCUDCKfL1DFdkb32FwPYZKx/nONbd5rcPbHdNw
         n9iTpb0JmkZU61l5Fs8pxQFMAFQ9BKEixUF2sdKT2sbvsDq47vhOtA+iaIKmi1jUo5Sv
         1DXXy1oZCBCZMzeY877L/EJg/VGS4W38EXIbdGFrwSusXmMZhX2jXCEte//9k9ThPKEG
         /LFA==
X-Gm-Message-State: AOJu0YxNuQbhOdsUdZl4zuNhZMfYWbCa6OFeGofktlMCVELsG/UMv5oG
	TSvHy0BY1acXGa8ysSlrwGna4542/wsROT+zMOfA7sgIuoGvKT7ymYUA3cSGsA==
X-Google-Smtp-Source: AGHT+IHAlxjzQqRabn+43bPsB4ibmYVdpSTAAqu3BRzOHkn4xFvI2OgqGToXvSlYFStM6MK6C1C+bg==
X-Received: by 2002:a05:6a00:21d5:b0:70d:2fb5:f996 with SMTP id d2e1a72fcca58-70ecea294d2mr6467215b3a.11.1722278838582;
        Mon, 29 Jul 2024 11:47:18 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead71592bsm7100442b3a.86.2024.07.29.11.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 11:47:18 -0700 (PDT)
Date: Mon, 29 Jul 2024 18:47:14 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 11/11] ata: pata_hpt37x: Rename hpt_dma_blacklisted()
Message-ID: <ZqfjsqZKrQfNNNCd@google.com>
References: <20240726031954.566882-1-dlemoal@kernel.org>
 <20240726031954.566882-12-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726031954.566882-12-dlemoal@kernel.org>

On Fri, Jul 26, 2024 at 12:19:54PM +0900, Damien Le Moal wrote:
> Rename the function hpt_dma_blacklisted() to the more neutral
> hpt_dma_broken().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor

> ---
>  drivers/ata/pata_hpt37x.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
> index c0329cf01135..4af22b819416 100644
> --- a/drivers/ata/pata_hpt37x.c
> +++ b/drivers/ata/pata_hpt37x.c
> @@ -218,8 +218,8 @@ static u32 hpt37x_find_mode(struct ata_port *ap, int speed)
>  	return 0xffffffffU;	/* silence compiler warning */
>  }
>  
> -static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
> -			       const char * const list[])
> +static int hpt_dma_broken(const struct ata_device *dev, char *modestr,
> +			  const char * const list[])
>  {
>  	unsigned char model_num[ATA_ID_PROD_LEN + 1];
>  	int i;
> @@ -281,9 +281,9 @@ static const char * const bad_ata100_5[] = {
>  static unsigned int hpt370_filter(struct ata_device *adev, unsigned int mask)
>  {
>  	if (adev->class == ATA_DEV_ATA) {
> -		if (hpt_dma_blacklisted(adev, "UDMA", bad_ata33))
> +		if (hpt_dma_broken(adev, "UDMA", bad_ata33))
>  			mask &= ~ATA_MASK_UDMA;
> -		if (hpt_dma_blacklisted(adev, "UDMA100", bad_ata100_5))
> +		if (hpt_dma_broken(adev, "UDMA100", bad_ata100_5))
>  			mask &= ~(0xE0 << ATA_SHIFT_UDMA);
>  	}
>  	return mask;
> @@ -300,7 +300,7 @@ static unsigned int hpt370_filter(struct ata_device *adev, unsigned int mask)
>  static unsigned int hpt370a_filter(struct ata_device *adev, unsigned int mask)
>  {
>  	if (adev->class == ATA_DEV_ATA) {
> -		if (hpt_dma_blacklisted(adev, "UDMA100", bad_ata100_5))
> +		if (hpt_dma_broken(adev, "UDMA100", bad_ata100_5))
>  			mask &= ~(0xE0 << ATA_SHIFT_UDMA);
>  	}
>  	return mask;
> -- 
> 2.45.2
> 
> 
