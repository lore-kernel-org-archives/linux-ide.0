Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8997C37CD3C
	for <linux-ide@vger.kernel.org>; Thu, 25 Jun 2026 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397657; cv=none; b=M/Ds0n4dh7PqSEc4oWVHhn5Mjw+6Lca2ZxYErvsPTfrtlvTRXjarNepnvm/DvZRtAi72EScE9hQpWnfBPgXFi+wjfgHqA7bGa80iNFtAM2P1gI9EWraxGcb7rEJQwFYjsc9qsnz6AXNw1MZ0IO+Dzihkd4NH3KwT8RDqUI0xbW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397657; c=relaxed/simple;
	bh=2jR07+0CImeoB1TLwpwRdfH1LRIXzmyESrOY5P1ZjLo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MuQBfeIyABlZKzr/CRNz6Qa7CyoTcIGn/X0PFAL9aUh5Fp34Cr9C61DB+BDV5n3m8K6hOS7628scXGlbOZ34/esle46ZOp71qKxEMsosuQklv2HvX8PCm/1uSQ9p+HqSgVZSyKbcTVAZ8PS0FXR9XvBHr+TU+Vl78x9ETaTGLuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaDshW3k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaDshW3k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4361F000E9;
	Thu, 25 Jun 2026 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782397651;
	bh=HdQR74P9JWQagrchKuMBSu/rjv2p4da3QSroL6um7js=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZaDshW3kJNwBLLoHxTONSGyZ96WtRI0XDtWfA9QBm5ov+PSGXUrbNs7cnGzE5xW6D
	 bTMEG0hip/Ti6w0YhuQ3DnkKzSZcT276LrjwGH+OrOV1NIysuD164XhO0bAlMjTcbd
	 5THH2xdxOs0LZ2t3p3l/LJJRAA5PpVatTQFFpPBYUTOuXSNWS5MuXxKX0jq+gsV0M5
	 8kme9JgT3YprSfY80+VK2frl7Ak0+q2+9F6prV5ZAOGMqJU1Npv6L6sAUUl0fWmtF6
	 Qz+hiJAJKmfWfUtMmkTkOEY+Mgt7aQFh6pI6pYnffwHW0mn2QuScoE7RFk3lyC9/zW
	 8fky5FiGzBcSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: pata_pxa: Fix DMA channel leak on probe error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260625141837.62362-1-vulab@iscas.ac.cn>
References: <20260625141837.62362-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 14:27:31 +0000
Message-Id: <20260625142731.9F4361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect teardown order in `pxa_ata_remove()` releases the DMA ch=
annel before detaching the ATA host, creating a use-after-free window.
- [High] Missing NULL check for platform data (`pdata`) before dereferencin=
g it in the probe function.
- [High] Returning `AC_ERR_OK` when DMA descriptor preparation fails leads =
to an unrecoverable 30-second ATA command timeout.
--

commit fb8345f4cc3cb507abc9c29fac4d410d641eab22
Author: Wentao Liang <vulab@iscas.ac.cn>
Subject: ata: pata_pxa: Fix DMA channel leak on probe error

When dmaengine_slave_config() fails, the DMA channel acquired by
dma_request_chan() is not released before returning the error,
leaking the channel reference. This commit adds dma_release_channel()
in the error path.

> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
> index 03dbaf4a13a75..9f63bdfb8576e 100644
> --- a/drivers/ata/pata_pxa.c
> +++ b/drivers/ata/pata_pxa.c
> @@ -286,6 +286,7 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	ret =3D dmaengine_slave_config(data->dma_chan, &config);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "dma configuration failed: %d\n", ret);
> +		dma_release_channel(data->dma_chan);
>  		return ret;
>  	}

While reviewing this patch, I noticed a few pre-existing issues in the same
file.

In pxa_ata_probe():

> 	struct pata_pxa_pdata *pdata =3D dev_get_platdata(&pdev->dev);

[ ... ]

> 	/*
> 	 * Adjust register offsets
> 	 */
> 	ap->ioaddr.altstatus_addr =3D ap->ioaddr.ctl_addr;
> 	ap->ioaddr.data_addr	=3D ap->ioaddr.cmd_addr +
> 					(ATA_REG_DATA << pdata->reg_shift);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for pdata to =
be
NULL here?

If the driver is bound manually via sysfs to a platform device lacking
platform data, dev_get_platdata() will return NULL, which would cause a
direct kernel panic when dereferencing pdata->reg_shift.


In pxa_qc_prep():

> 	tx =3D dmaengine_prep_slave_sg(pd->dma_chan, qc->sg, qc->n_elem, dir,
> 				     DMA_PREP_INTERRUPT);
> 	if (!tx) {
> 		ata_dev_err(qc->dev, "prep_slave_sg() failed\n");
> 		return AC_ERR_OK;
> 	}

[Severity: High]
This isn't a bug introduced by this patch, but should this return an error
code like AC_ERR_SYSTEM instead of AC_ERR_OK?

Returning AC_ERR_OK when dmaengine_prep_slave_sg() fails incorrectly masks
the error from the ATA core. The core proceeds to issue the command thinking
it was prepared, but since no DMA descriptors were actually submitted, the
device will never complete the transfer.

This inevitably results in a 30-second block layer timeout.


In pxa_ata_remove():

> static void pxa_ata_remove(struct platform_device *pdev)
> {
> 	struct ata_host *host =3D platform_get_drvdata(pdev);
> 	struct pata_pxa_data *data =3D host->ports[0]->private_data;
>=20
> 	dma_release_channel(data->dma_chan);
>=20
> 	ata_host_detach(host);
> }

[Severity: High]
This isn't a bug introduced by this patch, but is the teardown order safe
here?

ata_host_detach() unregisters the SCSI host, which can invoke the ATA error
handler (EH) to flush or abort pending commands. If an ongoing command is
aborted, the EH invokes driver callbacks like pxa_bmdma_stop(), which
attempt to call dmaengine_tx_status() and dmaengine_terminate_all() on the
already freed data->dma_chan.

Does calling dma_release_channel() before ata_host_detach() create a
use-after-free window?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625141837.6236=
2-1-vulab@iscas.ac.cn?part=3D1
