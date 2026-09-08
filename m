Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF03346A8
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848439; cv=none; b=hrt+hEubYZBXH/q81e3/y1y+SvgtheUPJnJqOJxYuSb0wJkny3gfoeWT8qLQybnXIKcx1Jn1Ltw/nsp4bAw/0go6W5po65SGlruFLUX/eYlJ2KguFYLLjDKkrIZOweTuNzuR6gpfNBiN+7oULJfiosQjpN7+VAt+at0JOiKrwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848439; c=relaxed/simple;
	bh=EDgPTEhP7UCwQdb0W46CB0sgeQw0Ojzbv9bTvrk3tIs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NbkqD3+loxZM6tNEeO9NMiXc1vk79LuxJiuuOXMmCXhYWYYgjZW6AFD/f/6ysDqzf9zuf3bWaVXFsM6pQZOwm74rLZd1UmhLJFg3hNYmMD2jDwvbElKAgT0aP3vpEwZmplaqp9XmUNHp+0JzPXbQAt1X7DyWtD4OA7sMIFGInDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8XZCaPw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8XZCaPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FCB1F00A3A;
	Tue,  8 Sep 2026 06:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788848438;
	bh=Xyo+GUimOf9RkRgPzRwefXKE2N16/c4IRGUsDtp5Dok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N8XZCaPwXR7he6gREKB+E9Dt6vDY9GaLelYl+f7A01q5i2sYray/F8C604g74c9y7
	 pwyMADAQpyTPf29IRh8jDjaE9TduMg3chKlT71fQwo6sMJTI55OE8jUkxgJWQYdUqP
	 QBW0RvbS/bVSZUq3YrNd+LV8naGcQQF4+K+I7GEI97hWyI5QAzb2L0V0rceFGetxP5
	 lQwFjiS4DIDKppr34VfRqJQpp6pbt/cSrjsYArfYVydbwfJVZkynAnE0F7HHWNecVQ
	 /37aAQXkLgohV3RJAEciJGQhzj5JufP30LbgCHRgVue/27Tp234GGGEOnQy9YM1pAt
	 m/euaO6Sk+l6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] ata: ahci_da850: switch to DEFINE_SIMPLE_DEV_PM_OPS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Jun" <lijun01@kylinos.cn>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20260908061025.3580261-1-lijun01@kylinos.cn>
References: <20260908061025.3580261-1-lijun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 06:20:37 +0000
Message-Id: <20260908062037.D4FCB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The ahci_da850 driver hooks into standard ahci_platform_resume, bu=
t fails to restore SoC-specific SATA PHY registers after suspend, causing S=
ATA to be uninitialized on resume.
--

commit d5b66599e27a81a0e92aca89e46cdd92303b81e7
Author: Li Jun <lijun01@kylinos.cn>

ata: ahci_da850: switch to DEFINE_SIMPLE_DEV_PM_OPS

This patch replaces the deprecated SIMPLE_DEV_PM_OPS macro with the
recommended DEFINE_SIMPLE_DEV_PM_OPS. It also uses pm_ptr() to complete
the API migration and allow the pm_ops structure to be dropped when
CONFIG_PM is disabled.

> diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
> --- a/drivers/ata/ahci_da850.c
> +++ b/drivers/ata/ahci_da850.c

[ ... ]

> @@ -227,8 +227,8 @@ static int ahci_da850_probe(struct platform_device *p=
dev)
>  	return rc;
>  }
> =20
> -static SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
> -			 ahci_platform_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
> +								ahci_platform_resume);

[Severity: High]
This is a pre-existing issue, but by examining the PM operations being wired
here, it appears the driver hooks into the generic ahci_platform_resume
without restoring SoC-specific SATA PHY registers.

During probe in drivers/ata/ahci_da850.c, ahci_da850_probe() initializes
the SATA PHY registers by calling da850_sata_init() with local parameters.
However, the resume callback is wired directly to the generic
ahci_platform_resume, which only restores standard AHCI state and bulk
clocks. It is completely unaware of the custom DA850 PHY initialization.

Furthermore, the necessary parameters for PHY initialization (pwrdn_reg and
mpy) are local to the ahci_da850_probe() function and not saved for later
use.

Could a system suspend followed by a resume cycle leave the SATA controller
uninitialized, causing connected drives to become inaccessible?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908061025.3580=
261-1-lijun01@kylinos.cn?part=3D1
