Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89589534471
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869347; cv=none; b=Iy/iaPLIs5vapY0KByvT5z6GB3UveaBhPi/d01FHgpWs9RaOkGh0lC0Fpf30Rt8lUDMS3Rnx66MwZ+yVLmonLDfLvie4PFTexcIwamYV2WyLooZG+1ed54LAJk8FuRoSrdhvyrRWn4ljxLdqtPzgv+A4tp5yU8ES0HP1AhjZZqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869347; c=relaxed/simple;
	bh=7RKHwp6T33SyQoqeRz8LS3Sm6/HL70Tu6AqVvOoUqk0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hwz2oYiLAQrRA6Ur3CaM/pIQmiDmgAbjXgwNeRfCHsuHAYi9imozY7zcAlI6urY5dyLcWDv78Emuwkp4y04QLpjgD3A2MxqJdpnE/OFbdmglK0Tb3IU9ZZ3ZZxT0JvvOfDeU/V4n0Di/+MymxLhN9esSvWopXF34wOJqEQ7o5XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+NQsbLO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+NQsbLO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F34F1F00A3A;
	Tue,  8 Sep 2026 12:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788869335;
	bh=LMJ/UHrdU3Ks/ihTzgSipkRye3JvLf3xfmqbebltmrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b+NQsbLO4vdru3ppaSXzd/fjrBUDgx1LE2yA53irbBlwXGC56BfOy7dKmYgaPt/fY
	 ujydsw5XJvIyvgO4d25o5Q85BO2L7uUJCZw4YsMMpdvvfPypMe0OSEC6ywhFnhXCNn
	 Yo0CSOTykTrmBmYk/JH7tK1kediOWws93R4i/zCnZPqkcpXDoNMpUYLNY2ZRxoFavO
	 XW3OKEFY409vgOSFdTaujKwyiMvKUyovZSukpeZmp6B6qwY/63uhWPgZ3UGIG3tQV5
	 1VRV6PfEUaVeMxH1uaBN3PnX/wN7Rt68p3XbzkB8GHkt5XA2QESs5AZTvwJOQTUmFr
	 oUJUrE62l4FwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] ata: pata_parport: unregister devices on
 protocol unregister
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pei Xiao" <xiaopei01@kylinos.cn>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <cec58ea83362df88f516ba7a5b895cf07edd7728.1788867690.git.xiaopei01@kylinos.cn>
References: <cover.1788867690.git.xiaopei01@kylinos.cn>
 <cec58ea83362df88f516ba7a5b895cf07edd7728.1788867690.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 12:08:55 +0000
Message-Id: <20260908120855.9F34F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] pata_parport_attach fails for all parports except port 0
--

commit b043c5b13721ce815e34642853318549a000ffd3
Author: Pei Xiao <xiaopei01@kylinos.cn>

ata: pata_parport: unregister devices on protocol unregister

When a protocol module registers multiple protocols and a later
registration fails, the rollback path unregisters the protocol but leaves
dynamically created devices untouched. Later removal of these dangling
devices dereferences freed module memory, crashing the kernel. This commit
tears down all pi_adapters using the protocol before unregistering the
driver.

> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_p=
arport/pata_parport.c
> index 046ab7e3adbcf..712209882ab75 100644
> --- a/drivers/ata/pata_parport/pata_parport.c
> +++ b/drivers/ata/pata_parport/pata_parport.c
[ ... ]

While reviewing this, I noticed a pre-existing issue in pata_parport_attach=
():

drivers/ata/pata_parport/pata_parport.c:pata_parport_attach() {
    ...
	mutex_lock(&pi_mutex);
	id =3D idr_alloc(&parport_list, port, port->number, port->number,
		       GFP_KERNEL);
	if (id < 0) {
    ...
}

[Severity: High]
This is a pre-existing issue, but does this idr_alloc() call fail for all
parports except port 0?

Since the end parameter of idr_alloc() is exclusive, when port->number > 0,
it computes max =3D end - 1. Because start is equal to port->number, the
condition start > max evaluates to true, causing it to return -ENOSPC.

Would this cause attaching any parport with a number greater than 0 to
silently fail and completely break functionality for those ports?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788867690.gi=
t.xiaopei01@kylinos.cn?part=3D2
