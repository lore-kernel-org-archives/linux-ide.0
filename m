Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BCC186E25
	for <linux-ide@vger.kernel.org>; Mon, 29 Jul 2024 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278689; cv=none; b=F4sIQ8WAjc2xe3wZCoUYLEpuGyfByCphH0pT0Oki5cI6P454J5BF3GX+vmM640tXTFs42GFVE7MeY7TC2v5bht+aOi9maTccNWiXme07NDYABtFsNXG+8jLn67uGAJeK7HHYqrpMi7suVjLj6gOXPAZO9LiHSMMR2rQW0K+kSOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278689; c=relaxed/simple;
	bh=PtQ/AvFrSuZfwynCRDhgaQ1VFIaK5j9vAAbnV91kDlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIHMcVJKidVo9BhBuUYdBS5zm5rpNqyEuIABTLND4nFtnoFWELPhhN0zj6zGZFRch3NwyyNWRb4zzqhEjOCahP5NmG0CgBEjh7bGj0N5X23LVEiW8GI7cZOqNzy7OffjfXBINIh9FgTugiR8DCKxFCjbG0kl6TFB5qKY9gcyVqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ca/mvGag; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ca/mvGag"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc49c0aaffso21531915ad.3
        for <linux-ide@vger.kernel.org>; Mon, 29 Jul 2024 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722278687; x=1722883487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wv9z1j33lIw3iXicteyr+eLmUszm+iuN0htATXRd7+Q=;
        b=ca/mvGagWJWugzXgQCgjTvLhYHkC0HEexvCTH0lm7nV5kqmrpYgNP/qlT/wffxpehw
         U+FhyLQQYOYU5/f7XhqyHuTag4FnBzuQ76unh6oSXlSDSTQWC5QaA9sFK9bCYYGljUjN
         hwDlsF7Gdeg0pgwxAT+bbf9tW/Qqurb2AoGxSZDn0FJE+1NubH1OCHr3ypobDmWpE8c2
         CZriv48P0StZjtve7GpEY+B4+BZeEMKXFflEI+ltEnC+RRHYuxqj8s1S0OIvQHdNePNM
         mWZxLFlJXcAPCVcFP4hx8OQAotJL8ndBWarRMKCa7q9QxUS/EoTBgORKUCuBUTegUv0e
         ZsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722278687; x=1722883487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wv9z1j33lIw3iXicteyr+eLmUszm+iuN0htATXRd7+Q=;
        b=f1pLVvs50Fn4A3dxuyGx/P9pTG7n2HJeuXG1u4668+G4ZzQ45Wf5w7X1ciOSkQHxEF
         FXsRizoBtW0AK/IoPCZZZTdxtgP1wXsMThCsOrwfYsp6UEVR6wJzVnOkEXa0H0nVhMf/
         AizOJwcoH1PixBmfPK9r85aHId2By/twlTT9vXlKPvxbnexvjY1C9sTfEYq1E7UM5n2m
         +cXKo4hf1L669DHRVursQTI6toKn8jPlA7Oa5MN6c3jqAfKHg757MVSfz54mZyEk2NK+
         /mqNPTvxgKWlDglCRQHz74WusH8L/1iDf+kWRZ9oGctsUjVwRrV9DSOZ+bxHbnC5v65D
         1A8A==
X-Gm-Message-State: AOJu0YwHFg8doUS+Tv9PIxrGpZAdPRKF1c53Srx7NR27N0Qj6yDsvCHY
	JmnqpdITJ8U+paabdvNLZDEENUlswH3AWsyodjG6T0Wi0oABAc0+zhHrPQfm8Q==
X-Google-Smtp-Source: AGHT+IG5krd5y08DLWCZdpkfrN7abPPiQMm/3NqceJBD0vWNtTjurWEcxIJ+ChRxfKhHah/BnzOcrA==
X-Received: by 2002:a17:902:e74f:b0:1fc:6a13:a39c with SMTP id d9443c01a7336-1ff047e46d1mr72474165ad.1.1722278687005;
        Mon, 29 Jul 2024 11:44:47 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7edd91asm86291705ad.131.2024.07.29.11.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 11:44:46 -0700 (PDT)
Date: Mon, 29 Jul 2024 18:44:42 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 07/11] ata: sata_sil: Rename sil_blacklist to
 sil_quirks
Message-ID: <ZqfjGnH2VkOCeToK@google.com>
References: <20240726031954.566882-1-dlemoal@kernel.org>
 <20240726031954.566882-8-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726031954.566882-8-dlemoal@kernel.org>

On Fri, Jul 26, 2024 at 12:19:50PM +0900, Damien Le Moal wrote:
> Rename the array sil_blacklist to sil_quirks as this name is more
> neutral and is also consistent with how this driver define quirks with
> the SIL_QUIRK_XXX flags.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor

> ---
>  drivers/ata/sata_sil.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
> index 354b68ef91bc..3a99f66198a9 100644
> --- a/drivers/ata/sata_sil.c
> +++ b/drivers/ata/sata_sil.c
> @@ -128,7 +128,7 @@ static const struct pci_device_id sil_pci_tbl[] = {
>  static const struct sil_drivelist {
>  	const char *product;
>  	unsigned int quirk;
> -} sil_blacklist [] = {
> +} sil_quirks[] = {
>  	{ "ST320012AS",		SIL_QUIRK_MOD15WRITE },
>  	{ "ST330013AS",		SIL_QUIRK_MOD15WRITE },
>  	{ "ST340017AS",		SIL_QUIRK_MOD15WRITE },
> @@ -600,8 +600,8 @@ static void sil_thaw(struct ata_port *ap)
>   *	list, and apply the fixups to only the specific
>   *	devices/hosts/firmwares that need it.
>   *
> - *	20040111 - Seagate drives affected by the Mod15Write bug are blacklisted
> - *	The Maxtor quirk is in the blacklist, but I'm keeping the original
> + *	20040111 - Seagate drives affected by the Mod15Write bug are quirked
> + *	The Maxtor quirk is in sil_quirks, but I'm keeping the original
>   *	pessimistic fix for the following reasons...
>   *	- There seems to be less info on it, only one device gleaned off the
>   *	Windows	driver, maybe only one is affected.  More info would be greatly
> @@ -620,9 +620,9 @@ static void sil_dev_config(struct ata_device *dev)
>  
>  	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
>  
> -	for (n = 0; sil_blacklist[n].product; n++)
> -		if (!strcmp(sil_blacklist[n].product, model_num)) {
> -			quirks = sil_blacklist[n].quirk;
> +	for (n = 0; sil_quirks[n].product; n++)
> +		if (!strcmp(sil_quirks[n].product, model_num)) {
> +			quirks = sil_quirks[n].quirk;
>  			break;
>  		}
>  
> -- 
> 2.45.2
> 
> 
