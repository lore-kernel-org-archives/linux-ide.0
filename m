Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142A53B6370;
	Fri, 26 Jun 2026 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473526; cv=none; b=CrfZOiuWIEHsxapN60JKQGSSAllwBWwVjJhefCfBTh4MOWzvlIJWdqgWT9APA28ITXoURBXX+I0X56kDBRzPDkSLHgLznDXmvLZAA9zRltjMLF61HkuOGhuVr4qzzxEPtsd+FVOtA0gVYLbJe6s26AdbrQVyDR603OhyUDRnBLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473526; c=relaxed/simple;
	bh=38dd0imktr3VNHCfPGft0DeVXgCvPDpjXOZorIZsNT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbJ9b3pyx0CI6X6bcAW5mQuaEz4jojGAyzF6AJrDc79fokUzHAMvajIZbJmBz+wx4m44PY2hHAo5psf1Or+banSTWdlgEa4SetRUIVbei+KCmpR/TrA9NXDiTMUmZqxnI6G/823Ixw2OULWJXp6J8UnHLYMYhSrubSXsF8j9IBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmrV3VsE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmrV3VsE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B398D1F000E9;
	Fri, 26 Jun 2026 11:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782473524;
	bh=MJ3C/pAyKSq/dOLqJIjSAhHIxwbfelSCnj5pDHjgjls=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YmrV3VsEIXcALFBs3/TPGpVOI1XC+/gDwa27CY44qgaD57Jjv2jCkjBY6+6cub5OS
	 GuPlb/+p1AqO8I7lUXyntDaOpHTFpRS0QlU4rbPHmArPNR7FVd2Tr9Lgss30F4r3bL
	 pfjR64HsmWT3BcHNDP6Gkha5k2UUEd3ZNMKdQQtusS+RZwARM6fJSR1BlEDOq/PPOt
	 A9+6i7C7+naywWrZ6LuhDj+bkhhiE1CSww/nyXp4VBdV0io6Pz8CgJHi66QVLPF/AM
	 GLhW8+e/CWtoLXtMnk8fQtN/AZoD3L/CMgRabTDOXyIR7pQleOl+l1TtLveixW0Q3x
	 bCAiENgN3ET0Q==
Message-ID: <d1b55e87-cc63-4851-9dc5-94ee9d326333@kernel.org>
Date: Fri, 26 Jun 2026 20:32:02 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: sata_gemini: unwind clocks on IDE pinctrl errors
To: Myeonghun Pak <mhun512@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
References: <20260626085848.40199-1-mhun512@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260626085848.40199-1-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/26 17:58, Myeonghun Pak wrote:
> gemini_sata_bridge_init() prepares and enables both SATA PCLKs, then
> disables them again while keeping the clocks prepared for later bridge
> start and stop operations. If gemini_setup_ide_pins() fails after that,
> gemini_sata_probe() returns directly and skips the existing
> out_unprep_clk unwind path.
> 
> Route the IDE pinctrl failure through out_unprep_clk so the clocks
> prepared by gemini_sata_bridge_init() are unprepared before probe
> fails.
> 
> Fixes: d872ced29d5f ("ata: sata_gemini: Introduce explicit IDE pin control")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>

One of the above 2 is redundant I think.

> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/ata/sata_gemini.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
> index 582c9708275c..92984b34fd3b 100644
> --- a/drivers/ata/sata_gemini.c
> +++ b/drivers/ata/sata_gemini.c
> @@ -355,7 +355,7 @@ static int gemini_sata_probe(struct platform_device *pdev)
>  	if (sg->ide_pins) {
>  		ret = gemini_setup_ide_pins(dev);
>  		if (ret)
> -			return ret;
> +			goto out_unprep_clk;
>  	}
>  
>  	dev_info(dev, "set up the Gemini IDE/SATA nexus\n");


-- 
Damien Le Moal
Western Digital Research
