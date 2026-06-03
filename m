Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AD338837E
	for <linux-ide@vger.kernel.org>; Wed,  3 Jun 2026 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483145; cv=none; b=Esg/I67tw7oTq/xKa2dTVvuvhxt6HVGeemJvRJGA+XQGEUQ3ggO419HtCn5mN0eIu6ZjSH7riV0epx6hJ0v0u+jLuH1RZrYmkbxbPCCnPFk6mvi+j73/cIpq+Rjeb3g70T5kFk9OgjuXY0gpLZXasvvRCeB5q88oomLPbmcxcj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483145; c=relaxed/simple;
	bh=VoFxl/9bqDCeiUd/P0jpZU13YMLZSUVyfbMFtdUh3uw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g5Z1mEt+PxIl9yR3nV3vviyrfiwTZEcGO8oI1g+R+bX2Xsr1+5Mra0kG3+T1+5epyoM35MOKi/0A24467HBtz+EQIChTsg6s0PvtQPx0nxCE+sQx7Z5iW6aqVfM9mKx4oERO1fVRHTI3Rskr6Mf1oRZLzDXqVYvc6D4lN7v7bB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzVfesWY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzVfesWY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9DA1F00893;
	Wed,  3 Jun 2026 10:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780483144;
	bh=Ob9mx0/V59rmy31m45FHyxbqFGgIEl7tohoFCMzLXUw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NzVfesWYXGs3yxfhIkDDYBRnI5zSIOSM5WQbQdfEbDR5BLBxREjCp9mr0fpOGk39S
	 PUIrTysL8empjoiiVLTQiRRJ7EJGCIa3wBju556Y9Jat96nmqc6/0aZmlYy02y/pfq
	 pt0sTwDhMMGV9hrWYDqVYRB+W2SmDnblU/5vdPDoUPvu2+2r8/8Y35r5DW4r3Goz94
	 Wcqr7w5xxZTd7QXG1tu/u+aw68rVb4kE+5KcxnY0Xf3wQvL9o5afqSvFG3DEwEvlGL
	 JOqovqsiRPEeoUfK87ztyiJGYb9kbvljwvyybIVIGdbtF4OohS868GIWvqCFj/hy2S
	 /1bwzNSFCC1Rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: ahci_brcm: fix reset refcount leak in
 brcm_ahci_resume()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260603102420.3735032-1-vulab@iscas.ac.cn>
References: <20260603102420.3735032-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 10:39:03 +0000
Message-Id: <20260603103903.DB9DA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to fix the `reset_control_rearm()` leak for the `a=
hci_platform_enable_clks()` and `ahci_platform_enable_regulators()` error p=
aths in `brcm_ahci_resume()`, explicitly contradicting its commit message.
- [High] Error paths in `brcm_ahci_resume()` fail to call `reset_control_as=
sert(priv->rcdev_ahci)`.
- [High] Missing `reset_control_rearm(priv->rcdev_rescal)` in `brcm_ahci_pr=
obe()` if `reset_control_deassert(priv->rcdev_ahci)` fails.
- [High] `brcm_ahci_remove()` fails to call `reset_control_rearm()` and `re=
set_control_assert()`, leading to permanent resource leaks on module unload.
--

commit 075a88f5a8b3bff5899fc69114efba28b24bf30d
Author: Wentao Liang <vulab@iscas.ac.cn>
Subject: ata: ahci_brcm: fix reset refcount leak in brcm_ahci_resume()

This patch attempts to fix a reset refcount leak in the error path of
brcm_ahci_resume(). It adds a call to reset_control_rearm() to balance
the triggered_count when subsequent initialization steps fail after a
successful reset.

> When brcm_ahci_resume() succeeds with reset_control_reset(), any
> subsequent failure in ahci_platform_enable_clks(),
> ahci_platform_enable_regulators(), ahci_platform_enable_phys(),
> or ahci_platform_resume_host() leaves the shared reset line's
> triggered_count incremented by one.

[ ... ]

> Add a reset_control_rearm() call in the common error path after
> brcm_sata_phys_disable() and ahci_platform_disable_regulators()
> to properly balance the triggered_count, matching what the probe
> error path already does.

[Severity: High]
Does this patch actually resolve the leak for all the functions mentioned
in the commit message?

Looking at the code in brcm_ahci_resume(), if ahci_platform_enable_clks()
fails, it returns directly:

	ret =3D ahci_platform_enable_clks(hpriv);
	if (ret)
		return ret;

And if ahci_platform_enable_regulators() fails, it jumps to out_disable_clk=
s:

	ret =3D ahci_platform_enable_regulators(hpriv);
	if (ret)
		goto out_disable_clks;

Both of these error paths bypass the newly added reset_control_rearm() call,
leaving the triggered_count leak unfixed for these conditions.

> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index 29be74fedcf01..38c63d73d210b 100644
> --- a/drivers/ata/ahci_brcm.c
> +++ b/drivers/ata/ahci_brcm.c
> @@ -415,6 +415,7 @@ static int __maybe_unused brcm_ahci_resume(struct dev=
ice *dev)
>  out_disable_phys:
>  	brcm_sata_phys_disable(priv);
>  	ahci_platform_disable_regulators(hpriv);
> +	reset_control_rearm(priv->rcdev_rescal);
>  out_disable_clks:
>  	ahci_platform_disable_clks(hpriv);
>  	return ret;

[Severity: High]
This isn't a bug introduced by this patch, but does brcm_ahci_resume() also
leak the assertion state of rcdev_ahci on error?

Earlier in brcm_ahci_resume(), the reset control is deasserted:

	ret =3D reset_control_deassert(priv->rcdev_ahci);
	if (ret)
		return ret;

However, the entire error handling block at the end of the function (shown =
in
the diff above) lacks a corresponding call to
reset_control_assert(priv->rcdev_ahci), which leaves the line permanently
deasserted if a failure occurs later in the resume process.

[Severity: High]
This is a pre-existing issue, but is there a similar missing rearm in
brcm_ahci_probe()?

If reset_control_deassert() fails in the probe function, it returns directl=
y:

	ret =3D reset_control_reset(priv->rcdev_rescal);
	if (ret)
		return ret;
	ret =3D reset_control_deassert(priv->rcdev_ahci);
	if (ret)
		return ret;

This skips jumping to the out_reset label, leaking the previously increment=
ed
triggered_count of rcdev_rescal. Could this be updated to properly jump to
the cleanup path?

[Severity: High]
This is a pre-existing issue, but does module removal permanently leak these
reset resources?

When the module is unloaded, brcm_ahci_remove() only disables the PHYs and
removes the platform device:

drivers/ata/ahci_brcm.c:brcm_ahci_remove()
{
	struct ata_host *host =3D dev_get_drvdata(&pdev->dev);
	struct ahci_host_priv *hpriv =3D host->private_data;
	struct brcm_ahci_priv *priv =3D hpriv->plat_data;

	brcm_sata_phys_disable(priv);

	ata_platform_remove_one(pdev);
}

Should this function also call reset_control_rearm() and
reset_control_assert() to balance the operations from probe? Without them,
the triggered_count leaks permanently because devm cleanup only calls
reset_control_put().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603102420.3735=
032-1-vulab@iscas.ac.cn?part=3D1
