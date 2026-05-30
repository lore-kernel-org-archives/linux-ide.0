Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244812D7380
	for <linux-ide@vger.kernel.org>; Sat, 30 May 2026 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102168; cv=none; b=Dt7juU9WLO0apRaJzGckKXuF4XcapkBAK5iudjyIbxDZy5iO0isz7eLSCXQYR6rOsI20bHpZePWtxfaenqNsV/EWzvw/jqeKs2N55VjQFvg3igC1803rtLf654127HUxJYG9xqcAtllwUE4ye2SL8pA/CpKARdQDQCTHj9Bus9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102168; c=relaxed/simple;
	bh=YI45N/HRTizcHs312KqTH5Jc52OsnG2BHnz99j+CYok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=doEmalUIokrs0Vx8rRq++blFWAnvcmnQwyROobY+b24DFR9IT/EqOmX2+p/AZpqm67vrKdhZJZu29DT77ABnTZdtHtsVgPRBUEa9pwLKKQqIYw0B4NFlWak/Pp4oYaOhIiP4JKQNdZg6ZapaVSqZpB5bNiTXSFbTLcIDmwGy8JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWkj9S1i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWkj9S1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55711F00893;
	Sat, 30 May 2026 00:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102167;
	bh=nk5gem4nmWV/Y7lARpQ2+Jw0On3iN45pv6O7YZPnGfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MWkj9S1i4VBceLPMCJ5yMqWf2hJADT0lcrkECtH/yxJZqOT7Jz1LVbj3ryBWEfMWI
	 srN3O/fCbGpCLBRFrWPIrV6By2a5Z4J2npjYy3IHR72rUOPcTu976LEVFT96mBMPjk
	 c0FrtgiibBbHpS/i5ZkqJd5EZuCt3Nt8omKwqcnipsXIX6kqy68/eqyLwaawHJtFQ3
	 AoJcZq8Jcildi9zbK4POsOZaE3B+tZN+EqMB1O1GrKD/EM+1ZnomEx4UEcqtqoPpIz
	 ZtPte/VovXoyrXbNb0oH/W7mJvVSp4XQ7JtkI5gU/8/gKzyb4kvtrjsjyE76++JCZU
	 Mnlrwd51AHHOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] ata: pata_ep93xx: avoid asm on non ARM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260530003627.42473-2-rosenp@gmail.com>
References: <20260530003627.42473-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:49:26 +0000
Message-Id: <20260530004926.C55711F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing condition code clobber in inline assembly.
- [High] Double free and invalid pointer dereference on DMA probe error pat=
h.
--

commit 161745bc82337864b2d7b61cafb8fabbb474d029
Author: Rosen Penev <rosenp@gmail.com>

ata: pata_ep93xx: avoid asm on non ARM

The raw ARM asm delay loop prevents COMPILE_TEST builds on
non-ARM architectures. Guard it with CONFIG_ARM and provide a
cpu_relax() fallback for compilation on other architectures.

> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> index b2b9e0058333e..f7e87d6af2641 100644
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c
> @@ -204,6 +204,7 @@ static void ep93xx_pata_enable_pio(void __iomem *base=
, int pio_mode)
>   */
>  static void ep93xx_pata_delay(unsigned long count)
>  {
> +#ifdef CONFIG_ARM
>  	__asm__ volatile (
>  		"0:\n"
>  		"mov r0, r0\n"
>  		"subs %0, %1, #1\n"
>  		"bge 0b\n"
>  		: "=3Dr" (count)
>  		: "0" (count)
>  	);

[Severity: High]
This is a pre-existing issue, but since this inline assembly uses the
"subs" instruction which alters the ARM condition code flags, does it
need a "cc" clobber?

Without the "cc" clobber, the compiler might assume that condition flags
set prior to the inline assembly remain valid across it. Because
ep93xx_pata_delay() is a small static function, it's likely to be
inlined into callers like ep93xx_pata_wait_for_iordy(). Could this lead
to unpredictable control flow corruption if the compiler schedules
flag-dependent instructions across the assembly block?

> +#else
> +	while (count--)
> +		cpu_relax();
> +#endif
>  }

[Severity: High]
This is a pre-existing issue, but I noticed a potential double free and
invalid pointer dereference on the DMA probe error path in this driver.

If dma_request_chan(&pdev->dev, "tx") fails during ep93xx_pata_dma_init(),
it returns an ERR_PTR which is stored in drv_data->dma_tx_channel.

The error path jumps to fail_release_rx, which releases dma_rx_channel but
doesn't clear the pointer, and then falls through to ep93xx_pata_release_dm=
a():

drivers/ata/pata_ep93xx.c:ep93xx_pata_dma_init() {
    ...
fail_release_rx:
	dma_release_channel(drv_data->dma_rx_channel);
fail_release_dma:
	ep93xx_pata_release_dma(drv_data);
    ...
}

Inside ep93xx_pata_release_dma(), the code attempts to free both channels:

drivers/ata/pata_ep93xx.c:ep93xx_pata_release_dma() {
    ...
	if (drv_data->dma_rx_channel) {
		dma_release_channel(drv_data->dma_rx_channel);
		drv_data->dma_rx_channel =3D NULL;
	}
	if (drv_data->dma_tx_channel) {
		dma_release_channel(drv_data->dma_tx_channel);
		drv_data->dma_tx_channel =3D NULL;
	}
    ...
}

Since drv_data->dma_rx_channel was never set to NULL, does this cause a
double free of dma_rx_channel?

Additionally, since drv_data->dma_tx_channel holds an ERR_PTR rather than
NULL, this check evaluates to true and dma_release_channel() is called with
the ERR_PTR. Could this cause a kernel panic when the DMA subsystem attempts
to dereference the error pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530003627.4247=
3-1-rosenp@gmail.com?part=3D1
