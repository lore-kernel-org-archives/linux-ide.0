Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F073CF21D
	for <linux-ide@vger.kernel.org>; Wed,  9 Sep 2026 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988058; cv=none; b=jsFsfKrNdVvu2nlTOEc+fSFOblGnjtF4KIhmW4j+uqjuAsql7Ri0V4VWYQSCJ30KxSD1nwvgFaPDgxsc+wsvzwoi0t94BYiZqkNtsY+nORCWy+BJaEXdTvsiYXF2ICQNjMBQT+fHfaPhFKPlS9xkHuCFBVUcS+GVQsJ+oiqtMZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988058; c=relaxed/simple;
	bh=/NH0673f9Xx2IQ4Dg5liTNxvB945oDFoOhCgHDeFRtU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t3rGP/K2k0ptxKeGABE8ebW1CAeWw4nnTDb6cK+oUZ3q6cgVLTK5wrO2w7K9Xnjip9UY2KB3XhN1h5GokcFdyvuwCikYT0KyGDTn1jmwio42YQxwElsxHJFAciCEnO5f/lJdABSNOwQ1xO/4b1JmNy+/8iREvlzODW95tSbEah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTlftd1h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTlftd1h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ECE1F00893;
	Wed,  9 Sep 2026 21:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788988057;
	bh=qhr+FdRhM8iC/qXGINTb2jsMKRCRWCEDmh7jnzHMXoo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fTlftd1hjfrHa6erUj5RcFFBxu3JTNs+Mn6VSL3g/cyzeKGAbn1NGJfobDXypUjml
	 qEmrSmkJ5Wlwx0KmPvwbu1+iyX6wnl92i6MzskuEDGeQOfwgrewnAowxQv6HIhH6fQ
	 AEoQxr+172UP63QrwPEJpgVjTZLqwjryf4MfkfTn5OoZMeINfqKP3GxpjtT5lIZGx6
	 C9rnPe1OKsp3kZBYnSr0ruZDjBBMzIvV+PzpFM/QzIgpyBpYApQdH3MIwNYxUkfgn9
	 uhzFZUSkdJn9Fq4d03tuQ0C7TZaDqmzP3nPrQOeDLZQ2ai3HfGewv30544Rt7iX8aY
	 58RZxfKGhYmPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ata: libata: Do not leave ata_host_stop() registered
 when activation fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20260909204317.5750-2-cassel@kernel.org>
References: <20260909204317.5750-2-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 21:07:35 +0000
Message-Id: <20260909210736.B9ECE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The generic helper ata_pci_init_one() skips .host_stop cleanup o=
n activation failure because ata_host_undo_start() destroys the devres acti=
on.
- [Medium] Missing ata_host_undo_start() on devres_open_group() failure in =
ata_pci_sff_activate_host() leaves the devres action registered, causing do=
uble host_stop() execution.

Pre-existing issues:
- [High] Pre-existing double-unmap and double-free in sata_fsl.c on device_=
create_file() failure.
--

commit 19ca4d6912533c209fda6772c9bbd7b4176f4fb0
Author: Niklas Cassel <cassel@kernel.org>

ata: libata: Do not leave ata_host_stop() registered when activation fails

ata_host_start() registers ata_host_stop() as a devres action as soon as
it has succeeded, which hands the release of the host resources over to
devres: ->port_stop() and ->host_stop() are then called by the driver
core when probe() fails.
   =20
ata_host_activate(), ahci_host_activate_multi_irqs() and
ata_pci_sff_activate_host() can all fail after ata_host_start() has
succeeded. A driver which releases the host resources in its probe() error
path therefore releases them twice: once itself and once through ->host_sto=
p().

Fixes: 1896b15eddb4 ("ahci_platform: perform platform exit in host_stop() h=
ook")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>

[ ... ]

> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 734e7c88439a7..faa20d817c850 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -2338,10 +2338,12 @@ int ata_pci_sff_activate_host(struct ata_host *ho=
st,
> =20
>  	rc =3D ata_host_register(host, sht);
>  out:
> -	if (rc =3D=3D 0)
> +	if (rc =3D=3D 0) {
>  		devres_remove_group(dev, NULL);
> -	else
> +	} else {
>  		devres_release_group(dev, NULL);
> +		ata_host_undo_start(host);
> +	}
> =20
>  	return rc;
>  }

[Severity: Medium]
When ata_host_undo_start() drops the devres action, does this cause
driver-specific teardown logic to be permanently skipped for generic caller=
s?

For example, when pata_amd.c uses ata_pci_bmdma_init_one(), which in turn
calls ata_pci_init_one():

drivers/ata/libata-sff.c:ata_pci_init_one() {
    ...
    rc =3D ata_pci_sff_activate_host(host, ata_sff_interrupt, sht);
out:
    if (rc =3D=3D 0)
        devres_remove_group(&pdev->dev, NULL);
    else
        devres_release_group(&pdev->dev, NULL);

    return rc;
}

Because ata_pci_init_one() relies on devres cleanup and does not manually c=
all
host->ops->host_stop(), it appears this teardown logic will now be skipped =
on
activation failure.

[Severity: Medium]
Can a failure earlier in ata_pci_sff_activate_host() leak the devres action?

If devres_open_group() fails due to memory pressure, it returns directly:

drivers/ata/libata-sff.c:ata_pci_sff_activate_host() {
    ...
    rc =3D ata_host_start(host);
    if (rc)
        return rc;

    if (!devres_open_group(dev, NULL, GFP_KERNEL))
        return -ENOMEM;
    ...
}

This bypasses the out: label and skips ata_host_undo_start(). Since callers
like nv_init_one() have been updated by this patch to manually call
host_stop() on error:

drivers/ata/sata_nv.c:nv_init_one() {
    ...
    rc =3D ata_pci_sff_activate_host(host, ipriv->irq_handler, ipriv->sht);
    if (rc && host->ops->host_stop)
        host->ops->host_stop(host);
    ...
}

Will this result in a double execution of the hardware teardown logic during
driver core devres cleanup?

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
> =20
>  	host_priv->intr_coalescing.show =3D fsl_sata_intr_coalescing_show;

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under
review, but does sata_fsl_probe() suffer from a double free and double
unmap on later error paths?

If ata_host_activate() succeeds, the devres action for ata_host_stop is
successfully registered. If a later step fails (like device_create_file()),
the code jumps to error_exit_with_cleanup:

drivers/ata/sata_fsl.c:sata_fsl_probe() {
    ...
error_exit_with_cleanup:
    if (host)
        ata_host_detach(host);

    if (hcr_base)
        iounmap(hcr_base);
    kfree(host_priv);

    return retval;
}

When the driver probe fails, devres cleanup will automatically execute
sata_fsl_host_stop(), which attempts to free and unmap the exact same
resources again:

drivers/ata/sata_fsl.c:sata_fsl_host_stop() {
    struct sata_fsl_host_priv *host_priv =3D host->private_data;

    iounmap(host_priv->hcr_base);
    kfree(host_priv);
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909204317.5750=
-2-cassel@kernel.org?part=3D1
