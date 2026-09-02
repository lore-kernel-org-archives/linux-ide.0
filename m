Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D21481FD1
	for <linux-ide@vger.kernel.org>; Wed,  2 Sep 2026 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350871; cv=none; b=UGjoirw6krGfxRMz0Ndo/eY+GKr5EVZ8blt0vNmTgRdmd3QJwTLlcxdypg8dCKTDEpaLO8CgkB/gKrEsPcSY7o8Ln8KGfUZimnh7btSL931dHdK/lDFFyEDKaKM0Zn6LkGhgy/Xhmt0/6MZY9q8+LGQa1gyzEsrN6QmEuVJJhXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350871; c=relaxed/simple;
	bh=+aLUfT6d6raiRkqHR5bCLw0bPpCLCFLH9To05eox9Xk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tJwwQfVAHaOtjOuzkEcIUCwnxHhgr2QC0XdOj319z0a50G/cFyvZohfkL1ksDOlbR1u4J3B5/FZB8lU5kUU2tWULpHCfrdUPD5ckMxKfCoRqHhL6SX4jooaUhjlRSxKnYdOcQGz6jQt7UIjLXKiu8zIYWfthKNutAcEhK3ufv+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BztK3QjV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BztK3QjV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FEF1F000E9;
	Wed,  2 Sep 2026 12:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788350860;
	bh=z6d4sjbbNKvPwHOP2KPOoowxO7p7OKBeNum+Xzuc1kY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BztK3QjVAIMntlAb8PMQk3d78Uvdwf0+yGX+jBvbXpELcHjzEWy7sBKKtgMQVZE4H
	 PlUqzgojuigjunj2xQA8dT4SLUH4i72BcaJSAqU9wrdl8dDk3y5iICJkBysXE2nFap
	 oWfI52xpxA2Pngm/hamqW15tCIAcRxHrgzcKxFsmsGkTBMt2kDqtw50TQ7e12uxRw4
	 yeZlexKd712G2qhJT+8URWWjURLKK+HVvO/G9hDg344gYGZEbyNif9wRk53D08xE28
	 ZTwOU38f159mC1LPINU2HiL402dqglYbFu/hi5uPnXVvps1yT3np6LV1J3Rln5r3y8
	 SEywqFI/+TDbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] ata: pata_parport: unregister devices on protocol
 unregister
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pei Xiao" <xiaopei01@kylinos.cn>
Cc: linux-ide@vger.kernel.org, cassel@kernel.org, dlemoal@kernel.org
In-Reply-To: <7215874eab207352d52473a72b59433b8470ade8.1788349317.git.xiaopei01@kylinos.cn>
References: <cover.1788349317.git.xiaopei01@kylinos.cn>
 <7215874eab207352d52473a72b59433b8470ade8.1788349317.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 12:07:40 +0000
Message-Id: <20260902120740.98FEF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] AB-BA deadlock between `pi_mutex` and parport claim during device =
probing.
- [High] Missing NULL check on dev_get_drvdata() exposes a NULL pointer der=
eference if the driver is unbound via sysfs.
--

commit 5b5d1ccae8e55ae326690dca369a3675ed2bc9bf
Author: Pei Xiao <xiaopei01@kylinos.cn>
Subject: ata: pata_parport: unregister devices on protocol unregister

When a protocol module registers multiple protocols and a later
registration fails, the rollback path unregisters the protocol but
leaves the dynamically created pi_adapter devices untouched. This tear
down ensures adapters are removed while the module is still alive.

> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_p=
arport/pata_parport.c
> index 7462f9b1acc57..4ee5188070319 100644
> --- a/drivers/ata/pata_parport/pata_parport.c
> +++ b/drivers/ata/pata_parport/pata_parport.c
[ ... ]
> @@ -612,6 +612,18 @@ int pata_parport_register_driver(struct pi_protocol =
*pr)
>  }
>  EXPORT_SYMBOL_GPL(pata_parport_register_driver);
> =20
> +static int pi_remove_by_proto(struct device *dev, void *data)
> +{
> +	struct pi_protocol *pr =3D data;
> +	struct ata_host *host =3D dev_get_drvdata(dev);
> +	struct pi_adapter *pi =3D host->private_data;

[Severity: High]
This isn't a regression introduced by this patch, but does this missing null
check expose a null pointer dereference if the driver is unbound via sysfs?

If a user unbinds the driver via sysfs, dev_set_drvdata(dev, NULL) is calle=
d.
Later, when pi_remove_by_proto() or pi_remove_one() is triggered, wouldn't
dev_get_drvdata() return NULL and cause a crash when dereferencing
host->private_data?

> +
> +	if (pi->proto =3D=3D pr)
> +		pi_remove_one(dev);
> +
> +	return 0;
> +}
> +
[ ... ]

[Severity: High]
This is a pre-existing issue, but is there an AB-BA deadlock between pi_mut=
ex
and the parport claim during device probing?

During module initialization, we loop over all available protocols for a gi=
ven
parport while holding pi_mutex:

drivers/ata/pata_parport/pata_parport.c:pata_parport_attach() {
    ...
	mutex_lock(&pi_mutex);
    ...
	if (probe) {
		/* probe this port using all protocols */
		idr_for_each_entry(&protocols, pr, pr_num)
			pi_init_one(port, pr, -1, -1, -1);
	}
	mutex_unlock(&pi_mutex);
}

If a device successfully initializes with the first protocol, it permanently
claims the parport:

drivers/ata/pata_parport/pata_parport.c:pi_connect() {
    ...
	parport_claim_or_block(pi->pardev);
    ...
}

The loop then proceeds to the next protocol and attempts to initialize it f=
or
the same port. Does the second initialization block forever while holding
pi_mutex?

drivers/ata/pata_parport/pata_parport.c:pi_probe_unit() {
    ...
	if (pi->proto->test_port) {
		parport_claim_or_block(pi->pardev);
		max =3D pi->proto->test_port(pi);
		parport_release(pi->pardev);
	}
    ...
}

Because the port is permanently held by the first adapter, it appears the
thread will block forever while holding pi_mutex, causing a system deadlock
blocking all future parport ata operations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788349317.gi=
t.xiaopei01@kylinos.cn?part=3D2
