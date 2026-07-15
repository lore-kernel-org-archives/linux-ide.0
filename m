Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874E7370AE2
	for <linux-ide@vger.kernel.org>; Wed, 15 Jul 2026 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078708; cv=none; b=uM3CMEMGTb0JRWNsb3B+2tRYNCOqC40PXbytjbMz24PI8P+J1RisD1srHm2m7jsMnNXvQ5Qtw1Z6UYPOim6EMN+i9gKJa+ds1CPIMc+GRYbJHHORiro7a2eQQfYqUcj6Ura0QLuFXAOV7bRs5zF5AsAiyroSJAoJq58xvGUNU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078708; c=relaxed/simple;
	bh=rBfnWBPS8iz7FQ6dhUE6j0Vjq+N6LPva7sqmO5G/vSM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tFccJ9RciQ91EzXwgVKK7o3HTlDAClQM0ecl6g2zSQ07t8n8qqcGQ9FKQCJo9HLtNGWEUAqQqo01QsNg0fnN/rVbyE0+yHnDE2QrStbI+pzCo5RlvMaksDSn3vk8akISJ8MrzvUXIqP5EXKc3RN//tNJKsB4tyMkCGtJCecpcg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqaLWtT5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqaLWtT5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBFE1F00A3A;
	Wed, 15 Jul 2026 01:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784078707;
	bh=Qh4Q9KujGCa/goscognnUesikNSgdMRYsz+GH6PX6DM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gqaLWtT5kFf3litUHzg893LJkIpMUJtkzT4NOLMljBJ941WCIx+9iBIHTOrhISKGv
	 pINefyeMF+DSy6EJvPYqC03AujV2vtGzZhcsU7rQYBYO09RKzWzsAKx25oe/y8rYD9
	 z1xFNGOnabl2wtxTek70UCidUspCe6uu5unzznwJdNV1ENZQRjAc3GW8sUt7KlA1V2
	 YQRZ/DKCe+Tsh6xu/BpTwA+Ym7LizH26HAaoDYhNApvmeZAB5TCzP0lhPrW8z0dWgt
	 yqezIpyb4IBc5oH/Myhp8fa6Kp0O65bnOIRPKoLQs2D8uYlZ+aXj2Z4Xfqzi9ByWcs
	 u4B/pt5Tf9pMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: pata_pxa: use devm_platform_ioremap_resource
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260715011343.1270261-1-rosenp@gmail.com>
References: <20260715011343.1270261-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 01:25:06 +0000
Message-Id: <20260715012506.CCBFE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Teardown order bug in `pxa_ata_remove()` causes Use-After-Free
--

--- Patch [1]: [PATCH] ata: pata_pxa: use devm_platform_ioremap_resource ---
commit 5dcbe84075bf85bf6a553efa199d7ee5d2ff52be
Author: Rosen Penev <rosenp@gmail.com>

ata: pata_pxa: use devm_platform_ioremap_resource

This commit replaces the open-coded platform_get_resource() and
devm_ioremap() sequences for the CMD and CTL ports with
devm_platform_ioremap_resource(). It simplifies the probe function by
consolidating resource fetching and mapping.

> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
> index 9f63bdfb8576e..c816997dc0a99 100644
> --- a/drivers/ata/pata_pxa.c
> +++ b/drivers/ata/pata_pxa.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but does pxa_ata_remove() have a use-after-fr=
ee
if an interrupt occurs during module unload?

Looking at drivers/ata/pata_pxa.c:pxa_ata_remove():

static void pxa_ata_remove(struct platform_device *pdev)
{
	struct ata_host *host =3D platform_get_drvdata(pdev);
	struct pata_pxa_data *data =3D host->ports[0]->private_data;

	dma_release_channel(data->dma_chan);

	ata_host_detach(host);
}

The DMA channel is explicitly freed via dma_release_channel() before calling
ata_host_detach().=20

Because the ATA host is still active and its interrupt handler was register=
ed
via devres (which only unregisters the IRQ after the remove callback
completes), an active device or a stray interrupt could trigger
ata_sff_interrupt().

This interrupt handler calls pxa_bmdma_status(), which dereferences the
already freed data->dma_chan.=20

Should ata_host_detach() be called before releasing the DMA channel to prev=
ent
this race?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715011343.1270=
261-1-rosenp@gmail.com?part=3D1
