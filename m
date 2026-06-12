Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB08330BB97
	for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289902; cv=none; b=HSZR7DTboQXQdN7sbHI77969mVVNaBBWC1cF8tpoPIkVNRol7f4kSpX/BfEL3nN16FcmgoTTOyQdAAZN70JadJb3nfl60C5Th2H0vz+DRDa0xRPm0kbsbIkuzHfPDF3+fxDoTDnh3dyoyYC0O4+1OZWN0Kkr5NeJ/9WZ8ZTz6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289902; c=relaxed/simple;
	bh=DUkuqK0ufTMsvvXGLENrLXo7Pw0C0T/4A1TtRCOnBos=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wt1RqpnqVmsx6b3eAS/+tSQSGwfIT6ms9gOvvzKDvoPYKSgjRwVq8i8kuVxsPJHOL+RRmtc7jiBwM8cYWo2M4Yjg1/DEqrqBeVzPjBSqUrViuK6AV9QD4ePyi5xYx4DJmvrRbMuQvrjoB02eCFEtzgGUzj7Woebw0KVGrHgZDXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=js9w1orK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="js9w1orK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154E61F000E9;
	Fri, 12 Jun 2026 18:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781289901;
	bh=amyaxqjzxYkejPacI7QdVvKlNeBzwJWXR9cpWTDmmFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=js9w1orK9QCGFzyZQ+xxVdujR4UUrn1YYDfkFKKlHIXSDiI01PKrNzMuvqZKUYdWc
	 5RITsPX6W5it5/7r3Qx7wrZPr/5IjTS3tqf9skjVLNOAMhUOCB4+5cfYkJDQzs822n
	 JCO5zmNLqV1Byp+cIVEUPrJMQiDiBpCA5co60bfTASZdow7Ni+DdgEXlmVhWWTfESg
	 o8/6p0+usR+gZO/rygma8wvS5ttG+XTxR2wxaUeWot1apnCcrjESWGyegEkUTcI6np
	 88vxdpEGOCGDc30LaiprM3XmWyDCIhhwvFt8MTOswfrS4MfWZJL5dZHBpa1vM17E+H
	 QChws2VCnZK0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 4/6] ata: pata_mpc52xx: remove redundant
 irq_dispose_mapping calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, cassel@kernel.org, dlemoal@kernel.org
In-Reply-To: <20260612183227.20446-5-rosenp@gmail.com>
References: <20260612183227.20446-5-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:45:00 +0000
Message-Id: <20260612184501.154E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling `irq_dispose_mapping()` on devres-managed IRQs destroys th=
e IRQ descriptor before `devm_free_irq()` can execute, leading to a memory =
leak of `struct irqaction` and bypassing interrupt synchronization.
--

commit 22d637bd9ec3129e235484c8f8f7b01af8844e9d
Author: Rosen Penev <rosenp@gmail.com>

ata: pata_mpc52xx: remove redundant irq_dispose_mapping calls

bcom_ata_release() calls bcom_task_free(), which already calls
irq_dispose_mapping(tsk->irq).  The explicit irq_dispose_mapping()
calls in the probe error path and remove function are redundant
and cause a double-free of the same mapping.

> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index 210a63283f62b..408b1cb75d1e7 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
> @@ -793,7 +793,6 @@ static int mpc52xx_ata_probe(struct platform_device *=
op)
>  	return 0;
> =20
>   err2:
> -	irq_dispose_mapping(task_irq);
>  	bcom_ata_release(dmatsk);
>   err1:
>  	irq_dispose_mapping(ata_irq);

[Severity: High]
This is a pre-existing issue, but does calling irq_dispose_mapping() on the=
se
IRQs bypass the devres cleanup mechanisms?

Because task_irq and ata_irq are managed via devm_request_irq(), their=20
free_irq() calls are deferred to the devres cleanup phase.

If irq_dispose_mapping() (called explicitly for ata_irq, and implicitly via
bcom_ata_release() for task_irq) destroys the IRQ descriptor before devres
cleanup runs, the subsequent devm_irq_release() -> free_irq() will fail to
find the descriptor when irq_to_desc() returns NULL.

This causes free_irq() to return immediately without cleaning up, which
leaks the struct irqaction memory.=20

More importantly, it skips the call to __synchronize_irq(). Could this allow
the interrupt handler to continue running concurrently while devres tears
down the driver's mapped registers, posing a use-after-free risk?

> @@ -804,14 +803,11 @@ static void mpc52xx_ata_remove(struct platform_devi=
ce *op)
>  {
>  	struct ata_host *host =3D platform_get_drvdata(op);
>  	struct mpc52xx_ata_priv *priv =3D host->private_data;
[ ... ]
>  	/* Clean up DMA */
> -	task_irq =3D bcom_get_task_irq(priv->dmatsk);
> -	irq_dispose_mapping(task_irq);
>  	bcom_ata_release(priv->dmatsk);
>  	irq_dispose_mapping(priv->ata_irq);
>  }

[Severity: High]
This is also a pre-existing issue, but the same devres synchronization conc=
ern
applies here in mpc52xx_ata_remove() when disposing the mappings prior to t=
he
device devres teardown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612183227.2044=
6-5-rosenp@gmail.com?part=3D1
