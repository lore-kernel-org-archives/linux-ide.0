Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533C370AE7
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 02:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783565749; cv=none; b=iljMp8YUUT+CmXGEFCg9FM+fHGnHcOU9qgZs8yhlPm+3XAh86IVw0cUPO/8XikBmVkNy7IOjYtV67mfXOAhGZIZZlF/XX/0SuQ6S0l/9SL1XRSPuVrfgkfag1OAdb6yoJIxohXmg70Fq1LTGPSBG3C9f7duJIaS4h8U70s/h7lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783565749; c=relaxed/simple;
	bh=85VcJmdvtcOIbWAQFdQoCZwWFzfXuT2YaP6/BIsdqEM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CNlXYR0r/MtMPqq22Ks/MYIgZsihNLtx8ALmWOZJ5KFBotvd+FCofqMXrQXs/0t2JJ21qpwaIcl3hzstmiiVuDdk6cRtHPh23OR3f8MdRSxRQw+6IXWZ7NO8PD6z84l1iEpIYcfGiydXgjrVhFWnCmvSP0iFmpEo14GsInEVphU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMJ68Yii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMJ68Yii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0331F000E9;
	Thu,  9 Jul 2026 02:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783565747;
	bh=NEHV0l0/PsWqL5RCvVF8EwrX1oYn+6cBdCAousG3NiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PMJ68Yii5Mc2YBvK4YjJq+j594j0fHxsjqANfAcaTAm6E8vn/+CPzLMzT3QhRNheC
	 3os1ooZYM3Xw170Nf0BSpNVFBf//N4i+cxy8bAHq9wNSBfUWD16p2MR/cm3bCFF8Sj
	 Qh0jbHDXo3uYjLoIVp+atgk17u6ubgHtNsU5TCox1+o9GgjImCeEVNuwn7fvTV82Zg
	 19z3syiwU0K59191HfCbM0Muu/8Rp4cScs+cdZDN8TaXOmQh6I0JxtF7qn9LVMebbm
	 /3U4c7Jpw9ggz3s/sUQvkRK384apQnEOScCXPBP6uIH8H4gSbvK8RZ4LNElMqH5x3e
	 MKqCjTPVA2xyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 5/5] ata: sata_dwc_460ex: disable SATA interrupts on
 device removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260709023202.2132165-6-rosenp@gmail.com>
References: <20260709023202.2132165-1-rosenp@gmail.com>
 <20260709023202.2132165-6-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 02:55:46 +0000
Message-Id: <20260709025547.3A0331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Disabling hardware interrupts before `ata_host_detach()` prevents =
pending I/O and device unload commands from completing, resulting in comman=
d timeouts during teardown.
- [High] `sata_dwc_disable_interrupts()` is called in the remove path witho=
ut synchronization, creating a race with the Error Handling (EH) thread tha=
t can cause interrupts to be incorrectly re-enabled.

Pre-existing issues:
- [High] Pre-existing race condition missing IRQ synchronization before fre=
eing DMA and PHY resources during device removal, risking Use-After-Free.
- [High] `clear_interrupt_bit()` unintentionally clears all pending interru=
pts, causing lost interrupts due to a flawed read-modify-write on a W1C reg=
ister.
--

--- Patch [1]: [PATCHv3 5/5] ata: sata_dwc_460ex: disable SATA interrupts o=
n device removal ---
commit 65387714eba3b122c58a0cdaf1a76af59f78680c
Author: Rosen Penev <rosenp@gmail.com>
Subject: ata: sata_dwc_460ex: disable SATA interrupts on device removal

This commit adds sata_dwc_disable_interrupts() and calls it at the
beginning of sata_dwc_remove() to prevent unhandled interrupt storms
during host teardown.

Fixes: 62936009f35a ("[libata] Add 460EX on-chip SATA driver, sata_dwc_460e=
x"

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 4fc22ce4bd9aa..7c858a7992c9c 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c

[ ... ]

> @@ -1217,6 +1225,8 @@ static void sata_dwc_remove(struct platform_device =
*ofdev)
>  	struct ata_host *host =3D dev_get_drvdata(dev);
>  	struct sata_dwc_device *hsdev =3D host->private_data;
> =20
> +	sata_dwc_disable_interrupts(hsdev);
> +

[Severity: High]
Does this cause teardown commands to time out?

When sata_dwc_remove() calls ata_host_detach(), the SCSI devices are
detached, which typically issues teardown commands like SYNCHRONIZE CACHE.
Because interrupts are already masked by sata_dwc_disable_interrupts(), will
these commands fail to receive their completion IRQs and hang until they ti=
me
out?

[Severity: High]
Does masking interrupts here also create a race with the libata error handl=
er?

If the teardown commands time out as mentioned above, the libata error
handling (EH) thread will execute. The EH thread calls sata_dwc_hardreset(),
which explicitly calls sata_dwc_enable_interrupts(). Could this inadvertent=
ly
re-enable interrupts while sata_dwc_remove() is still running, recreating t=
he
interrupt storm this patch is trying to fix?

>  	ata_host_detach(host);
> =20
>  	phy_exit(hsdev->phy);

[Severity: High]
This is a pre-existing issue, but does device removal leave a use-after-free
window?

In sata_dwc_remove(), the PHY and DMA resources are destroyed before the
devres-managed IRQ handler is unregistered. If an unexpected interrupt fires
and sata_dwc_isr() executes, could it access these freed resources before
devres cleans up the IRQ?

[ ... ]

While reviewing this driver, I noticed another pre-existing issue not touch=
ed
by this patch:

drivers/ata/sata_dwc_460ex.c:clear_interrupt_bit() {
    ...
    sata_dwc_writel(&hsdev->sata_dwc_regs->intpr,
                    sata_dwc_readl(&hsdev->sata_dwc_regs->intpr));
}

[Severity: High]
This is a pre-existing issue, but does clear_interrupt_bit() unintentionally
clear all pending interrupts?

Looking at clear_interrupt_bit(), the function ignores its 'bit' argument a=
nd
reads then writes back the intpr register. Because intpr is a write-1-to-cl=
ear
(W1C) register, does writing back the read value clear every currently pend=
ing
interrupt, including those that have arrived since the ISR started but have=
n't
been processed yet?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709023202.2132=
165-6-rosenp@gmail.com?part=3D1
