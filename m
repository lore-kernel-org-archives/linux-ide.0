Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641A3227B8E
	for <linux-ide@vger.kernel.org>; Wed, 26 Nov 2025 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158706; cv=none; b=BbOfFGWzth8MDdFfYhjTz/vgzUmnv0z6FMrJrq1APoVKsxKeFeORoazBGw6DeY60OBgChe3OHfKNHkXUBe30JXCSGoACcvSNYmDipYiyFKfZQXbisrZpdn7HcdF10q6C3RZJ4cmYiPEDsVPbZB0cQ0l5+vXdPgef5IlTY7spWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158706; c=relaxed/simple;
	bh=8AUkUujSNx2Xj4iTCvERT22T3GkwNDU0Ag7hq+Zw/pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BH0ckkfsmShiM2jcVcFEq5u5r+CHrrX5omv5pY/iXZmFQM1V6JspQdI5LVcNvBwc/EJEtZZi9STlBnI2Q2DWAIEPLsQKOu2C8Ll8F3lKUssfCniBmKKT70Kc3AtpiV3aicC5qnhPZTT+EzhZkHkNiWA/UIyvAB38I1MkCtGm1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjZ8x0PM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjZ8x0PM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03891C113D0;
	Wed, 26 Nov 2025 12:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764158703;
	bh=8AUkUujSNx2Xj4iTCvERT22T3GkwNDU0Ag7hq+Zw/pM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HjZ8x0PMntro0x6AW56ueeA+jTOki3xHAldmxeGMeisuilmglejsMcPOX+IcNxVrd
	 j+n9tj57BAzUNrIJQcTh+zfGjTidQhSB0tUtkAMMMbXDXwsv79Pn9ssV1Q1gD/Uk7a
	 s88kT3ekzg5pXAQ7BFfJUYY6Gex+2sNHCTZatkvWKh8FtoapAKhOylKgyMdZuDG6vI
	 jumtAeyOlEnoRVPGcyfpZuFfijawxajUk53SGpKlLOzcPC70ZUX7FfXxPJsthsikeh
	 /pBGxp1/8aV3aPvoIGpdbgfpKdsqDlb/lMylv7Sw01kU7JziPjnrMaXluOT+14vsQl
	 GjfXC9ag1J6tg==
Date: Wed, 26 Nov 2025 13:05:00 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Yihang Li <liyihang9@h-partners.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Disable LPM on Silicon Motion
 MD619HXCLDE3TC
Message-ID: <aSbs7HOYr_8waEZZ@ryzen>
References: <20251124163433.3082331-2-cassel@kernel.org>
 <8850d82e-6818-b67f-9acb-cdfe78b7cedd@h-partners.com>
 <aSWgnwVzGDAqPf0i@ryzen>
 <5c2c5cbd-b13c-8ba1-86c8-670f0a34fcf3@h-partners.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c2c5cbd-b13c-8ba1-86c8-670f0a34fcf3@h-partners.com>

On Wed, Nov 26, 2025 at 04:48:09PM +0800, Yihang Li wrote:
> Hi Niklas,
> 
> On 2025/11/25 20:27, Niklas Cassel wrote:
> > Ok, really nice that we have a patch that fixes your problem.
> > 
> > However, like I wrote in the comment section:
> > 
> > Before we apply this patch, it would be nice if you could try another SSD,
> > that supports LPM (HIPM and DIPM) with your AHCI controller:
> > Huawei Technologies Co., Ltd. HiSilicon AHCI HBA [19e5:a235] (rev 30)
> > 
> > Note: You can see if your drive supports HIPM and DIPM from the
> > ata_dev_print_features() print to dmesg during boot, e.g.:
> > ata6.00: Features: Trust Dev-Sleep HIPM DIPM NCQ-sndrcv NCQ-prio
> > 
> > Just so we can verify that it is the MD619HXCLDE3TC SSD that is not
> > handling LPM correctly, and that it is not the AHCI HBA that is at fault.
> > 
> > E.g. there have been some weird bugs with this AHCI controller before,
> > see e.g. 234e6d2c18f5 ("ata: ahci: Disable SXS for Hisilicon Kunpeng920").
> > 
> > 
> > 
> > Do you have any other drive, other than MD619HXCLDE3TC and MD619GXCLDE3TC,
> > which supports LPM, and you can see that the drive works as intended,
> > with LPM enabled, so we can be certain that it is not the HBA that has
> > broken LPM support?
> > 
> 
> I checked all the drives I own, but unfortunately, none of them support LPM (HIPM and DIPM).
> :(

Well, it should be sufficient that they support either HIPM and DIPM.

Ideally, they should support the same as:
MD619HXCLDE3TC and MD619GXCLDE3TC.
(Not sure if they supported HIPM and DIPM or only one of them).

But the device should work fine to read / write / mount, etc. without showing
the same errors as you got with MD619HXCLDE3TC and MD619GXCLDE3TC.


Kind regards,
Niklas
