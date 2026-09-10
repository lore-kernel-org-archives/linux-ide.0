Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974433A7833
	for <linux-ide@vger.kernel.org>; Thu, 10 Sep 2026 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789043591; cv=none; b=LrEk0qU5zlzEXmZ1gu8vw7Azn//OjZ4IsZnvKSSRgXh1OrYpgUNZTM/cYP9YoOW2gSlSwujLmkdGxTak9mxewUnlD9cxbFg1+IDEnXZ8DdCESrbHYaV/SKGyfM0e99GutQvhxdKOjV52cOplJKXzcZJfHvCrCgaznzecwAipma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789043591; c=relaxed/simple;
	bh=BhRVwX3syvtVBr99TQKQqybOtBSPRImuv5m4VSZIM80=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NjvGGPVXC4QIFg1CkbNdQVl2l/nNdXErblUnyo+36Bzlu8xJHRL73eUrO57y/7Jq72MFTd8i/BtansufiKKjyFfCiQmh8H1cT92SwlbxWzo05cpezFrfQoo2gf33X18lYq0cGTftWDEUJmeIdTlp8M6qPk7lQ5maTixSK6QoDQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNk1ILfG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNk1ILfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F1A1F000FF;
	Thu, 10 Sep 2026 12:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789043590;
	bh=xOxNuY83e1fABg2xmBs55vONjUE608RjzFCw/uRFC4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gNk1ILfGdoQnswsXgVOzRL46RAvAKokJ+zkJUms1w0r52vxi49yhN+mrfoB/zDdcp
	 iSRh74iZpH+VA00lSGkQ3boXQc2JGbMNgUCNp3kcl7XXYWVwQ3uo+T0RCHhFWDznxR
	 6XxyRqapcRSuKbI4ExTOYj6cVyekmiwDfILrRIBQHS166ANGu2JwSIJQt/mL9Tn/Jo
	 M54dCQMo5GcJ7i10e+bFNtBGxtkCxpxB7i8LL0nImVgmMfk/4Su0A3wcNFQksRlhAQ
	 PhiKPcqCX2lEqqGNxqhGyHHMV6ZNqcDKuYNKeH8x8HLx0GUWSYbE6gpz92jsqj/XR9
	 5fuZHwADHDAsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] ata: libata: Do not leave ata_host_stop()
 registered when activation fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260910121900.97676-7-cassel@kernel.org>
References: <20260910121900.97676-5-cassel@kernel.org>
 <20260910121900.97676-7-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 12:33:09 +0000
Message-Id: <20260910123309.D0F1A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Missing explicit IRQ free in ahci_host_activate_multi_irqs() error=
 path introduces an MMIO Use-After-Disable race condition
- [Low] Outdated comment directly contradicts the newly implemented error h=
andling behavior

Pre-existing issues:
- [High] Double free and use-after-free of host_priv and hcr_base in sata_f=
sl_probe() during sysfs creation failure
--

commit 768c5e5ea22a8a90eb049d1a94799c1933e49e23
Author: Niklas Cassel <cassel@kernel.org>
ata: libata: Do not leave ata_host_stop() registered when activation fails

This patch addresses devres lifecycle issues by introducing
ata_host_undo_start() to correctly undo host start when activation fails.
It drops the devres action to prevent host_stop from being called during
cleanup when the probe caller manually releases resources.

> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 6d72eb017b498..7260adde8f7df 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2723,11 +2723,20 @@ static int ahci_host_activate_multi_irqs(struct a=
ta_host *host,
>  				0, pp->irq_desc, host->ports[i]);
> =20
>  		if (rc)
> -			return rc;
> +			goto undo_start;
>  		ata_port_desc_misc(host->ports[i], irq);
>  	}
> =20
> -	return ata_host_register(host, sht);
> +	rc =3D ata_host_register(host, sht);
> +	if (rc)
> +		goto undo_start;

[Severity: High]
Does this missing explicit IRQ free introduce an mmio use-after-disable
race condition?

If ata_host_register() fails here, we jump to undo_start and return an
error without explicitly freeing the IRQs. Because the IRQs are managed
by devm_request_irq(), they won't be freed until devres cleanup runs
after the probe function returns.

During this window, the caller's error path will manually disable the
hardware resources (clocks, regulators, phys), but the hardware
interrupts remain registered with the OS.

If a spurious interrupt fires during this time,
ahci_multi_irqs_intr_hard() could execute and read from unclocked mmio
registers, causing a synchronous external abort and kernel panic.

[ ... ]
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platfor=
m.c
> index 6e072d681341a..b44c0db4a86e6 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -689,6 +689,10 @@ EXPORT_SYMBOL_GPL(ahci_platform_get_resources);
>   * ahci-platform host, note any necessary resources (ie clks, phys, etc.)
>   * must be initialized / enabled before calling this.
>   *
> + * On failure, ->host_stop() is not called, so the caller has to release=
 the
> + * resources it enabled (clocks, regulators, resets, PHYs) in its probe()
> + * error path.

[Severity: High]
Does this documented teardown order reversal create a dangerous race? By
requiring the caller to manually disable resources before the devres-managed
IRQs are freed, could this open a window where active IRQs point to
disabled hardware?

[ ... ]
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 59e87b987d73e..30e1c3de2acc8 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
[ ... ]
> @@ -6245,27 +6295,40 @@ int ata_host_activate(struct ata_host *host, int =
irq,
[ ... ]
>  	rc =3D ata_host_register(host, sht);
> -	/* if failed, just free the IRQ and leave ports alone */
> -	if (rc)
> +	if (rc) {
> +		/* if failed, just free the IRQ and leave ports alone */
>  		devm_free_irq(host->dev, irq, host);
> +		goto undo_start;
> +	}

[Severity: Low]
Is this comment accurate now? The comment explicitly says "leave ports
alone", but we now jump to undo_start, which calls ata_host_undo_start()
to actively stop the ports.=20

Should the comment be updated to reflect the newly introduced behavior?

[ ... ]
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 70b210afd2911..299b2c886cbed 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -1490,8 +1490,12 @@ static int sata_fsl_probe(struct platform_device *=
ofdev)
>  	 * device discovery process, invoking our port_start() handler &
>  	 * error_handler() to execute a dummy Softreset EH session
>  	 */
> -	ata_host_activate(host, irq, sata_fsl_interrupt, SATA_FSL_IRQ_FLAG,
> -			  &sata_fsl_sht);
> +	retval =3D ata_host_activate(host, irq, sata_fsl_interrupt,
> +				   SATA_FSL_IRQ_FLAG, &sata_fsl_sht);
> +	if (retval) {
> +		sata_fsl_host_stop(host);
> +		return retval;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but does the later portion of
sata_fsl_probe() suffer from a double-free on sysfs creation failure?

If device_create_file() fails after a successful ata_host_activate(),
the code jumps to error_exit_with_cleanup:

sata_fsl_probe() {
    ...
error_exit_with_cleanup:
    if (host)
        ata_host_detach(host);
    if (hcr_base)
        iounmap(hcr_base);
    kfree(host_priv);
    return retval;
}

Because ata_host_activate() succeeded, ata_host_stop is still queued as
a devres action. When the probe fails and the driver core executes devres
cleanup, it invokes sata_fsl_host_stop(), which does the exact same cleanup:

static void sata_fsl_host_stop(struct ata_host *host)
{
        struct sata_fsl_host_priv *host_priv =3D host->private_data;

        iounmap(host_priv->hcr_base);
        kfree(host_priv);
}

Couldn't this trigger a double-free of host_priv and iounmap of hcr_base,
leading to slub corruption under memory pressure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910121900.9767=
6-5-cassel@kernel.org?part=3D2
