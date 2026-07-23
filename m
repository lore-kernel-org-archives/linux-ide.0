Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B77248886
	for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2026 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784766605; cv=none; b=mK9ox/Lp7HqQ8SwHFmWJglynr+iAQ0ZPZN3w7vNdcEYeOuhMfqMzEAKjvNsYdllLyHsUi9KpY2RlS6OZubmydZEaDr3oX3D9E6JtPMdI2J8658FwvSLNW2O8y/1uy3WtKkT2SVHWHsrgqQ1jC+oH7ZlO9pqPAKS0MXLi5eteuQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784766605; c=relaxed/simple;
	bh=aUkoDf07ELGZYyQIoltvMWaEvudfRb/+v36xKyrMdU8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nipXSYrDxf335Mpc6KDDN2pOzXahk46uyx8rvcjnHkiVCJXdEssMhglIdu/yD4RPbkgTrycLtXeWZzAXe1UKk9QhxvhzOlHtRolBXJMS1D3u8268/766a7ORYIYx7eoDYTosnJvmWjpedaK9vATfxb/EX3qpTpDowoLutVOqoTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRIPGYXA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRIPGYXA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693E11F000E9;
	Thu, 23 Jul 2026 00:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784766603;
	bh=eoutScsIuB1VOpVfZuvMPR9igifvqXOYyAC7M/lS4ns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LRIPGYXAOLY73Xh37yv9O5vk0kU+QAJz0K8Mow3ir0agELs8/p4aFzNTHReD3MqK6
	 IoQlD8J8fZJ4RAxuXqe5QgMdcXHRYTYdTVyi+49cfppTHlVt2Ze3MLVJhL8vEEss+A
	 AGaQRVeoza42gC+3YZcvkUvjl3jGc4SOYj7AOAEoDTU8MF8xbCoztj5cD+oyWW6psy
	 M1d7fUL4PmYDB+DmqpEeqXo+NfwRl/5lfmbME4R75DSqQf+CpToIlij3Sqyq2rWEMY
	 G0UBmmBkb6G1Eh6vIC4oUILVoqybd3dGyCEllJ6mCYQs/0yZQ2QOzY885LhxjJmFWu
	 lv9SYrdOUq2QQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] ata: sata_dwc_460ex: fix data race on
 hsdev->sactive_issued in interrupt handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260723001208.1469323-3-rosenp@gmail.com>
References: <20260723001208.1469323-1-rosenp@gmail.com>
 <20260723001208.1469323-3-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 00:30:02 +0000
Message-Id: <20260723003003.693E11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditionally clearing hsdev->sactive_issued to 0 on every ISR e=
ntry breaks NCQ completion tracking, which the patch fails to address.
- [High] The driver unconditionally reads ap->link.active_tag without check=
ing for ATA_TAG_POISON, causing out-of-bounds array accesses in error and D=
MA paths.
--

--- Patch [2]: [PATCH 2/3] ata: sata_dwc_460ex: fix data race on hsdev->sac=
tive_issued in interrupt handler ---
commit 2519582df93a7a74dcbe39c71c593d6dad63fb71
Author: Rosen Penev <rosenp@gmail.com>

ata: sata_dwc_460ex: fix data race on hsdev->sactive_issued in interrupt ha=
ndler

This commit moves the zeroing of hsdev->sactive_issued inside the host
spinlock critical section in sata_dwc_isr() to prevent a data race with
sata_dwc_qc_complete().

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 8a1d80ac906a7..73bacdfd0bd31 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -465,9 +465,9 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_in=
stance)
>  	int handled, port =3D 0;
>  	uint intpr, sactive, sactive2, tag_mask;
>  	struct sata_dwc_device_port *hsdevp;
> -	hsdev->sactive_issued =3D 0;
> =20
>  	spin_lock_irqsave(&host->lock, flags);
> +	hsdev->sactive_issued =3D 0;

[Severity: High]
This is a pre-existing issue, but does moving this assignment actually
resolve the underlying problem? Unconditionally clearing
hsdev->sactive_issued to 0 on every ISR entry seems to break NCQ
completion tracking.

When an NCQ completion interrupt fires, sactive_issued will be 0. The
driver then calculates tag_mask =3D (0 | sactive) ^ sactive, which always
evaluates to 0 because sactive clears the bit for completed commands.

With tag_mask =3D=3D 0, will the driver skip the NCQ completion block and
leave the command to time out?

> =20
>  	/* Read the interrupt register */
>  	intpr =3D sata_dwc_readl(&hsdev->sata_dwc_regs->intpr);


[Severity: High]
This is also a pre-existing issue, but I noticed another potential problem
in sata_dwc_error_intr() and the DMA completion paths.

Does this code potentially perform out-of-bounds array accesses?

drivers/ata/sata_dwc_460ex.c:sata_dwc_error_intr() {
        ...
        tag =3D ap->link.active_tag;

        dev_err(ap->dev,
                "%s SCR_ERROR=3D0x%08x intpr=3D0x%08x status=3D0x%08x dma_i=
ntp=3D%d pending=3D%d issued=3D%d",
                __func__, serror, intpr, status, hsdevp->dma_interrupt_coun=
t,
                hsdevp->dma_pending[tag], hsdevp->cmd_issued[tag]);
        ...
}

When an error interrupt occurs while no command is active,
ap->link.active_tag is set to ATA_TAG_POISON (0xfafbfcfdU).

The driver truncates this to a u8 (253) and uses it directly as an index
into the hsdevp->dma_pending and hsdevp->cmd_issued arrays, which are
sized SATA_DWC_QCMD_MAX (33).

Could this result in leaking arbitrary memory up to ~1000 bytes past the
arrays into dmesg via dev_err()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723001208.1469=
323-1-rosenp@gmail.com?part=3D2
