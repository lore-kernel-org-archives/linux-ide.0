Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB19D34DCC7
	for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 20:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851764; cv=none; b=IxU9GLws13sg/dspVGdjeuPM6y5ReTD/Yx+hx0dlf4O/U9gNetZ0hGwIaZvuxM0hAbZuNzXCiXKWLUMB7Rf59p2MjNceof2REq/gc/01oLLTbVN76kI/md7g7RPY+vlOV7WKLRW76LX/v+5vxsvPdAGZV/X5HOv1Z7bBQziH4Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851764; c=relaxed/simple;
	bh=78Tz8G53fUTEayc7/zQ8rEnRaNUVXpgscc6iBXY6VSY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=saiRds3e8MUqRaZ4qyBm53fcRHtXUkJaUdG/YDDBnsLfB6gvuc45jZVPNgrMCvAXGYjTVNWgvMTLBRum2oHKagTpfr1BWzeGvm51GrRK/qzxHJrR2W4qepzrkgKqTZ/4IUXNEf/QWrg1krUDLzClUoHjRx3GBYU0LQv2xPd3Adk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iR6r6lPU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iR6r6lPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAA51F000E9;
	Tue, 30 Jun 2026 20:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782851763;
	bh=At6vzaatUsgOfOvuy6+bjpLsH3suDqeS34LRwhu8oR4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iR6r6lPUU5O0O5XgiFiZ68mOOIC1WhgytGBPMiBFC+yyn7aWX2mZhprcmoVgdG5IT
	 NNkJgiEG2qMyu11nJnfjzGNdrT4cjw0lexGZf5Cnbqyocz3bUCNiaU6a+ZcCsGvu9D
	 17gw5jI4PdLpwMak6aSG2ywFudJ4/Jw3WDWt2ZfQv4M0u6G0z/T6KXa86vdDhAySyw
	 h3pLnws9z0WHpTxkGQifbiUoZvqFCLT11foFTXZs86oOk6kr1IEkEOFZ9sjve0qiQM
	 jFW4hZI3B9o7rehxC2q5WHBqctnNcUte/udgn0B8dlc43OF1ATcFN4R0eIylDcvTL4
	 nEE1hYJnnUEWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] ata: sata_dwc_460ex: use device_property_present()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260630202415.234463-2-rosenp@gmail.com>
References: <20260630202415.234463-1-rosenp@gmail.com>
 <20260630202415.234463-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 20:36:02 +0000
Message-Id: <20260630203603.0FAA51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Incomplete refactoring: missed identical `of_property_present` patt=
ern.
- [Low] Direct usage of `device_property_present()` without including `<lin=
ux/property.h>`.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but `clear_interrupt=
_bit()` ignores its `bit` argument and accidentally clears all pending inte=
rrupts.
--

commit 3c350702aea5f359b0516233c160076946c26124
Author: Rosen Penev <rosenp@gmail.com>

ata: sata_dwc_460ex: use device_property_present()

There's no need to use np here when dev is enough. Follows the similar
pattern elsewhere where of APIs are replaced with device ones,
especially when using platform_device.

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 4fc22ce4bd9aa..2bcb3ac5ae211 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -1180,7 +1180,7 @@ static int sata_dwc_probe(struct platform_device *o=
fdev)
>  	}
> =20
>  #ifdef CONFIG_SATA_DWC_OLD_DMA
> -	if (!of_property_present(np, "dmas")) {
> +	if (!device_property_present(dev, "dmas")) {

[Severity: Low]
Does this require including linux/property.h? The build currently succeeds
due to transitive includes, but it might be safer to include the header
directly to prevent future build breakages if the include chain changes.

[Severity: Low]
Is the intention to replace all of_property_present usages? Looking at
sata_dwc_dma_get_channel() in the same file, it still uses the old function:

	if (!of_property_present(dev->of_node, "dmas"))

Should this be updated as well for consistency?

[Severity: High]
This is a pre-existing issue, but clear_interrupt_bit() seems to ignore its
bit argument and accidentally clears all pending interrupts:

static void clear_interrupt_bit(struct sata_dwc_device *hsdev, u32 bit)
{
	sata_dwc_writel(&hsdev->sata_dwc_regs->intpr,
			sata_dwc_readl(&hsdev->sata_dwc_regs->intpr));
}

Because it reads the entire intpr register and writes it back unmodified,
does this acknowledge and clear all pending interrupts in the write-1-to-cl=
ear
register instead of just the requested bit? This could drop device
interrupts when multiple interrupts are asserted simultaneously.

>  		err =3D sata_dwc_dma_init_old(ofdev, hsdev);
>  		if (err)
>  			return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630202415.2344=
63-1-rosenp@gmail.com?part=3D1
