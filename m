Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BD321ABAA
	for <linux-ide@vger.kernel.org>; Mon,  1 Jun 2026 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780342329; cv=none; b=pZFcFWJl9CjK11EbxQd1M3+de8//zhaDPxr2wb7oodL6fY/OcjfdffNSAG+iA8kWtbgytA2KbSwYys8ojOaGoR48uwkpdZPyPs+XDQ2tNfF3fbHu836rybCM7ErrQMmHyGBPldTUDER5mWAOlhPDY1i0qNKGAp6076fJm1zTeqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780342329; c=relaxed/simple;
	bh=Wp0B3+3fCLWSj49aI6E5/fl2rJAfHmpXpVEIZYCwJtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nZc+pOpVPQ+jx/Io4CnH8eHN8XCqvj/50rYUOEkrLxrT/6VxdT1FUIrQSNM12QzV6a/Pb+Y/Umdbg69aKdf2rVkdwymoPdWjgV54jo4FSofsvsialY/rs5j0YwRXVvEtr2LCYJMkJNTIZT5olDUhxwV3PByJ4s4qu8GtkLIxoGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVsY3yyC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVsY3yyC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA1B1F00893;
	Mon,  1 Jun 2026 19:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780342328;
	bh=Ma6tR/TLt5VTcUnjyCDwFJPJmU1AqTYde5ZJ7ElernU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VVsY3yyCE8GDSLJMlyPgGa8ux+coconNbn19ew/rth4If5yqODfFr7r0UBq6N0ccf
	 FVFYt4KzPET/6PiLs0JMolY7cVqARzFGYEBPt/Cykm/g+rG7eg1410KDDz6UJwIsma
	 nbhKnJp56VvKRhidSAf6lTHpmQt0CfwQEzmM0L8AdvFIw041PA3htRA/G87nlP9HXC
	 uBr2BXpsAciY5FWCVTL5zwt2qwKWCAGobdpAiJiwxdhRq0y1YcVH7RO5WFEpaogm9c
	 6umN/qSLf0NrUoVQlZHcYpnAUOZ6FwKDX3LkcFw3SjRbHNijA9qUbu4IUcTQc7PKJp
	 WN2ydMOfAvmRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: pata_ep93xx: fix incorrect return value in
 data_xfer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20260601192109.21262-1-rosenp@gmail.com>
References: <20260601192109.21262-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 19:32:07 +0000
Message-Id: <20260601193208.0CA1B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The patch returns `buflen` instead of the actual number of bytes c=
onsumed from the device hardware, causing ATAPI PIO transfers with odd byte=
 counts to fail.
- [Low] The `words++` statement is left behind as dead code.

Pre-existing issues:
- [High] The fallback path for odd-length trailing bytes incorrectly assign=
s 16-bit values to an 8-bit pointer, breaking big-endian systems due to end=
ianness swapping and data truncation.
--

commit a4f8c7ea905bbd7b345d74a2225d1a93448d03c1
Author: Rosen Penev <rosenp@gmail.com>

ata: pata_ep93xx: fix incorrect return value in data_xfer

This patch modifies ep93xx_pata_data_xfer() to return buflen instead of the
shifted words counter. It aims to fix an underflow from 0 to UINT_MAX on ex=
it
when managing scatter-gather progress for ATAPI PIO transfers.

> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c
[ ... ]
>  	/* Transfer trailing 1 byte, if any. */
>  	if (unlikely(buflen & 0x01)) {
>  		unsigned char pad[2] =3D { };
> =20
>  		buf +=3D buflen - 1;
> =20
>  		if (rw =3D=3D READ) {
>  			*pad =3D cpu_to_le16(
>  				ep93xx_pata_read_data(
>  					drv_data, IDECTRL_ADDR_DATA));

[Severity: High]
This is a pre-existing issue, but does assigning the 16-bit result of
cpu_to_le16() to the 8-bit *pad cause data truncation and endianness bugs
on big-endian systems?=20

It looks like the fallback path for odd-length trailing bytes might need a
cast to extract the correct byte.

>  			*buf =3D pad[0];
>  		} else {
>  			pad[0] =3D *buf;
>  			ep93xx_pata_write_data(drv_data, le16_to_cpu(*pad),
>  					  IDECTRL_ADDR_DATA);
>  		}
>  		words++;

[Severity: Low]
This isn't a regression, but since the return statement below no longer uses
the words variable, does this words++ statement become dead code?

>  	}
> =20
> -	return words << 1;
> +	return buflen;

[Severity: High]
Does returning the unrounded buflen instead of the actual number of bytes
consumed from the hardware cause a regression where __atapi_pio_bytes()
under-decrements its remaining byte count?

If buflen is an odd number, returning buflen instead of the rounded hardware
byte count could trigger an extra unintended read cycle and subsequent HSM
errors for ATAPI PIO transfers. Should this return the consumed bytes round=
ed
to the hardware transfer size instead?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601192109.2126=
2-1-rosenp@gmail.com?part=3D1
