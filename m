Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F173E1A7AFD;
	Mon, 11 Nov 2024 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731354380; cv=none; b=YOOzQXxSXrZr9OLC/IzxW2bR2SR307eyfEE342XZpzQ7HWixpTJdzJI9G1SO9dbR85CaTYLFE6XxPuHrsweoMSQXbWrPYe/Nulm0FHxcfYiXGI7vZ2fU6DOufn6NJH7GRvUenHQIOv6a/hB5MGyRHuukqgV6O9BcXNKfv08+wRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731354380; c=relaxed/simple;
	bh=RTX8JtmfQXicA6NSmzoFj+EWO3qXcohs8dzjns8VwpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBGPevvckC9Dt33xAy1FX8l1sk9XAQ7rXZBSPq41AwFoqVzcLekeesHT8ZpP/Fv7BPFnp4AFSyPPiSYdJDKTMtTl33NmUhHP0TMHOGd5QXDoh5Ljf3ApTo44itEWcLo+HtstRmLXII6Yye8ujFdwBJVZIRjzhuRvusZR7D0TNQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkYuYxdZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkYuYxdZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EBFC4CECF;
	Mon, 11 Nov 2024 19:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731354378;
	bh=RTX8JtmfQXicA6NSmzoFj+EWO3qXcohs8dzjns8VwpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkYuYxdZWNHKM3Tkh62KdVOx8gsraV/by+6vW/t2oO9qo3Rzu32kwu7cfwZxbvvUw
	 V24fkCBzbu3iXCUUNeMhfckeBPIi6odWs1HfRW2QjP7pTGTn8pBX2QO1Mg0h6rYHOS
	 KRsnABD/ktmkV2LzLFNoe1HOGEEMGCb6KQXse81WnCczF56avB/ksVdpjTpS8sFjOZ
	 w2FTlXbN16huJrk+19UmXhRgqNpPRk3YiRsMRbACH+0Mv2v5qw2SWR9t36W1aM7mAo
	 vEUtzoenEcjQLGDtgedzh8vSR/M5ti9BGBpGTJULEO/f6/p6Sr31u1XgWDrLctPuIh
	 npUaEo7b41bKg==
Date: Mon, 11 Nov 2024 19:46:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Wunderlich <frank-w@public-files.de>,
	Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 3/3] dt-bindings: ata: ahci-platform: add missing
 iommus property
Message-ID: <20241111-pasted-primarily-7f665b0b2fa4@spud>
References: <20241109094623.37518-1-linux@fw-web.de>
 <20241109094623.37518-4-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iY8L1hmlHO5MfZf9"
Content-Disposition: inline
In-Reply-To: <20241109094623.37518-4-linux@fw-web.de>


--iY8L1hmlHO5MfZf9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 09, 2024 at 10:46:21AM +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
>=20
> fix dtbs_check errors in following files:
>=20
> arch/arm64/boot/dts/marvell/armada-7040-db.dtb: sata@540000:
> arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dtb: sata@540000:
> arch/arm64/boot/dts/marvell/armada-8040-db.dtb: sata@540000:
> arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtb: sata@540000:
> arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dtb: sata@540000:
>   Unevaluated properties are not allowed ('iommus' was unexpected)
>=20
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--iY8L1hmlHO5MfZf9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzJfBQAKCRB4tDGHoIJi
0kZYAP49wOpCPn1XV1CuML8Mzii0hAR7itUchMtHNweyWK5AEAD/WWr+kQyWWHM7
kPsQBx1TogUJmrldrEIbDvuBrCcWjgE=
=UM60
-----END PGP SIGNATURE-----

--iY8L1hmlHO5MfZf9--
