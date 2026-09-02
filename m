Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDDC480DDB
	for <linux-ide@vger.kernel.org>; Wed,  2 Sep 2026 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350784; cv=none; b=OyYpDSrhEME024gUD42r8i8FgB+qSGQfRbsRk3gpvtokdG2SOd+rIf3EjGbEkCiU1fOdqn84LI6a1XjKlReUOZTc/Wdm/vWYIpDEfpb5NU49/qjhus1lNnkJo25ucOxjXmqbw4MT7j7ugWXR6m7hs7Rbfvh8WA/0g6tOL0wmKfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350784; c=relaxed/simple;
	bh=f2GIaeDNTqi9vv8l2AUrKUSKR+UjP+LtpknR4SlYaKQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GTXd3+qraQasn73JnKTJfpSHBtHU4thXTAAuBnBHqYqpK9hbgyNvjcxOnKjjcCny6NNuR9ExDTZwqtUnN+qpfJJE7zaIKgEBvXxoipmnBgolGIbiv/UHtfLHUCt+FUNEzSm/BqJSEum1wEgNopTbXUmxFaL4xe/pMXrR/tXI+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYg1vKqu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYg1vKqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635581F000E9;
	Wed,  2 Sep 2026 12:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788350769;
	bh=KhUI5HraKgqoXfsVdI2aJEY7IXYG/OV7E0cqz6pP5Xg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NYg1vKquuDpGDw6bL07YUjXv5fNGwFmfIleXnHqS0V6Zu5KBuQbfEfSvZxeFWlOxH
	 SdfU+bzSGGh+bcSptjjHlnjd0mRiXw0LgvvoPTKXZbsvULuPu7Ral4wloQfz84DlNo
	 K5OOfXTQ3yLkPUbK04GoWn9kxicoEQJ8g8x4iCvhgK3WgI+17SUD22/VN4Ost4uMW2
	 Fy1FyBAgHHD61e65yNm91BAU9O1iwuMyN4J5DVHzW9RZisby+pgkTUlu5HqC53r3AX
	 8pRcdiKhM0Tx+Lktj6Izvo0qALhri6MeBChLxdUFgTvUtGmq9D5pDYdoJqIfZaCwxe
	 iIoytc7CtCZPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] ata: pata_parport: pin the protocol module before
 device_register()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pei Xiao" <xiaopei01@kylinos.cn>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <eae63a4231a9d669f3dc140f34c7b90c860cad72.1788349317.git.xiaopei01@kylinos.cn>
References: <cover.1788349317.git.xiaopei01@kylinos.cn>
 <eae63a4231a9d669f3dc140f34c7b90c860cad72.1788349317.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 12:06:08 +0000
Message-Id: <20260902120609.635581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unused label `out_unreg_dev` causes compiler warning.
--

commit 99f7607699410f6446da6e37e3bed84251a51bd8
Author: Pei Xiao <xiaopei01@kylinos.cn>

ata: pata_parport: pin the protocol module before device_register()

Take the module reference before registering the device to prevent a race
condition where the device is visible but the protocol module is not yet
pinned. Also ensure the reference is dropped on the device_register()
failure path.

> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_p=
arport/pata_parport.c
> index cf81a6128f552..7462f9b1acc57 100644
> --- a/drivers/ata/pata_parport/pata_parport.c
> +++ b/drivers/ata/pata_parport/pata_parport.c

[ ... ]

> @@ -517,15 +525,12 @@ static struct pi_adapter *pi_init_one(struct parpor=
t *parport,
>  	pi->dev.id =3D id;
>  	dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
>  	if (device_register(&pi->dev)) {
> +		module_put(pi->proto->owner);
>  		put_device(&pi->dev);
>  		/* pata_parport_dev_release will do ida_free(dev->id) and kfree(pi) */
>  		return NULL;
>  	}
> =20
> -	pi->proto =3D pr;
> -
> -	if (!try_module_get(pi->proto->owner))
> -		goto out_unreg_dev;

[Severity: Low]
Does removing this goto leave the out_unreg_dev label unused at the bottom
of pi_init_one()?

If the label is no longer referenced, compiling the kernel will emit a
-Wunused-label warning. This can cause build failures in configurations
that enforce -Werror.

>  	if (pi->proto->init_proto && pi->proto->init_proto(pi) < 0)
>  		goto out_module_put;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788349317.gi=
t.xiaopei01@kylinos.cn?part=3D1
