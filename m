Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417803;
	b=KsLsivVgqFaX99pd4COKVL+mE8oQIR2BbuD3rgnmMZ0fIjevmR3atPWNP3g8RTuXi9O5
	 KQKCGBkgOgaTYERLblFQEOiCT0u2UmcruNnpxveFQ3BCjigkLwJTl49+Limwf74hHx1kj
	 eV9Iq8GyEk9j4N3tkcJHI/ucjMOsTm+bP85ijPccmloK/99MZI8y0P2rJ6BB9u17w87ih
	 aGA8FO7NRPokwaQonpwCP6cpOD0GeBGwFwVYiJOIvLwwwdXf1O3s8W7fk7bXuRPJCjBk7
	 mq522lJY7bPlzIB1zCqBVuOXSX6V4M0kN9RDyt3atvxkf1+eIVz58K7WyqesDul3McA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417803;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kin+dSe0W0jSKNitImm3jJVSmpxuH2Z/fCP9V4M5omo=;
	b=hFfGVm8xiaHDzRdq7kfCRgCcnXagpCr7QXxbMDLtD8Ga8M/KIcKnymMSmzIWTPwVkx5K
	 2oI5yN9I+x1WK1bMnMSBb8F5ymUc/LkvaqIKcWzIZ9G3V4iQhoRQip4USTJFyXPHVJDj1
	 2gCPMBrA3/hEOW2ByoeOEdWtSjcO6WCkzsjz5Di6Wz+h12nB2b2wIyy0mcw/XPJ+BfJ6q
	 B9wuDp2dCvWqNwqDjJrzpvqfiouilO3LHbl1GpyhDSpG7gKzzZIKYulTYKHyqRknnBLoa
	 +RI1BrAxkpVOsVlix4U9YJYEcg8Adrbh1MRAhZNTimsZ2gH+7Wcb5/CmQOEnk2pmgEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y64oJUi8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223C5606A31C;
	Wed, 11 Nov 2026 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y64oJUi8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505D81F00A05;
	Wed, 11 Nov 2026 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417802;
	bh=kin+dSe0W0jSKNitImm3jJVSmpxuH2Z/fCP9V4M5omo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y64oJUi88YZNdO7h7lkE3kaS2adY+4eISbYqqYd75/pjnIPPrHRZ21js+SAUBRp1U
	 uY8g8A+uPE6tGqIxPGSS4ID14PfZZqF+lEQJ+KYcCMbYSq5mM4OhAXoKkGZwfyzov3
	 LE9h/QxH42qBX6CTpFDcOa1PJayXBVHtnb8vGhWn/5mgZRCr/GaaUHiP5/YoBTsM3O
	 wPhiX+x2VkmqZRkK5x0uftx/94H5GDnTiLDITx1A0DEjwsJ5SvyVoN/ZQyDz2v4Owj
	 ML97bweYJzsjzxLLFEAErAGm8dkKGiGJRSiDegjTPwatjSyp/21GSy8t35TscSfD1w
	 NwAW1E0IJX3pQ==
Message-ID: <sashiko-outbox-209405@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/7] zorro: warp mfd: add the dual-port RAM command
 channel and expose the board identity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Pisati" <p.pisati@gmail.com>
Cc: linux-ide@vger.kernel.org, mfd@lists.linux.dev, dlemoal@kernel.org, cassel@kernel.org, lee@kernel.org
In-Reply-To: <20261111163735.227286-5-p.pisati@gmail.com>
References: <20261111163735.227286-1-p.pisati@gmail.com>
 <20261111163735.227286-5-p.pisati@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:23:21 +0000
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] zorro: warp-mfd: stale reg_cr irq flags not cleared in
  warp_send_msg()
--

commit 4b5b6213bfa8c6be415c4e81b0b8ac501eb8e890
Author: Paolo Pisati <p.pisati@gmail.com>

zorro: warp mfd: add the dual-port RAM command channel and expose the board=
 identity

This commit adds the dual-port RAM command channel and interrupt handling
to communicate with the ARM co-processor, exposing boardname, fmwver, and
hwver in sysfs.

> diff --git a/drivers/zorro/warp-mfd.c b/drivers/zorro/warp-mfd.c
> index 94af7c9d0ea5e..61866f678b613 100644
> --- a/drivers/zorro/warp-mfd.c
> +++ b/drivers/zorro/warp-mfd.c

[ ... ]

> +/* send a message to the ARM coprocessor, optionally waiting for a reply=
 */
> +static int warp_send_msg(struct warp_mfd *warp, bool wait_reply)
> +{
> +	struct completion *done =3D wait_reply ? &warp->reply : &warp->recv;
> +	long ret;
> +
> +	/* a previous exchange may have timed out and completed late */
> +	reinit_completion(done);
> +
> +	/* enable 68k & ARM interrupts */
> +	z_writel(DPREG_CR_SET | DPREG_CR_IE_68K | DPREG_CR_IE_ARM, warp->reg_cr=
);
> +
> +	/* send irq to ARM */
> +	z_writel(DPREG_CR_SET | DPREG_CR_MP_ARM, warp->reg_cr);
> +
> +	/* wait for a reply, or just wait for a receiver ack */
> +	ret =3D wait_for_completion_interruptible_timeout(done,
> +							WARP_MSG_TIMEOUT);
> +
> +	/* disable ARM & 68k interrupts */
> +	z_writel(DPREG_CR_CLR | DPREG_CR_IE_68K | DPREG_CR_IE_ARM, warp->reg_cr=
);

[Severity: Medium]
Can an interrupted or timed-out wait leave DPREG_CR_MR_ARM and
DPREG_CR_MP_68K latched in warp->reg_cr?

When wait_for_completion_interruptible_timeout() returns early (such as on
a signal during a sysfs read), warp_send_msg() clears DPREG_CR_IE_68K
while the ARM is still processing the command.  When the ARM finishes, its
status flags stay latched in warp->reg_cr because the interrupt is
disabled.  On the next command, enabling DPREG_CR_IE_68K after
reinit_completion(done) immediately triggers warp_irq() from the stale
flags before the ARM processes the new request, so warp_exec_cmd() reads
back the command opcode still in warp->dpram and warp_get_status() fails
with -EIO.

Clearing DPREG_CR_MR_ARM and DPREG_CR_MP_68K before reinit_completion()
and enabling DPREG_CR_IE_68K would avoid completing on a stale flag.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111163735.2272=
86-1-p.pisati@gmail.com?part=3D4
