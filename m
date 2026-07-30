Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101633E34B
	for <linux-ide@vger.kernel.org>; Thu, 30 Jul 2026 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399956; cv=none; b=lgIUrb9XCEH/Bje7HytWcKRzJ5sU3Ad+/LQUItQzx6UK7moXByJ6gu/fDFwSp/8rO416PTic7Oz56Gq5Bw3gDU1YIDElM7bsG7nvSzXm5j6OYJFRJZySpQCprVqBhKLQMzhO9kVQV9JlEPitcn5yYnTfR3SixNoCrL9Sv+cJQtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399956; c=relaxed/simple;
	bh=UdPVhExnGAdWCqzne9MBihRBSUMBQCKK9l4+mHeBSo8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dpTE6rlbwmMG053cxZMYZ84kpwTuRImpSGHjIJJn/IS1yp578zlxT391EbYSE21uZHPotzbXTy8ZS7ZtVmDB+e1T//oClGez0/oYAONY7E6Wl3mRF+A/F8DhQmPCF4feVepkGdDYWVEXqZ0w2Q/p49P/vq4aQPy4MNttx85982Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYDP833a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYDP833a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C161F00A3A;
	Thu, 30 Jul 2026 08:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785399955;
	bh=Fe33dLTS7JhSdZZWXiX3OE2W63RYfBvumY3zL2XZKs8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LYDP833absSVPAKh/WEW9iDpInJ3YSgVNAzGy5Fj7ht6SuRQJ4sTMk/JvAsNI4TEy
	 SATC4CQPVCO6TY7ij00S/BgmBF0ZhdpRI+2dhMVGfNl8c8kElVcYnqBJw7RY8QPOVq
	 jWWWEyVN8s5fDf2HHQVx/xCebnbAkRHPaVhEmk7G5O12x2Ug+s+X8ANoFcx8KOb/g6
	 bmmQEfycrhIVYaeFZ5mTODhp2CibHnknKEkRXcnkGM2rmJKm5oGQPNYQQ9x8ecP/1g
	 wdsCtE467Apbb7MaBFaZmMaUh3+B1PwonF8Kr2VNQeZqwDJ/exdlzDWrK/yHg4BjOU
	 ZZii0kGXM6JHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: pata_parport: Fix missing module refcount for
 pata_parport itself
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pei Xiao" <xiaopei01@kylinos.cn>
Cc: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <a8d9807618ab786313654099c904d613075e1b63.1785398816.git.xiaopei01@kylinos.cn>
References: <a8d9807618ab786313654099c904d613075e1b63.1785398816.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 08:25:54 +0000
Message-Id: <20260730082554.B2C161F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Circular dependency permanently preventing module unloading.
- [High] Race condition leading to Use-After-Free during device release.
--

--- Patch [1]: [PATCH] ata: pata_parport: Fix missing module refcount for p=
ata_parport itself ---
commit 35d67ec0c667d20f10f4b6d490918bd71ccafa32
Author: Pei Xiao <xiaopei01@kylinos.cn>

ata: pata_parport: Fix missing module refcount for pata_parport itself

This commit adds a module reference count for the pata_parport core module
during device initialization and drops it during device release. This is
intended to prevent the module from being unloaded while devices are still
attached.

> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_p=
arport/pata_parport.c
> index 40baeac594a9f..6de237602a13e 100644
> --- a/drivers/ata/pata_parport/pata_parport.c
> +++ b/drivers/ata/pata_parport/pata_parport.c
> @@ -455,6 +455,12 @@ static void pata_parport_dev_release(struct device *=
dev)
>  {
>  	struct pi_adapter *pi =3D container_of(dev, struct pi_adapter, dev);
> =20
> +	/*
> +	 * pi->proto is NULL when device_register() fails early,
> +	 * before __module_get() was called -- skip module_put().
> +	 */
> +	if (pi->proto)
> +		module_put(THIS_MODULE);

[Severity: High]
Does this create a race condition where the module could be unloaded while
pata_parport_dev_release() is still executing?

If module_put() drops the final reference to the module, a concurrent module
unload could unmap the module's memory. The remaining instructions in this
function, including the call to ida_free() which accesses the static
pata_parport_bus_dev_ids structure, would then be executing in freed memory.

>  	ida_free(&pata_parport_bus_dev_ids, dev->id);
>  	kfree(pi);
>  }

[ ... ]

> @@ -524,6 +530,8 @@ static struct pi_adapter *pi_init_one(struct parport =
*parport,
> =20
>  	pi->proto =3D pr;
> =20
> +	__module_get(THIS_MODULE);
> +

[Severity: High]
Will this prevent the module from ever being unloaded?

Normally, the driver's exit function (pata_parport_exit) would unregister t=
he
driver, which in turn detaches devices and drops their references. By takin=
g a
module reference for every attached device, the module reference count will
never reach zero while devices exist, making pata_parport_exit() unreachable
via standard unload operations.

>  	if (!try_module_get(pi->proto->owner))
>  		goto out_unreg_dev;
>  	if (pi->proto->init_proto && pi->proto->init_proto(pi) < 0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/a8d9807618ab7863136=
54099c904d613075e1b63.1785398816.git.xiaopei01@kylinos.cn?part=3D1
