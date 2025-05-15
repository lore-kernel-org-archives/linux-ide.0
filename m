Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CB01FAC54
	for <linux-ide@vger.kernel.org>; Thu, 15 May 2025 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312941; cv=none; b=sMDVJ+Uc5rj2sYEDhj3EsMExoiNClPZOBj8Gg7IBljCX69kq0TjRuo8AjQAHLHYEmProD+Hjh6vJNkUVxAuLkkeiMazt9ZLr0I8CGT0lGLmkrqW2xQ6PXdhYghzhYnmCDPdx9eO13uighzie24Df9vH9ynTD0W41fNimQ+ZNPPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312941; c=relaxed/simple;
	bh=+i4J6wkx0QWNHsi1WbTmUIHOriiT5f8/YE/YkUcdmaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ie3bXchJVN7VNAZmZnRFMaF6TjWIkua+aY45+8WRr+refD4O4Ewpqf27f23U7CndJO7ZFon9XF+QyxmauMDCibLZ4nODlLL0AjOCPib+UaQakTR62OfV2DMCF09i8sEj+5xxv15nf1m6xCSEZq2FfKqnhzFDlhbiPWZbVfzcUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1x3+AuP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1x3+AuP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95EDC4CEF3;
	Thu, 15 May 2025 12:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747312941;
	bh=+i4J6wkx0QWNHsi1WbTmUIHOriiT5f8/YE/YkUcdmaw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g1x3+AuPF6NahCk6J1q4WipI8GN03r2L8HnEeSgFHHJOezC5cdbWi2NHnefIrkhIG
	 Am3TJvQLmu/KYKydz5k6sSjpfB1EExVbwt9xD7Tf+DNn+AL+k5DqolSAZ7rCLG2g5l
	 Ko31Z64B4qymZ+IBtD9sgDiN+9XYV8HU8jkasMPhlEXxgA9bHIsh5WdSPhgWw5sQCK
	 2MSzYOkRxRkpTJP6PFjZQk1/HOw+YFMVlwTScxRhtSHP+ThpkgAa1pAgGODI7t3rkL
	 lJWFpROOp3T5zl847yhvo7TXnsFRkXl20PMxYyAeUnT8eos6XFnB0M45V+5KqV/pEH
	 dkxaoOtxx+P1A==
Message-ID: <840a1671-997f-45e4-af25-03f702bad237@kernel.org>
Date: Thu, 15 May 2025 14:42:17 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] ata: libata-eh: Always disable DIPM before calling
 set_lpm() callback
To: Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>, linux-ide@vger.kernel.org
References: <20250514172210.383801-9-cassel@kernel.org>
 <20250514172210.383801-16-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250514172210.383801-16-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 19:22, Niklas Cassel wrote:
> The current code performs a SET FEATURES command to disable DIPM if
> policy < ATA_LPM_MED_POWER_WITH_DIPM, this means that it will disable
> DIPM for policies:
> ATA_LPM_UNKNOWN, ATA_LPM_MAX_POWER, ATA_LPM_MED_POWER
> (but not for policy ATA_LPM_MED_POWER_WITH_DIPM).

[...]

> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 91d97d98eed1..1727248f135d 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -3473,7 +3473,7 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>  			hints &= ~ATA_LPM_HIPM;
>  
>  		/* disable DIPM before changing link config */
> -		if (policy < ATA_LPM_MED_POWER_WITH_DIPM && dev_has_dipm) {
> +		if (dev_has_dipm) {

This changes the same line that patch 6 changed... Can you squash these patches
together ?

>  			err_mask = ata_dev_set_feature(dev,
>  					SETFEATURES_SATA_DISABLE, SATA_DIPM);
>  			if (err_mask && err_mask != AC_ERR_DEV) {


-- 
Damien Le Moal
Western Digital Research
