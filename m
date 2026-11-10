Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306454;
	b=Z9zVy1jNpr5G1xGVLoybXPn3ANHXwcKwr8JEQIWbPRgmeExuMtHiCrzK1xIvJOY226dW
	 60lEF86IodFFQIJbdRauqk/k2QASiWtK/2CgEyZkrsbjF7EGSitVzHpE3XEyLUwV3fkFl
	 dDnWqz0HdT2iHpz9LlH4TahuCAHr+yWgTTJJzV3U+4R+j/1sqyA99Pi8gG0IGxLyhxEXm
	 xhban9lvth3mxO+VX8otz7cdwwpyAMnd0JF8mymDhrYB+jxzgNezTc/eAiZvq0bmzkefM
	 U/NP6YjFsr4myaXLcFLf0ExFgk9BJFndB/oRAwX7gKxQ9+dc5eXcwLoypb1UBtVPnXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306454;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Qkkw/pVWch/kBFYIok040cLMtBM2B5mFBuS/q/6uGFQ=;
	b=ndrvHNMc9YKscZYzQIDABBcI/I5j9mx/C9UOK2KD9WIpAg4gBYx81ELtQaieDs52pzNS
	 t9nXU5az0CTGVvCayCSkZlonIOSlQ32jtx/zxBXokJ75485nC+0HgQNVbHO8gMC0ueHyy
	 hkMDso6HMo7dg5L4fDK+z9Ir2/V1XswOzjepcoVdMST5VkuPD+3ms3t/U0E0VdHlp6XDi
	 iaq3w+/BUPSy6gdh5TzG7sBg0XHWISumJkLBti3zqWcDaaS0zhBSYdnHN6wqYrsy6Rvr7
	 GMn6PKdJggbY96RN+ejJQUTgLKV/Kndf5RAIFU24gznYAm+sK6zYARpOa7qrYoSaeOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JM8z/D6i";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5E7606A321
	for <linux-ide@vger.kernel.org>; Tue, 10 Nov 2026 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JM8z/D6i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96F31F0089F;
	Tue, 10 Nov 2026 10:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794306453;
	bh=Qkkw/pVWch/kBFYIok040cLMtBM2B5mFBuS/q/6uGFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JM8z/D6i7cM8RPHJgHogr7ESx8h1KBImzkX6bqVxWrUlh3jdmNTJJxsV0xjGZ5UrL
	 9yCW2Z5OXnO2SeOP07RH3HY/LlZVi02cWI6TH8W4HAi2ugqfPZTMsJi2lEGF0QmIv5
	 OsWO34OToZLjFMVK68vhENdKLvgkiV6fIQFAu+7bX86Acw5SzocqxBLQaKaX28wzzc
	 hmx6jx4qPUHyDgSxteJCC/gAFmexTqSZRYqEmgvpB7alCzKp5+AQA4gHP0xSA46txJ
	 81UHMD+oFuWfRCnTZhNYIW2hOJt7IT7YbwlMt9BrF7I18v3SsPDyyH8U5uFYGr96f1
	 0eZvHg5k+IJyg==
Date: Tue, 10 Nov 2026 11:27:30 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hyunjung Ko <hj351016@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v3] ata: libahci: delete the SW activity blink timer on
 port stop
Message-ID: <avLxkrcgP97hiUV1@ryzen>
References: <20261110090303.2415681-1-hj351016@gmail.com>
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
In-Reply-To: <20261110090303.2415681-1-hj351016@gmail.com>

On Tue, Nov 10, 2026 at 06:03:03PM +0900, Hyunjung Ko wrote:
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
> ---
> Changes in v3:
> - Shorten the code comment (Niklas Cassel).

It seems like you modified v1 instead of v2.

v3's index line is 001a6f5..873645c, exactly v1's. Applying v3
to blob 001a6f5 actually produces ace66cd, so the patch was most
likely hand-edited from v1 rather than regenerated.

Please use git format-patch.


Kind regards,
Niklas
