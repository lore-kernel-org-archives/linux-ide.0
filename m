Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4502348BD4E
	for <linux-ide@vger.kernel.org>; Wed,  3 Jun 2026 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780515048; cv=none; b=bvXUii8SUnW/NdV2GT/un2s6f7N5jB0GwM6rVVjup1Jdl4YSFCuYck2i5SH1P3g/n5eiYtYGSbY/ZEyV2F/hZJe4MI9zyXkZnJP+lDCQX0Pdc5NBc3xaKOViaRSqnkTX/17tgl7obvabKGvnVNSnz6fAvDKE8h53r+jV+5TYoJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780515048; c=relaxed/simple;
	bh=2hHfuQdGhO8Kc1YBieSJ5Fj/6Xxgc7I7eMu85bW55f0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lufda7CeOdUbVkjTttp0oTYb29VR7bcaoX6doxTCCz1EQU2jURya0C4asZbEcRhtBFMKpSlGsLlvwB1C8XEZTQvD/L40Z/plCgHVJHQweqn0sjX0GkVZVpdHPeQjJ17DW3TRCS+8objV7tHue4tLU+NI8lfXho4LtcPZzanLJ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7oX9RMa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7oX9RMa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C801F00893;
	Wed,  3 Jun 2026 19:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780515047;
	bh=RHXz1wgEJDe1wlyDk2ltcdMXAARkXJIi8v7ZQjnO+1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U7oX9RMaAhFCj5U/nfKK5coRE2aK27VMB27ScK1qjaiIVjQzjLSVtI7qEb51P0ZF5
	 qMjQ63PghzL+Gs9QmyqBGi8gHAZCIhwjN540Jm24ALDx6LX8s0jPK9FcWc2rWQlV9Q
	 LkT5MP3DioNVIK5WhZHWbTdXot+zU1m7IFoSvr+KSGWeQ7HTrjNVRYQoNzJ3oogntQ
	 UeLcR4hmKV/l0DcbP/Aa2fHn/8fEjpb8trtit3BRtMgI4/tGVW0TqnMpofXl0E6ycS
	 4apciErnYSdJh2zJ7K1JxF7Z1xIUW/kE/q4LToDv+ks7RV9coXPG1YStF05dgEsK0n
	 2SJSoi5krvkbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: pata_mpc52xx: convert to platform_get_irq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260603192028.5818-1-rosenp@gmail.com>
References: <20260603192028.5818-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 19:30:45 +0000
Message-Id: <20260603193046.B5C801F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Redundant error logging after `platform_get_irq()` breaks probe =
deferral silence.

Pre-existing issues:
- [High] Teardown inversion and double-free vulnerabilities due to manual c=
leanup of resources before `devm`-managed IRQ handler deregistration.
--

commit ffac71fcd5afc61a5b03a064fe40da6b52105e95
Author: Rosen Penev <rosenp@gmail.com>

ata: pata_mpc52xx: convert to platform_get_irq()

Replace irq_of_parse_and_map() with platform_get_irq(), which returns
a negative errno on failure and integrates with the platform device
model. The corresponding irq_dispose_mapping() calls in the probe
error path and remove function are no longer needed.

> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index 210a63283f62b..f8ecd58765dd3 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
[ ... ]
> @@ -730,10 +730,10 @@ static int mpc52xx_ata_probe(struct platform_device=
 *op)
>  	if ((prop) && (proplen >=3D 4))
>  		udma_mask =3D ATA_UDMA2 & ((1 << (*prop + 1)) - 1);
> =20
> -	ata_irq =3D irq_of_parse_and_map(op->dev.of_node, 0);
> -	if (!ata_irq) {
> +	ata_irq =3D platform_get_irq(op, 0);
> +	if (ata_irq < 0) {
>  		dev_err(&op->dev, "error mapping irq\n");

[Severity: Medium]
Since platform_get_irq() already logs errors internally using dev_err_probe=
(),
which correctly silences -EPROBE_DEFER, does leaving this manual dev_err()
call in place cause redundant log spam during probe deferral?

> -		return -EINVAL;
> +		return ata_irq;
>  	}
> =20
>  	/* Prepare our private structure */
[ ... ]
> @@ -796,7 +796,6 @@ static int mpc52xx_ata_probe(struct platform_device *=
op)
>  	irq_dispose_mapping(task_irq);
>  	bcom_ata_release(dmatsk);

[Severity: High]
This is a pre-existing issue, but does manually cleaning up the resources h=
ere
cause a use-after-free and teardown inversion?

Because the driver requests task_irq using devm_request_irq(), the interrupt
handler remains active until devres frees it after the probe error path
returns.

If bcom_ata_release(dmatsk) frees the memory while the devm-managed IRQ
handler is still registered, could an incoming interrupt access freed memor=
y?

Additionally, disposing the IRQ mapping while the interrupt action is still
registered breaks the IRQ subsystem, as devm_free_irq() will later fail to
locate the descriptor.

Finally, since bcom_ata_release() internally calls bcom_task_free(), which
also calls irq_dispose_mapping(tsk->irq), does this sequence trigger a
double-free of the IRQ mapping?

>  err1:
> -	irq_dispose_mapping(ata_irq);
>  	return rv;
>  }
> =20
> @@ -813,7 +812,6 @@ static void mpc52xx_ata_remove(struct platform_device=
 *op)
>  	task_irq =3D bcom_get_task_irq(priv->dmatsk);
>  	irq_dispose_mapping(task_irq);
>  	bcom_ata_release(priv->dmatsk);

[Severity: High]
This is a pre-existing issue, but does this pattern present the same
use-after-free, teardown inversion, and double-free risks as the probe error
path?

Since the IRQ handler is managed by devm, it is still active when this remo=
ve
function returns. Manually releasing the task resources and IRQ mapping bef=
ore
devres unregisters the handler seems problematic.

> -	irq_dispose_mapping(priv->ata_irq);
>  }
> =20
>  #ifdef CONFIG_PM_SLEEP

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603192028.5818=
-1-rosenp@gmail.com?part=3D1
