Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300580;
	b=1BxcsEC2fhsy1ybf/Yo6W7tBoq8rkHc9+LQmewOERsI+Q+5I6tfuM14gv22/Tr1Hf7vs
	 m/xH7UDQRYg3Sc6zyN5HJSQdfjNiToWo5veSnm94UUuBVb2BTwFix5+x7rDcVzDIQbI2S
	 l5PsAHjEwIj2UvmPMk6iNII564evaUdv7BCGJxFF0t38H6GX2eArXxGqJwJEMytLim8t2
	 iglMjY8N+IzJfMlPd+lOkG0H8/QW2yct8Y/QjRYxcwI+q1nXfqVKMYhE+O0KGjRreVOzx
	 ZuoyR31+h24A19Oh2ujnWOrP+4FuWfUgbVWc47CMqfrDzcLVRHm5RW3xl3x6DaRMudA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300580;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=p+flVXfOz1d1DD2FXAo8MGB/ssFrb+LHoSfddkoa3mw=;
	b=dsnIUKLzbTdBuLl18rjCq9uCqIU8rWfybOzfdAhmpdyjM20cg0+B91ZW3szBCZTcJ8SJ
	 jb4x6yV/NSchlSilTMrXW9l3f8fYd7X1WkE8ChV4d7wrZJFeHnGDYve+WuKz1FWNFc/MD
	 05kv7p5FMQg+CECR01B+TJCdZ7L2nKfj8soFqkBYoMahhNgdXdWnCQDWAsq9tEgGhNLXh
	 533UPxi9iz5TGuat+8ooW/fbzIoNxh9sBG8A7aIETNZqnij2XwLuzRx+OJLV6ub4H3kMZ
	 4N49Ag/fN/aC3jXpvE+N2ZdpPWX505AdQ3MoO6p++NK1oHsix5pt9OKzMLMdHACfDsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OqkKl8Ao;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11526606A332
	for <linux-ide@vger.kernel.org>; Tue, 10 Nov 2026 08:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OqkKl8Ao
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71941F008A6;
	Tue, 10 Nov 2026 08:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794300579;
	bh=p+flVXfOz1d1DD2FXAo8MGB/ssFrb+LHoSfddkoa3mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OqkKl8AoZ4TyHiu7OsAYs1B76x5UxqFgxaVOwXOFAvKptrGL31UAvSjapZ6INLp13
	 +iQR2JaMDoIYE6Y5lWBCb/dgSPJ1EiUHf/vJz+1mNcb9XV3fbKwqyqfyIT7TUhZJxJ
	 jeryLQATNLsJIoS5Ylx996fFhXEvO8b3qsgYmOWDGicUuV2qONbiniHvfJznVF/Qog
	 3CNP42wZe2bt3SV4OvTL2JoEZ4iS0uROTzV4i6C2OYyE/cfs87TtgvwQi+CeuYLdcp
	 qHt3oP884quOvuPPl162tH4hBBHRhoO06STdVBXg0iVjY5+gt+V3HuUYxTPOIXfryO
	 HhMIYVhL6T4WQ==
Date: Tue, 10 Nov 2026 09:49:36 +0100
From: Niklas Cassel <cassel@kernel.org>
To: hyunjungg <hj351016@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ata: libahci: delete the SW activity blink timer on
 port stop
Message-ID: <avLaoEN7bbCS30Jc@ryzen>
References: <20261109092415.1436149-1-hj351016@gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109092415.1436149-1-hj351016@gmail.com>

On Mon, Nov 09, 2026 at 06:24:15PM +0900, hyunjungg wrote:
> From: Hyunjung Ko <hj351016@gmail.com>
> 
> The software activity LED support arms a per-EM-port timer (emp->timer,
> ahci_sw_activity_blink) from ahci_sw_activity() on I/O, and the timer
> callback re-arms itself while the LED is blinking. emp->timer lives in
> struct ahci_em_priv inside the port's ahci_port_priv, which is allocated
> with devm_kzalloc() and freed when the port is torn down.
> 
> ahci_port_stop() never deletes this timer, so when the SW activity LED is
> in use and the port is stopped (driver unbind / module unload) while the
> blink timer is pending, ahci_sw_activity_blink() runs after
> ahci_port_priv has been freed and dereferences the freed ahci_em_priv
> (use-after-free).
> 
> Shut the timer down in ahci_port_stop() before the port private data is
> released; timer_shutdown_sync() also stops the self re-arm. The timers are
> only set up (ahci_init_sw_activity()) when ATA_FLAG_SW_ACTIVITY is set, so
> gate on that flag and skip slots whose timer was never initialised --
> timer_shutdown_sync() on an uninitialised timer trips the debug-object and
> lockdep checks. Sweep all EM_MAX_SLOTS em_priv slots rather than the
> current links, so a detached Port Multiplier's fan-out timer is not missed.
> 
> Not tested on real hardware (needs an AHCI controller with SGPIO
> enclosure management and the software activity LED enabled).
> 
> Fixes: 18f7ba4c2f4b ("libata/ahci: enclosure management support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> ---
> Changes in v2 (thanks to the Sashiko AI review):
>  - gate the shutdown loop on ATA_FLAG_SW_ACTIVITY and skip slots whose
>    timer was never set up (emp->timer.function == NULL): calling
>    timer_shutdown_sync() on an uninitialised timer trips the debug-object
>    and lockdep checks
>  - sweep all EM_MAX_SLOTS em_priv slots instead of the current links, so a
>    detached Port Multiplier's fan-out timer is not missed
>  - correct the Fixes: tag to 18f7ba4c2f4b (which introduced emp->timer and
>    ahci_sw_activity_blink) instead of the later code-move commit
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 001a6f5e4172..3f6844acb413 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2605,9 +2605,32 @@ static void ahci_port_stop(struct ata_port *ap)
>  {
>  	const char *emsg = NULL;
>  	struct ahci_host_priv *hpriv = ap->host->private_data;
> +	struct ahci_port_priv *pp = ap->private_data;
>  	void __iomem *host_mmio = hpriv->mmio;
>  	int rc;
>  
> +	/*
> +	 * The SW activity LED blink timer (emp->timer) is armed from the I/O
> +	 * path and re-arms itself, and the ahci_em_priv it lives in is part of
> +	 * the devm-allocated ahci_port_priv; shut it down before that is freed
> +	 * or it can fire against freed memory.  Only slots whose timer was set
> +	 * up by ahci_init_sw_activity() may be touched -- timer_shutdown_sync()
> +	 * on a never-initialised timer trips the debug-object/lockdep checks --
> +	 * and all EM_MAX_SLOTS slots are swept, not just the current links, so a
> +	 * detached Port Multiplier's fan-out timer is not missed.
> +	 * timer_shutdown_sync() also stops the self re-arm.
> +	 */
> +	if (ap->flags & ATA_FLAG_SW_ACTIVITY) {
> +		int i;
> +
> +		for (i = 0; i < EM_MAX_SLOTS; i++) {
> +			struct ahci_em_priv *emp = &pp->em_priv[i];
> +
> +			if (emp->timer.function)
> +				timer_shutdown_sync(&emp->timer);
> +		}
> +	}
> +
>  	/* de-initialize port */
>  	rc = ahci_deinit_port(ap, &emsg);
>  	if (rc)
> -- 
> 2.43.0
> 

Patch looks good to me, but the code comment is a bit overly verbose.


Perhaps something like:

        /*
         * Stop the SW activity blink timers before devres frees pp, skipping
         * the slots that ahci_init_sw_activity() never set up.
         */



Kind regards,
Niklas
