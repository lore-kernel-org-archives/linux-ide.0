Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B49413789
	for <linux-ide@vger.kernel.org>; Fri, 16 Oct 2026 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141630; cv=none; b=YPO65iuoVjFtv21RHUe5VJe5RbSaa1Jxbg5jBNOZIcyKt3JmVpxwYSrLsb7p2GjzvG6nKdpGtrJw3o+ZPiVg6kPok/B8hEm/8iJfRCw3ym/6d5kTHkBHPmZslTh2eGEc1cuSBn7wKXtpwMNHzJGl4mLVb0fr7ccK3UEdLJ+spE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141630; c=relaxed/simple;
	bh=G32wv8ECojbFLh9JUbyuS8+GlGt9HiBsK+NNE4I821I=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=U9dtZmNtsAeeuWHVcih8pMhS33LxU20Zx9+bD86iyikxoYQMEzfAU+7ldjSsVALv6R39buN+ygYSWFmGV2RqceoxFYBLLlERTipVfQGYE8+wa6b9bIQAfAv8Bbt2U2UJIFzV71wcW0VEhS/it6d5E6LIJH+JwRx76TEFcmpKb9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvfwygI1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvfwygI1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B131F000C5;
	Fri, 16 Oct 2026 09:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792141629;
	bh=wFqn5Np7nGe9/64Jhf3KVXpTI5cqUJQKLZmSWuk5bRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XvfwygI1hFR+460K4FTGSgZJUScWaNA4NYx094K0f8konqTS2a98BjmudOKvPWwdY
	 r/qaq39eJYX9TS+YgqkHENBuX/5Jg8gjC3J44XSz0q5I4aoIbUa0nJmIkUw8kOBySz
	 29k0bxh52Q5crqIis8sylYGHqrPkN+geLygnNNtETIK3/zUEdxB2COV1R3Ep3gvokO
	 d8WNPDZAYVpDnVGqldoYYJMgbCIx7Zf9PZRQgnZohR9JLhWUTUeJxYYVG+Ek6qGU2k
	 Yt/JBn/cMjPyJtiOkYmMgx+JBVnYDUKNqhXo+06wQUJc89uSxX2v3IcwFzbJAKlTv3
	 B66qur4u1DEGQ==
Message-ID: <sashiko-outbox-174054@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: libata: Add debug dump around error handling and
 link resets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Junxian Huang" <huangjunxian6@hisilicon.com>, linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20261016085657.3703353-1-huangjunxian6@hisilicon.com>
References: <20261016085657.3703353-1-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 09:07:08 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] libahci: unmapped MMIO reads cause Data Abort on ARM platforms
- [Low] ata: missing ahci_dump_softreset_done() on softreset error path
--

commit 6261261e408a96bdca27f7aab27ae104e6a98735
Author: Junxian Huang <huangjunxian6@hisilicon.com>

ata: libata: Add debug dump around error handling and link resets

Add a generic debug_dump() operation to struct ata_port_operations so LLDDs
can dump their own controller debug state around error handling. For the
standard AHCI driver, implement this hook to dump the AHCI controller
registers through tracepoints.

> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 08ab56e955662..4e1a327d8e680 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c

[ ... ]

> @@ -1457,6 +1463,49 @@ static int ahci_exec_polled_cmd(struct ata_port *a=
p, int pmp,
>  	return 0;
>  }
> =20
> +#define AHCI_DUMP_FN(site)					\
> +static void ahci_dump_##site(struct ata_link *link)		\
> +{								\
> +	struct ahci_host_priv *hpriv =3D link->ap->host->private_data; \
> +	void __iomem *port_mmio =3D ahci_port_base(link->ap);	\
> +	int i;							\
> +								\
> +	if (trace_ahci_global_##site##_enabled()) {		\
> +		u32 global_regs[AHCI_TRACE_GLOBAL_REGS];	\
> +								\
> +		for (i =3D 0; i < AHCI_TRACE_GLOBAL_REGS; i++)	\
> +			global_regs[i] =3D readl(hpriv->mmio + i * 4); \

[Severity: High]
Does blindly reading global registers beyond implemented standard offsets
trigger bus errors on many ARM platforms?

On embedded ARM platforms using libahci, the AHCI IP is mapped on an AXI/AHB
bus which will commonly respond with a DECERR or SLVERR when accessing
unmapped, reserved, or unimplemented vendor-specific offsets.

This translates to an asynchronous SError or synchronous Data Abort excepti=
on,
causing a kernel panic when the tracepoint is enabled. Additionally, reading
vendor-specific registers without knowing their semantics can trigger
read-to-clear or state-altering side effects.

> +								\
> +		trace_ahci_global_##site(link, global_regs);	\
> +	}							\
> +								\
> +	if (trace_ahci_port_##site##_enabled()) {		\
> +		u32 port_regs[AHCI_TRACE_PORT_REGS];		\
> +								\
> +		for (i =3D 0; i < AHCI_TRACE_PORT_REGS; i++)	\
> +			port_regs[i] =3D readl(port_mmio + i * 4); \

[Severity: High]
Similarly, can blindly reading port registers up to offset 0x7C risk
accessing unimplemented offsets, causing SError or Data Abort on ARM?

> +								\
> +		trace_ahci_port_##site(link, port_regs);	\
> +	}							\
> +}

[ ... ]

> @@ -1530,6 +1581,8 @@ int ahci_do_softreset(struct ata_link *link, unsign=
ed int *class,
>  	if (fbs_disabled)
>  		ahci_enable_fbs(ap);
> =20
> +	ahci_dump_softreset_done(link);
> +
>  	return 0;
> =20
>   fail:
>  	ata_link_err(link, "softreset failed (%s)\n", reason);
>  	return rc;
>  }

[Severity: Low]
Is the tracepoint ahci_dump_softreset_done() missing in the error path?

If ahci_do_softreset() encounters an error and jumps to the fail label,
ahci_dump_softreset_done() is not emitted. This results in unbalanced trace
events and loses valuable hardware debug state right when it is most needed
to debug the failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016085657.3703=
353-1-huangjunxian6@hisilicon.com?part=3D1
