Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B0823B61B
	for <linux-ide@vger.kernel.org>; Mon, 20 Jul 2026 02:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784512910; cv=none; b=PACEsU7Q0L7zsRbvxRkuD4n6we97uiGRlEkMjF0+pL36OtgNKUbcOE39M0SEcZD0bxhZDkbmcAtilVFkoYAVm6vdIPATaq4O7Z3uVCwyIpkK+zjtQYqkZgJw6NZdY2YpXiZv0bwOz1PCP0a+VfiET/iYl0HCfBu3XMEsLrU3Nl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784512910; c=relaxed/simple;
	bh=2CGQGKhOSJWCiYNAJQgPnd8CpCoUOd2YZqKeGIoEJJ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pfKsWB6AJxnkOVfgkgm5CRismvX8OrncOL8KJrd5WTKz386YF3YpgaR1QBgB2UtvzpXwItLD0v0l9+xmLNtuUvddkNxMJKZ92Tt3Cfnl8EJVHL4/is82Y1es6NLUXh56B8CSS7B1GXU7ahQHn3WjNH8pMVi8Cs++J5576UMEmjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvFnKP+R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvFnKP+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2DA1F000E9;
	Mon, 20 Jul 2026 02:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784512908;
	bh=nC/pv8eEvE/RKFfI1RN6pRYtusm6KdVmMmnlo+8FhTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JvFnKP+RkTs3GdD3g9qczzuPLFMtx0qUm5tiRps5Z2yW8WwvcbKX4AHfvrx/4+9E7
	 8Jith/qub0HhNOALRlMkJRPOTGaWrDB2t/OK79QUlrW8LNw6ZnZF75ahfj1wyEBlRY
	 1eDuwhzBx5oN7Kfk0tyRzBLoPO2tKI7AEcCtRRMUTDm9jFU9jP0bk33+AEbpIMMA/2
	 AXQYvnpBdNFdmrLo3OHOOjlVL9VebzM0lx7MSAzZVyHN/n6DOJEAPWMrri7aXM9dsQ
	 yOPZwSKVreb9wqm7GAu/6pK0eM8SrJnJ0ZfBGjGyAYJga+3LYtBn9xBdFkWcR82PN6
	 B7JpRku5pnu2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: pata_pxa: use devres for DMA channel management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260720015014.1912040-1-rosenp@gmail.com>
References: <20260720015014.1912040-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 02:01:48 +0000
Message-Id: <20260720020148.7A2DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message falsely claims that `ata_host_activate()` reg=
isters a managed host detach and that the patch preserves the previous tear=
down ordering.
--

--- Patch [1]: [PATCH] ata: pata_pxa: use devres for DMA channel management=
 ---
commit d581effc5d41a82779ae2b411de235a8efbfb017
Author: Rosen Penev <rosenp@gmail.com>

ata: pata_pxa: use devres for DMA channel management

Convert the DMA channel request to devm_dma_request_chan() so the
channel is released automatically on device teardown. This removes
the explicit dma_release_channel() calls in the probe error paths
and in pxa_ata_remove().

> Devres releases in LIFO order, so the managed host detach registered
> by ata_host_activate() runs before the DMA channel is released, which
> preserves the previous teardown ordering.

[Severity: Medium]
Is this description accurate regarding the managed host detach and teardown
ordering?

Looking at ata_host_activate(), it does not appear to register a managed
host detach.

Additionally, pxa_ata_remove() retains the explicit call to
ata_host_detach():

> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
> --- a/drivers/ata/pata_pxa.c
> +++ b/drivers/ata/pata_pxa.c
[ ... ]
> @@ -280,33 +280,26 @@ static int pxa_ata_probe(struct platform_device *pd=
ev)
[ ... ]
>  static void pxa_ata_remove(struct platform_device *pdev)
>  {
>  	struct ata_host *host =3D platform_get_drvdata(pdev);
> -	struct pata_pxa_data *data =3D host->ports[0]->private_data;
> -
> -	dma_release_channel(data->dma_chan);
> =20
>  	ata_host_detach(host);
>  }

Because devres cleanup executes after pxa_ata_remove() returns, the DMA
channel is now released after the host is explicitly detached. This reverses
the previous teardown ordering, which released the DMA channel before the
host detach. Could the commit message be more precise about the actual
teardown sequence?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720015014.1912=
040-1-rosenp@gmail.com?part=3D1
