Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4096321CC5C
	for <linux-ide@vger.kernel.org>; Thu, 30 Jul 2026 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785382164; cv=none; b=kJa5YWB8ajzUoNDUIDIi5hpFsycsEvt5oJrqeLc0Css2P8npOw1CHl/B1nkz3/P+Y7IpIfX2kwu6H3eiBMbxiOfFQL/HehdxN2n4g49PgtPgOeZUHi3qtKRNKeSVlVJ9g3d0OShsvL2jHlX1An5a4d333yQpwMOJ//lb9NR2lD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785382164; c=relaxed/simple;
	bh=yLNkX4LQhAf3ufKKoOM6erYQcDMWY96pTe58ZWgO56E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ObWdpglPRdjE7u6nQ8Y4fwDmCh2S6atmbHsIMGvI9tQoET0nqywvCwfi9W1h4nZgA/R5fW3OT4JKGDmdPbHxbS0sC0JvpMRX3oZVjKlQY/P+qVjSW2grc8L4DDWp47qOx7j7pWvaT3lbG7cC047GXqZ2GNY0YWOgku0ibx/CmyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrdfMZzP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrdfMZzP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9171F000E9;
	Thu, 30 Jul 2026 03:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785382162;
	bh=mVU41f9zIQEUlzjWnXfUAR74a/I/zn5kQFLNt4SLCho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MrdfMZzPlOfVNXW/PjXqH/FW4Eq3O/EpGnJDDQv5yVCNmxmUY7J9Gw1V7D6OI+Y2O
	 LOSjszUj6Ygf0HcSeANstBYPR4pldbeD+zALmwKWSAQ4dyqOh5cG/j8S+yN6y1GZ8c
	 IZBKDZ4NqXFVH09Fo+Wx3qke2bU7/a2At1HtI4Qmk4K0Ql2MNVLiLK7+cngUw3jH/v
	 IlRPzm5a8kvjxHol8hx3JJgynSZ74i+qg7JgyRrGLArFstXllOf6NOwEYuTcHQ0Emo
	 WCkfCSnznZRQjW8XQJsdwWFbK7nZGn0kk0LzoBQ2w9MoT7ZyWVLI6t8+Ve7vEZbwQc
	 bMlklL9v3nTGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ata: pata_parport: Fix use-after-free in
 new_device_store
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pei Xiao" <xiaopei01@kylinos.cn>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <77dad1184ebd0e1e7ea541d4207568f8bc5ec01f.1785381141.git.xiaopei01@kylinos.cn>
References: <77dad1184ebd0e1e7ea541d4207568f8bc5ec01f.1785381141.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 03:29:22 +0000
Message-Id: <20260730032922.AA9171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Iterating over multiple protocols without breaking after a success=
ful probe causes a permanent deadlock on `parport_claim_or_block()`.
- [High] The `new_device` sysfs attribute does not enforce positive bounds =
for `mode`, `unit`, and `delay`, allowing negative values that cause out-of=
-bounds array accesses and CPU stalls.
--

--- Patch [1]: [PATCH v2] ata: pata_parport: Fix use-after-free in new_devi=
ce_store ---
commit 0903251c06a3e624fab8c81fa244b1596978b12b
Author: Pei Xiao <xiaopei01@kylinos.cn>
ata: pata_parport: Fix use-after-free in new_device_store

The function new_device_store() calls driver_find() without protection agai=
nst
concurrent driver unregistration. This commit expands the critical section
protected by pi_mutex to fix a use-after-free.

Link: https://lore.kernel.org/lkml/20260728024015.2014674-1-shuangpeng.kern=
el@gmail.com/

> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_p=
arport/pata_parport.c
> --- a/drivers/ata/pata_parport/pata_parport.c
> +++ b/drivers/ata/pata_parport/pata_parport.c

[ ... ]

> @@ -646,18 +647,18 @@ static ssize_t new_device_store(const struct bus_ty=
pe *bus, const char *buf, siz
>  		port_wanted =3D -1;
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but does this function properly validate the
bounds of user input for mode, unit, and delay?

If negative integers are provided in the sysfs write to new_device, they are
parsed as signed integers:

	if (sscanf(buf, "%11s %7s %d %d %d",
			port, protocol, &mode, &unit, &delay) < 1)

These negative values can bypass upper-bound checks and be used as array
indices:

drivers/ata/pata_parport/bpck6.c:bpck6_send_cmd() {
    ...
	switch (mode_map[pi->mode]) {
    ...
}

A negative delay can also be cast to a large unsigned value in udelay(),
potentially causing a permanent CPU stall:

drivers/ata/pata_parport/pata_parport.h:delay_p() {
    #define delay_p			(pi->delay ? udelay(pi->delay) : (void)0)
}

Could we enforce positive bounds for these parameters?

> +	mutex_lock(&pi_mutex);
>  	drv =3D driver_find(protocol, &pata_parport_bus_type);
>  	if (!drv) {
>  		if (strcmp(protocol, "auto")) {
>  			pr_err("protocol %s not found\n", protocol);
> +			mutex_unlock(&pi_mutex);
>  			return -EINVAL;
>  		}
>  		pr_wanted =3D NULL;
>  	} else {
>  		pr_wanted =3D container_of(drv, struct pi_protocol, driver);
>  	}
> -
> -	mutex_lock(&pi_mutex);
>  	/* walk all parports */
>  	idr_for_each_entry(&parport_list, parport, port_num) {
>  		if (port_num =3D=3D port_wanted || port_wanted =3D=3D -1) {

[Severity: High]
This isn't a bug introduced by this patch, but does the protocol iteration
loop handle successful probes safely?

In the subsequent code in new_device_store():

			/* walk all protocols */
			idr_for_each_entry(&protocols, pr, pr_num) {
				if (pr =3D=3D pr_wanted || !pr_wanted)
					if (pi_init_one(parport, pr, mode, unit,
							delay))
						ok =3D true;
			}

And similarly in pata_parport_attach():

		/* probe this port using all protocols */
		idr_for_each_entry(&protocols, pr, pr_num)
			pi_init_one(port, pr, -1, -1, -1);

If a protocol successfully initializes, it claims the parport exclusively.
However, the loop doesn't break upon success and continues trying the next
protocol.

When the next protocol calls pi_init_one() and attempts to claim the exact
same port, it will block indefinitely in parport_claim_or_block() because
the port is already locked by the first protocol.

Could this result in a permanent deadlock during sysfs-driven instantiation
or module loading?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/77dad1184ebd0e1e7ea=
541d4207568f8bc5ec01f.1785381141.git.xiaopei01@kylinos.cn?part=3D1
