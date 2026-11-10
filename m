Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302727;
	b=3Qe0LZFdb/TcBl3+GLF+NTU3RehjuVkD/b0fnX/iJDV1K20QBArnPkk60R2Nqs+dIc21
	 lTklvhFkv0IVn1gk2Aa2WArjiiM5nBVoWOiSKHHAE3TYaqXt1KlxuT1cr8bBerD2hRCSg
	 5IYN2uktuI/To67NDEOJj/3totQQd+EWXpdFcUH1/Bjf8q+a7fE4WcFg5ldq5/dY8ZdEq
	 nZBnrbmKl/ejFGXEeckSB86e5DQVd/FHxc7ocwrFeZSbBdJ6UXzD2+LagPKBJCHy2e3CK
	 6H5aWxhTXHhkdZr4dWU5v17WfJnqzwxxxzan33uAgdT1gfDH060x58ptiAes2yDgMbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302727;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tOyeXmguz+DSy4zwwIvx8vm7UqJxcpLUyqHC0TqvJus=;
	b=pWwYUxmr1OcejwfB9ELWBXepZUZ6ReZT+3b+VbnW4oSkSWX1x+G2dJTPSftOVOvBJnbe
	 DkSiPfhH0RdPV73XIrU7hFf7N+a9ngj2UOegzOyla65I7XxHKVUUpmEV4TeaVRHgU22v4
	 XphCitkizVZaFyHnLVMgtiDtjtF6FEhOLoccvIJrt8nfkxN/wwBzvLoLP5Lv9jS0ZLaL4
	 Rzv4hlU02+BITPh767QFyn7BwWrigeRfliYS6Y1NJkoL2TfkU4oMVmrzazCtxttMAc5ma
	 7u/1azqE52WsmYo2TguAe6vV/38rF2OSGj9fus28sqCZd0X7g6kX0qM2TtySOfk2fRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Elsyu27o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BE2606B161
	for <linux-ide@vger.kernel.org>; Tue, 10 Nov 2026 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Elsyu27o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79811F008A1;
	Tue, 10 Nov 2026 09:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302727;
	bh=tOyeXmguz+DSy4zwwIvx8vm7UqJxcpLUyqHC0TqvJus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Elsyu27o40a3HzbGUUg/tv/SC5dZ9Y4utHSI/luq+fRStQtTh+RofSchI8zuhU61h
	 alZkTWFZoKyliQGRHVhi/OnCilChfhCYUSVUkmJ46eGgf2jN4elAyLgLJ1PQCCoyio
	 G0ZC4cmlTVWK2Cn3pnGTXvb7GFOe4/fpVLL4I7YUZz6+lfb/KYLgEWzbEDaTygu46l
	 Y6FuQ8fXZwl5Vw+GIkvriqeZ1rwtW/mR4oAq1YFTYcYYdmC3XWpHOi6oaOAESFmJHV
	 EnuO37DzNpvrJUTHu8MQZtTVb+qmPlOLUxGrVjVEYDGTcNmDP7UrnpzOfDu19FGQf0
	 +w887L5uG/azw==
Message-ID: <sashiko-outbox-206736@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] ata: libahci: delete the SW activity blink timer on
 port stop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hyunjung Ko" <hj351016@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20261110090303.2415681-1-hj351016@gmail.com>
References: <20261110090303.2415681-1-hj351016@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:25:26 +0000
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] ata: libahci: ahci_port_stop() skips timers on detached PMP
  slots
- [Low] ata: libahci: Fixes trailer cites code movement commit
  365cfa1ed5a3
--

commit b31d9e35a39c06af6f90ba34e4a622ba2889d52f
Author: Hyunjung Ko <hj351016@gmail.com>

> ata: libahci: delete the SW activity blink timer on port stop
>
> The software activity LED support arms a per-EM-port timer (emp->timer,
> ahci_sw_activity_blink) from ahci_sw_activity() on I/O, and the timer
> callback re-arms itself while the LED is blinking. The timer lives in
> struct ahci_em_priv inside the port's ahci_port_priv, which is allocated
> with devm_kzalloc() and freed when the port is torn down.
>
> ahci_port_stop() never deletes this timer - nothing in libahci does - so
> when the SW activity LED is in use and the AHCI port is stopped (driver
> unbind / module unload) while the blink timer is still pending,
> ahci_sw_activity_blink() runs after ahci_port_priv has been freed and
> dereferences the freed ahci_em_priv (use-after-free).
>
> Shut the timers down in ahci_port_stop() before the port private data is
> released, only when ATA_FLAG_SW_ACTIVITY is set and skipping em_priv slots
> that ahci_init_sw_activity() never set up. Because the callback re-arms
> itself, use timer_shutdown_sync() so a concurrent re-arm cannot resurrect
> it.
>
> Not tested on real hardware (needs an AHCI controller with SGPIO
> enclosure management and the software activity LED enabled).
>
> Fixes: 365cfa1ed5a3 ("ahci: Move generic code into libahci")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>

[Severity: Low]
365cfa1ed5a3 ("ahci: Move generic code into libahci") only moved the existi=
ng
AHCI code from drivers/ata/ahci.c into drivers/ata/libahci.c.  Should the
Fixes tag cite the commit that introduced emp->timer without stopping it in
ahci_port_stop()?

  Fixes: 18f7ba4c2f4b ("libata/ahci: enclosure management support")

> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 5ce34683d4683..cf1b50f6dc52c 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2605,9 +2605,24 @@ static void ahci_port_stop(struct ata_port *ap)
>  {
>  	const char *emsg =3D NULL;
>  	struct ahci_host_priv *hpriv =3D ap->host->private_data;
> +	struct ahci_port_priv *pp =3D ap->private_data;
>  	void __iomem *host_mmio =3D hpriv->mmio;
> +	struct ata_link *link;
> +	struct ahci_em_priv *emp;
>  	int rc;
> =20
> +	/*
> +	 * Stop the SW activity blink timers before devres frees pp, skipping
> +	 * the slots that ahci_init_sw_activity() never set up.
> +	 */
> +	if (ap->flags & ATA_FLAG_SW_ACTIVITY) {
> +		ata_for_each_link(link, ap, EDGE) {
> +			emp =3D &pp->em_priv[link->pmp];
> +			if (emp->timer.function)
> +				timer_shutdown_sync(&emp->timer);
> +		}
> +	}

[Severity: Medium]
Can ata_for_each_link(link, ap, EDGE) miss armed timers in
pp->em_priv[1..EM_MAX_SLOTS - 1] if a Port Multiplier (PMP) was detached
before ahci_port_stop() runs?

During EH recovery in sata_pmp_eh_recover(), ata_eh_recover() can issue
internal commands on PMP fan-out links and arm pp->em_priv[k].timer via
ahci_qc_issue() -> ahci_sw_activity().  If recovery then exhausts pmp_tries,
sata_pmp_eh_recover() calls sata_pmp_detach(), which sets ap->nr_pmp_links =
=3D 0
without stopping those timers.  When ahci_port_stop() runs,
ata_for_each_link(link, ap, EDGE) sees !sata_pmp_attached(ap) and only visi=
ts
&ap->link (pmp 0), leaving any pending fan-out link timer to fire after pp =
and
ap->pmp_link are freed (use-after-free).

Since the loop already checks emp->timer.function, iterating over all
EM_MAX_SLOTS entries in pp->em_priv[] directly would shut down all initiali=
zed
timers regardless of whether a PMP was detached.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110090303.2415=
681-1-hj351016@gmail.com?part=3D1
