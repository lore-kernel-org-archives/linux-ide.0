Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363DF2264CA
	for <linux-ide@vger.kernel.org>; Wed,  9 Sep 2026 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980860; cv=none; b=qBMrJ5Q4KGj+GM3qp6rj4GbO5qtWRmSADVhfortHYOUiT3uTolwO21CI+aGS6ouTSQsoIF/1CAVzmoE1WAP5qvxKm5VBVSdVLdWABZtkEyTOMF/RHRMuQVerceu/3+yO221wAx1CdElriDvZsC95Vp+YWtUcL1OScsMIx5myxp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980860; c=relaxed/simple;
	bh=9BWaPcC8IcpOnoIkWO4bKLNFvLi88cx0bIwmBO+MOCs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QGEfijvoBDf3LQhpiyprm65QmfvnkbgYJ8jG/+TGowIQC2gTt/MWVrFz06ZVOf/UrLGBL5pSi53jqvx5dLoTQrZ5skssXvvRw+OTsU4zUZdBKN3xOhmC3Gw0kYF46dIJhDp7WHlr8uFzbJXNiboCR1iJrS2omDaeHXIDsywDk2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDZBKb2K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDZBKb2K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB3F1F000FF;
	Wed,  9 Sep 2026 19:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980859;
	bh=D+xA6xxWQtFyeUQxN+ugQ9lXUbf6u2rI9T2p/tG9XRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oDZBKb2KOz4LPBgkb3re2vRUD4zhfM0Xf6XCoSQFUP0FxzBbSG6Z9Ye2/P3P1hUh/
	 I4amnbphN5wGINyK103vpvd0K5vUVehXTCi1q1iAR16TF1OJGPAAZ5/F19k/IBajSs
	 xqm+vqi8k1QqB9yGv918ZYfJn6+zuiNYja28UWPl2q9dMi65FAnTOVI7RbtKORBYqG
	 cJ123geDgjXPECTcgBI5TQH4WhypOOUaa06n5aQ/ydvdmeLvRQden+m0vOGaGOdiDJ
	 Tn9iFWH4IpFeshjjKs/fK/bp+J9r42iRAnrJkFvoNq2UCZ0eChroEUSTOxgTdrrJK8
	 x8NOTxS6R/woQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: libata: Do not leave ata_host_stop() registered
 when activation fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260909185035.3130774-2-cassel@kernel.org>
References: <20260909185035.3130774-2-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 19:07:38 +0000
Message-Id: <20260909190738.DAB3F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Bypassing `->host_stop()` on activation failure via `ata_host_undo=
_start()` breaks legacy PCI and OF drivers that rely on devres for hardware=
 and resource cleanup, leading to state/memory leaks and interrupt storms.

Pre-existing issues:
- [High] Missing IRQ cleanup in ahci_host_activate_multi_irqs error path le=
ads to active interrupts during hardware teardown.
--

commit 33ab74bb11edbc6ab549b2a41db1917c6750487f
Author: Niklas Cassel <cassel@kernel.org>

ata: libata: Do not leave ata_host_stop() registered when activation fails

ata_host_start() registers ata_host_stop() as a devres action. This patch
adds ata_host_undo_start() to stop the ports and drop the devres action
without calling ->host_stop() when activation helpers fail, returning
resource release responsibility to the caller.

> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 6d72eb017b498..7ac1fcdd6d0d7 100644
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
> +
> +	return 0;
> +
> +undo_start:
> +	ata_host_undo_start(host);
> +
> +	return rc;

[Severity: High]
This is a pre-existing issue, but by not freeing the successfully requested
IRQs in this error path before returning, can we cause a kernel panic?

If devm_request_irq() fails for one port, or if ata_host_register() fails,
this jumps to undo_start and returns an error without freeing the IRQs.

The caller (ahci_platform_init_host) and platform driver will then disable
clocks and PHYs via ahci_platform_disable_resources(). If a pending interru=
pt
fires before the generic devres cleanup eventually frees the IRQs, the
interrupt handler (ahci_multi_irqs_intr_hard) will attempt to access uncloc=
ked
AHCI registers.

>  }
> =20
>  /**
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 59e87b987d73e..4c0ee207f4c64 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
[ ... ]
> +void ata_host_undo_start(struct ata_host *host)
> +{
> +	int i;
> +
> +	if (!(host->flags & ATA_HOST_STARTED))
> +		return;
> +
> +	for (i =3D 0; i < host->n_ports; i++) {
> +		struct ata_port *ap =3D host->ports[i];
> +
> +		if (ap->ops->port_stop)
> +			ap->ops->port_stop(ap);
> +	}
> +
> +	/*
> +	 * Drop the action added by ata_host_start() without calling it.
> +	 * It does not exist if neither ->port_stop() nor ->host_stop() is
> +	 * implemented, in which case there is nothing to drop.
> +	 */
> +	devres_destroy(host->dev, ata_host_stop, NULL, NULL);

[Severity: High]
Does bypassing ->host_stop() here break legacy PCI and OF drivers that rely
entirely on the devres action for hardware and resource cleanup?

For instance, sata_qstor enables hardware interrupts in qs_ata_init_one():

	qs_host_init(host, board_idx);
	pci_set_master(pdev);
	return ata_host_activate(host, pdev->irq, qs_intr, IRQF_SHARED,
				 &qs_ata_sht);

If ata_host_activate() fails, the driver relies on qs_host_stop() to disable
interrupts. By skipping ->host_stop(), wouldn't unhandled hardware interrup=
ts
remain enabled, potentially causing an interrupt storm?

Similarly, sata_nv programs ADMA configuration into PCI registers before
calling ata_pci_sff_activate_host() in nv_init_one(). If activation fails,
nv_adma_host_stop() is bypassed. Does this leak the hardware ADMA
configuration state?

Also, in sata_fsl_probe(), the return value of ata_host_activate() is ignor=
ed,
leaving the device bound despite activation failure. With ->host_stop()
bypassed, will this cause resources to leak on unbind?

> +
> +	host->flags &=3D ~ATA_HOST_STARTED;
> +}
> +EXPORT_SYMBOL_GPL(ata_host_undo_start);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909185035.3130=
774-2-cassel@kernel.org?part=3D1
