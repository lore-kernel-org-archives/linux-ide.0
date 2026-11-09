Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216007;
	b=z5GFk0nu9jHnL1ABiqZjEevQYINqio9pX7goDKeQKdeIxyic12xlyDSVi4wFMSUlAS5M
	 xzAFpyyWZcVurKl0oGkUxsvUQi3+enoAIubh7ZOG26HwPva6AmbnOO4mxiClxJNuDMrMT
	 P4DIpQaUGDECYrue2xRjpPQqIlAN/P0uPEpAmpdLwzCpn/GwD+YA/+08qbrj5f1GMwPJ6
	 zXBRgP1Z4mPIuNwtd5GtO1lBvbPS1pdGchIlALSF2WuuymJjKZgc2XJbsH+XHwlrANhKQ
	 8KINconCk3DaAMpcsDiwX3EK0/PU2/SzobfEWzamCNzqw1Tn0n4wsSZdmZkzXdX/EFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216007;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+DCIUY3XI/ldYWwLHJ3+84eRszDPsNjV5Icr1yc79ls=;
	b=ztsBq9vNDHNbN9t6D2Nj32PJXKAYC8FesO4IPO1c0VgOU9ZGMBFyfbK8dpY9XxBNxxay
	 nijYdptzaNn6vILXWPSf/bag/XlZ2lhVjdsL6e+IwUl21tbHdhWaajvhd8L6k4ALjP1n5
	 j03cvNHYdqEkPsaOQqjVXUjztNPZkQqkzpA4jReT0VJtwvjZblxvd14NMkqyFQqRsQdI8
	 AXEA3bzBXqFpBu1U6SKxRSy4mVmd4zIC2vn83xwOYeVwtgm0quKN9beDlkL6MMhOwUT9+
	 mKQ2xAHJXllEYC6yAVF0EY5PY9IrDfV6CCTreUU/dwZLW3ob+M0AK8YxQO36JmzRFHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Xf/1bhAx";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0959606A31C
	for <linux-ide@vger.kernel.org>; Mon,  9 Nov 2026 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xf/1bhAx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D5D1F0089F;
	Mon,  9 Nov 2026 09:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216006;
	bh=+DCIUY3XI/ldYWwLHJ3+84eRszDPsNjV5Icr1yc79ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xf/1bhAxwTP4lYRMCAyV4c0lw3VLRibpb4yylEZrzJQVqOyAYzOyb5Zd/gmuElha2
	 eb40kdy0UhFe2RDBxw6ZlTExQysen0wGGa3WNPb/ggndEqCyviwQ5R0LmHOAu7nbvf
	 9Fq0N2cowg8v6FJECrhgvU6mpNixXh36/fDG77uTA6gPLH4B6WB0PAr3ISoGl3Ivo5
	 91/U7Z2lfHz4llewmCrLl1y6/ZWsKX6p5mtTf9ixtNZsI6BhKDV6dPkC7zc6D2V9HJ
	 gWOTJnSrRtO7s+K0iZLOE+ry4Y5ikfxeZDdqZapEcimWk+woX9a7CSl741KZ8B0el9
	 zUa1EnmX2BvNw==
Date: Mon, 9 Nov 2026 10:20:02 +0100
From: Niklas Cassel <cassel@kernel.org>
To: hyunjungg <hj351016@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ata: libahci: delete the SW activity blink timer on
 port stop
Message-ID: <avGQQqWBRC-iWOGt@ryzen>
References: <20261109060709.1231946-1-hj351016@gmail.com>
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
In-Reply-To: <20261109060709.1231946-1-hj351016@gmail.com>

Hello Hyunjung,

On Mon, Nov 09, 2026 at 03:07:09PM +0900, hyunjungg wrote:
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

Where is the changelog?


Kind regards,
Niklas
