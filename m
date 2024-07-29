Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318998061C
	for <linux-ide@vger.kernel.org>; Mon, 29 Jul 2024 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278588; cv=none; b=KgpR48M1Hv9FRh+QprRubMhurWqgFwZpAIuUsjQ+ewC41w5b9AZZbble3fgErARQpXWsSOdrCj4M2ngG67IcULAqCtt/iU92KRkxfT9OeDiesh3+zAT8dAk8TIATXI7BxdiDWdtRTuFalLAJCbl/UaqK+jAt9HyBVZPQcp3+roU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278588; c=relaxed/simple;
	bh=N7oaySgx6uhHfyOLC0eEbca6+pKDPeFKE9xlLy91Upw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLE6s+70Fh2FJvl8D43RoDOsEX0p/Ybc/ArIB6/32smXznnIoeluamA7Zr6cHQQgQR5ip/KDqPQ20wSu9vDiXIY/26MyIMGS9mb3H3wputAFgXmnE3+ewppS+n6cHDJyO0XFpf20yefAWg0qji2YwXH/ztPP30XaZlYRUGXtqGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9sMPdFE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9sMPdFE"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd66cddd4dso30831505ad.2
        for <linux-ide@vger.kernel.org>; Mon, 29 Jul 2024 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722278586; x=1722883386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8pli4s97iEFLgiAL55JXs70eYR4qxgVDVXbN/0rXweM=;
        b=h9sMPdFEtlH6iKklwQY9Mz2uryudzszHz0avckmV1c9gBzMvCdYpFsnmjOx6O+Ifa1
         8jNvWZXj3o9a2Gfpz6yEDZ1H4HJWcatTeweOt47W2Te900n25c0KrzWRtyXefSajFxIO
         xpQk7Yct5ol7iwpcohDECQFEUPQSDhOOHsXXaxbN2DH++CaCDX/WZyXOsjSSh6Sv1/WI
         bdSDCxm6OyXU03Md0Vz9fC+AunQ6thkMYcmDTqtRht2mjhABVzVIu8dQAqk0hQlq7I18
         fIqbACKr7ynX3jE2RvYkZX2Fv4PstHwwJjcuDt68rGNNqlv0XeUpLKt3yGket7PPAK1q
         OxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722278586; x=1722883386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pli4s97iEFLgiAL55JXs70eYR4qxgVDVXbN/0rXweM=;
        b=lXnAruEIBQByR4EMRVvlgqsv6L2gZ2IjKmeq0L9jK3LZj8hqqLNnV8kQ+Xow1wmH85
         jIcGYUWIG6vZ1/ZZjCcP9mUEXlkeav4k7Cb4WNxQxrJbRZPotL5IVTy4UoTqjET90wW9
         u2E/nOw/IR2vhBVJgit5/mOhM1tEevXTXXlTQHIBsP0JDxqR53GrkPFRE3hVodUqfj9g
         I7DnXVdTv23oQKXV2l86Q4bSB9FVnHP+unxlX5j2yrzLaUMpXIHfdMXt2mXqxINYXwIL
         BXFiwL/jxbnGz2fuZkGZrmyih3ORpAA8oK/Za/7cLgOqd7Ro6w8Crd0p4k4PqRLgfvox
         eaWw==
X-Gm-Message-State: AOJu0YxcrTaDRhEbqqze17b7ZskNxaFGrqeWbgW8s8cF2m1nOgFTf0Gd
	R216EtEdvJcUWlSAsYN5uKLtntZp2ctX98lilQnXAl6+oMapellFdM376ta8wKkesnt+AFAgpRh
	2ug==
X-Google-Smtp-Source: AGHT+IEv4LFsP7UN+03yezxkAW1iD3/wv69/ySc7xb1PbjiTe4jx7/1eBW0rvxrlfIW3n2nr3d1sjg==
X-Received: by 2002:a17:903:234d:b0:1fd:80f0:e859 with SMTP id d9443c01a7336-1ff047e4564mr90837335ad.2.1722278586069;
        Mon, 29 Jul 2024 11:43:06 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8d49dsm86857405ad.50.2024.07.29.11.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 11:43:05 -0700 (PDT)
Date: Mon, 29 Jul 2024 18:43:01 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 05/11] ata: pata_serverworks: Do not use the term
 blacklist
Message-ID: <ZqfitZvdxmSOagUX@google.com>
References: <20240726031954.566882-1-dlemoal@kernel.org>
 <20240726031954.566882-6-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726031954.566882-6-dlemoal@kernel.org>

On Fri, Jul 26, 2024 at 12:19:48PM +0900, Damien Le Moal wrote:
> Let's not use the term blacklist in the function
> serverworks_osb4_filter() documentation comment and rather simply refer
> to what that function looks at: the list of devices with groken UDMA5.
> 
> While at it, also constify the values of the csb_bad_ata100 array.
> 
> Of note is that all of this should probably be handled using libata
> quirk mechanism but it is unclear if these UDMA5 quirks are specific
> to this controller only.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor
>
> ---
>  drivers/ata/pata_serverworks.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
> index 549ff24a9823..4edddf6bcc15 100644
> --- a/drivers/ata/pata_serverworks.c
> +++ b/drivers/ata/pata_serverworks.c
> @@ -46,10 +46,11 @@
>  #define SVWKS_CSB5_REVISION_NEW	0x92 /* min PCI_REVISION_ID for UDMA5 (A2.0) */
>  #define SVWKS_CSB6_REVISION	0xa0 /* min PCI_REVISION_ID for UDMA4 (A1.0) */
>  
> -/* Seagate Barracuda ATA IV Family drives in UDMA mode 5
> - * can overrun their FIFOs when used with the CSB5 */
> -
> -static const char *csb_bad_ata100[] = {
> +/*
> + * Seagate Barracuda ATA IV Family drives in UDMA mode 5
> + * can overrun their FIFOs when used with the CSB5.
> + */
> +static const char * const csb_bad_ata100[] = {
>  	"ST320011A",
>  	"ST340016A",
>  	"ST360021A",
> @@ -163,10 +164,11 @@ static unsigned int serverworks_osb4_filter(struct ata_device *adev, unsigned in
>   *	@adev: ATA device
>   *	@mask: Mask of proposed modes
>   *
> - *	Check the blacklist and disable UDMA5 if matched
> + *	Check the list of devices with broken UDMA5 and
> + *	disable UDMA5 if matched.
>   */
> -
> -static unsigned int serverworks_csb_filter(struct ata_device *adev, unsigned int mask)
> +static unsigned int serverworks_csb_filter(struct ata_device *adev,
> +					   unsigned int mask)
>  {
>  	const char *p;
>  	char model_num[ATA_ID_PROD_LEN + 1];
> -- 
> 2.45.2
> 
> 
