Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794161768;
	b=2ZvMapSzE74tvwcwzvBM/wvrvbM6IipcucOzFGWX8Mow+ct1bxS320cHy0CySolQUfmc
	 5k7ONWkoD6LkaN8l12GGuKabmtUMIt7pnr0q0wFbntYmn8Vrr47pd7Xp4EJuKGWKTh/IN
	 CPZBAK8sIRNole3hLi3bTlq7qhyRwou74SwMqNTVR4brB4OvGkBXG7sx6RgR/Z6Hh4rhn
	 /1Fip/4rUQnws8LaR6+T5NPWCLFxuNLrLvpq88EEufPqMmV2obS3d6tNsdrXVTMYdhJ5c
	 LxJshtR7aADmKGMr20p+VxfuHgzsUoqV7ELLLNtyjG3S9OShPmmR079ke9Khl2Rr+pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794161768;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BZgHq6NitxGs5mJWetVugPXQ/sZKbKVnrm6OaIGhgws=;
	b=L+WVTG+nNOVvmTV2sCjUJUM7g+0AvjhWI7erzbEutMXx7v+GpcTZLn9Vdfxnmhj7T/C5
	 RY0x+2D8glbQS0n33lfXamkI0JyzClfMcLXbFsT1WUNCCmXwBRCdxBxhHxrdd6+Ql+6FZ
	 qRO297+wubkMBjEJrELJ5ScSlK8daqf6ns7HHJxT5hkV5s8mrkd6N0jHMAaL/fJXVTphQ
	 TF/MpfVMsbnZ7T/kRm+aKEDUbU4fuG4afLvwbWHI2m3OssrQLZyeBewr5YLfb1m+GWW19
	 tD2aOPRuZQhDA3dy+W2s+shYyu6nWxLzL5nFZCenX6K1WDuVzGeVAF3w+WDZWW8ASQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDicOHFb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A3F606A331
	for <linux-ide@vger.kernel.org>; Sun,  8 Nov 2026 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDicOHFb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3AF1F0089F;
	Sun,  8 Nov 2026 18:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794161768;
	bh=BZgHq6NitxGs5mJWetVugPXQ/sZKbKVnrm6OaIGhgws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SDicOHFbgCXiBIUp9DlXdc5ZrgrhiPtKOUNOCr0es9vdlP3ge6+gjPJ2OOCAkt7Nt
	 Ca85BTKwui7/LZvlONkHY7YEnvwELXuMbjZNbXY1HfTXU7wPiHmDCQNYid9zY/oPBK
	 xu7ziKmAV5iLrW6yDkw4UCJiM6fIJwESK6HOpdn4TzN51/hgtMYGPq09UvvAyoWQiA
	 x1DMUT3qp9N7SlOOd73N3R+PGW9iQ/6OdjHcbckmNumMbicRxVo/TOJu3d1uNjGPAF
	 iDA+A+G9Z8RCp3Im8fk9cBQPWcI+QiuNnpCtGd2cb277miakOvBu1YCw1ggiZHqMxx
	 oqJszJURqtffA==
Message-ID: <sashiko-outbox-203900@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: libahci: delete the SW activity blink timer on
 port stop
Reply-To: sashiko-reviews@lists.linux.dev
To: hyunjungg <hj351016@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20261108180134.734111-1-hj351016@gmail.com>
References: <20261108180134.734111-1-hj351016@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 18:16:07 +0000
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] ata: libahci: ahci_port_stop() shuts down uninitialized
  emp->timer
- [Medium] ata: libahci: ahci_port_stop() misses detached PMP emp->timer
  slots
- [Low] ata: libahci: inaccurate Fixes trailer in ahci_port_stop()
  commit
--

commit 8312e7f06863279e24cc7d045b296589047833e6
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
> Shut the timer down in ahci_port_stop() for every link's em_priv before
> the port private data is released. Because the callback re-arms itself,
> use timer_shutdown_sync() so a concurrent re-arm cannot resurrect it.
> em_priv entries without an armed timer are zero-initialised, for which
> timer_shutdown_sync() is a no-op.
>
> Not tested on real hardware (needs an AHCI controller with SGPIO
> enclosure management and the software activity LED enabled).
>
> Fixes: 365cfa1ed5a3 ("ahci: Move generic code into libahci")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>

[Severity: Low]
Commit 365cfa1ed5a3 ("ahci: Move generic code into libahci") only moved the
existing code into libahci.c.  Should the Fixes: tag point to the commit
that introduced emp->timer and ahci_sw_activity_blink() instead:

  Fixes: 18f7ba4c2f4b ("libata/ahci: enclosure management support")

> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 001a6f5e41723..873645c982496 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2605,9 +2605,23 @@ static void ahci_port_stop(struct ata_port *ap)
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
> +	 * The SW activity LED blink timer (emp->timer) is armed from the I/O
> +	 * path and re-arms itself; shut it down before the devm-allocated
> +	 * ahci_port_priv it lives in is freed, or it can fire against freed
> +	 * memory.  timer_shutdown_sync() also stops the self re-arm.
> +	 */
> +	ata_for_each_link(link, ap, EDGE) {
> +		emp =3D &pp->em_priv[link->pmp];
> +		timer_shutdown_sync(&emp->timer);
> +	}

[Severity: Medium]
Does this call timer_shutdown_sync() on an uninitialized emp->timer when
ATA_FLAG_SW_ACTIVITY is not set?

ahci_start_port() only calls ahci_init_sw_activity(), which runs
timer_setup(&emp->timer, ...), when ap->flags & ATA_FLAG_SW_ACTIVITY is
set.  Even when ATA_FLAG_SW_ACTIVITY is set, ahci_port_start() ->
ahci_start_port() runs before a Port Multiplier is attached, and
ahci_pmp_attach() never calls ahci_init_sw_activity(), leaving
pp->em_priv[1 .. ap->nr_pmp_links - 1].timer zero-initialized unless
ahci_port_resume() runs later.

timer_shutdown_sync() is not a no-op on zero-initialized devm_kzalloc()
memory: __timer_delete_sync() calls lock_map_acquire(&timer->lockdep_map),
which triggers "INFO: trying to register non-static key" and disables
lockdep under CONFIG_LOCKDEP=3Dy, and __try_to_del_timer_sync() triggers a
debug_assert_init() warning under CONFIG_DEBUG_OBJECTS_TIMERS=3Dy.

[Severity: Medium]
Can ata_for_each_link(link, ap, EDGE) also miss pending emp->timer instances
after a Port Multiplier detach?

If a Port Multiplier had pp->em_priv[pmp].timer initialized and armed on a
fan-out link (pmp >=3D 1) and was then detached before ahci_port_stop(),
sata_pmp_detach() sets ap->nr_pmp_links =3D 0 without stopping those timers.
ata_for_each_link(link, ap, EDGE) then visits only &ap->link (pmp =3D=3D 0)=
 and
skips pp->em_priv[1 .. EM_MAX_SLOTS - 1], so a still-pending blink timer can
fire after pp and ap->pmp_link are freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108180134.7341=
11-1-hj351016@gmail.com?part=3D1
