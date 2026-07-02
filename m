Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F7741C71
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782951494; cv=none; b=e2ffAHnqqFT5gxjIhVu+kVuGpEfV3sUMpScZI6E1hehE4ujlPIowFkjJYwGWRTScM6ypLjUK/yznlumPk5HPUCg2Glkqer8+pRl3MgZBTDifYUt/Yn3m8VgEpwlFlilfR3jAhAu1sXftjsgXKyLVRSlXBO+jFgguFilFH5LW26w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782951494; c=relaxed/simple;
	bh=lmN1mzYhFW0s0Ay2Y7wWfcBI5QbeIe9Ot7oi5FhBr4Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XEhAG6nEr8adg1c19L+N/ZsvsdfY5TCkMwlEhzI2+YHFpnbS1Ng/HODNOsz8GWPJHsO7TIWq37HfGemKL2tKmOVuU4RFW6o0cePLuk84zkihbwU7K+YCePNXARMjhXxfiCZw42rS+P0WyYthg5WwFiyX2IbNsA1aozhYdYg15bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOaWwMmX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOaWwMmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F45D1F000E9;
	Thu,  2 Jul 2026 00:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782951493;
	bh=Yf5c7+zVGecK+1q/csiok/mtjFlyBtLpYBTSzbs7WCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VOaWwMmXnNFSPiKgSBdm6YqQsL5jb+pxHWVuiTXsxba/BxiVVx8Bg/Bb0JSLVcz11
	 Er7u0CpYABHpuLkT7vAMh+HXsYLXNVmhTtiSID6rYbh5+tsI0BtLp3i0yT50QtpQha
	 uZuN3bqHaedcuv0Rf/G6ryokXHT7QAFF34E4jQCq3kN8b6IhA5483h5fXS8oifwDUP
	 tFhCVGpxNdGQCxpL0Csaa3DML9eDCoy+Ne6uKCXcZxIWPETNuP2rqyzGrkMwxB13uo
	 zOXev4KPRLpges/hEgJUdsgbB1c0jZp5Y6VuFIQekJRZ1EetEJYyIgBA/EoIKUw0SF
	 e+5sy4a1c7wfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 6/8] ata: sata_dwc_460ex: disable SATA interrupts on
 device removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260702000350.68331-7-rosenp@gmail.com>
References: <20260702000350.68331-1-rosenp@gmail.com>
 <20260702000350.68331-7-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 00:18:12 +0000
Message-Id: <20260702001813.0F45D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Masking hardware interrupts before calling ata_host_detach() break=
s the SCSI teardown sequence, leading to command timeouts, shutdown hangs, =
and potentially unwritten disk caches.
- [Medium] Missing read-back to flush posted writes when disabling hardware=
 interrupts in sata_dwc_disable_interrupts().

Pre-existing issues:
- [High] sata_dwc_probe() incorrectly returns 0 (success) even if ata_host_=
activate() fails, leading to unhandled error paths and crashes on remove.
- [High] Masking interrupts without calling synchronize_irq() allows an in-=
flight interrupt handler to execute concurrently with hardware teardown.
--

commit df81e2008992f864aa17e308c42b08931c2b48f5
Author: Rosen Penev <rosenp@gmail.com>

ata: sata_dwc_460ex: disable SATA interrupts on device removal

This commit adds sata_dwc_disable_interrupts() and calls it at the beginning
of sata_dwc_remove(). It masks the controller's INTMR and ERRMR registers to
prevent unhandled interrupt storms during teardown.

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 4fc22ce4bd9aa..62580a58ad76e 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -762,6 +762,12 @@ static int sata_dwc_qc_complete(struct ata_port *ap,=
 struct ata_queued_cmd *qc)
>  	return 0;
>  }
> =20
> +static void sata_dwc_disable_interrupts(struct sata_dwc_device *hsdev)
> +{
> +	sata_dwc_writel(&hsdev->sata_dwc_regs->intmr, 0);
> +	sata_dwc_writel(&hsdev->sata_dwc_regs->errmr, 0);

[Severity: Medium]
Will these posted writes reach the hardware predictably before the CPU moves
on to tear down the device?

Since sata_dwc_writel() wraps writel_relaxed(), writes to the memory-mapped
registers over the system bus can be posted. Without a subsequent dummy read
to a controller register to flush them, the interrupt mask configuration mi=
ght
be delayed in write buffers. This could allow an interrupt to fire during
teardown, which is exactly what this change is intended to prevent.

> +}
> +

[ ... ]

> @@ -1217,6 +1223,8 @@ static void sata_dwc_remove(struct platform_device =
*ofdev)
>  	struct ata_host *host =3D dev_get_drvdata(dev);
>  	struct sata_dwc_device *hsdev =3D host->private_data;
> =20
> +	sata_dwc_disable_interrupts(hsdev);
> +

[Severity: High]
Does masking interrupts here break the SCSI teardown sequence?

When ata_host_detach() is called, it instructs the SCSI layer to issue cache
flush and spindown commands. If hardware interrupts are already masked, won=
't
these commands fail to complete and eventually time out? This could lead to=
 a
system hang during device removal and potential data loss if caches are not
successfully flushed.

[Severity: High]
This isn't a bug introduced by this patch, but does the teardown sequence
leave a race window with the still-registered ISR?

The interrupt handler is registered using devm_request_irq() and is only
freed by devres after sata_dwc_remove() returns. While the new masking stops
new interrupts, it does not wait for an already-running ISR on another CPU =
to
finish. Since synchronize_irq() isn't called, could the ISR execute
concurrently with ata_host_detach(), phy_exit(), and sata_dwc_dma_exit_old(=
),
accessing freed memory or hardware in an invalid state?

[Severity: High]
This is a pre-existing issue, but can sata_dwc_remove() crash if the initial
device probe failed?

Looking at sata_dwc_probe():

    err =3D ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
    if (err)
        dev_err(dev, "failed to activate host");

    return 0;

If ata_host_activate() fails, probe still returns 0 (success). When the
driver is later unbound, sata_dwc_remove() will unconditionally call
ata_host_detach() and attempt to tear down host structures that were never
successfully initialized, potentially causing a NULL pointer dereference or
list corruption.

>  	ata_host_detach(host);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702000350.6833=
1-7-rosenp@gmail.com?part=3D1
