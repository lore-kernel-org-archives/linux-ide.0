Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B8A1B0406;
	Wed,  8 Jan 2025 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736324764; cv=none; b=efA+acvSUpKa/LV2GZRcCbrDbO0JCo++Dwz095diwI/HiAPhXSRU2IV22QSf0MC7SI04I4hPiJCtXe+GPhU2glfFTwcQfLIleCaiWWKuVMN/LIjeBqW5cuo/KfvAOL5RXgbJfHkTyg37+mk9sXNI2coML0pNehIoll04tf3dBXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736324764; c=relaxed/simple;
	bh=NDG2KeLlWgwUT6yDm82X1pskaaj/DUwvk+AiNyRd/9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tsYx3v9NIND8YCv1Jwan24eNOcEqy7Wv8HHkM62jk3PZBIpYexmFBOut9aCcIP6m6QTfDS0lIDDn2nm51toZmOjj2+HKRIMU0eVk60eX8Fu+k7Lbmm4njO16LRl9hiiKqtpEmVUY7joL37oVd0Flgmlc1t/Oqwm8GtjBNy6CSs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Udq4Sjq+; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Udq4Sjq+"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0ABCA1BF203;
	Wed,  8 Jan 2025 08:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736324760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTy7eIsiHi8YdIDbzsIB/Y4+pBc/ZOwxm6JBRN1A8Q0=;
	b=Udq4Sjq+phO2RDT7qIKJv7/RN9LFeWV5i5Guf3z+CBn9p35fcbVsNs2A1JuJ1EH3yvJ/+j
	ErcRnFYiwA03LXPxcuQg7R1gIO/kCq2sz9KYAzyr+iyhjMWKPXKd7DhSsg4cKzyWkfu+6F
	fJ50YlLyURBi5NCjm2GN/bkNatCtm4lFhRHTfkK+tdR2om9BYY8N5mR5OGo4O85X8yTFtb
	XE5KVtEtEfxcMH/EQs66EloGG+U+/dK1XbMBMT9Rq2QI0yCzdvzjL7NYUNF+8aklnZVn/O
	ouJFUci7nmR2sedaC9SiOXpI4zPEfvBX+k9rNs5g7Wv9r8ezu43TIv1vN1vt3g==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Frank Wunderlich <linux@fw-web.de>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: Frank Wunderlich <frank-w@public-files.de>, Hans de Goede
 <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/2] fix some binding check errors for marvell
In-Reply-To: <20250103103724.6223-1-linux@fw-web.de>
References: <20250103103724.6223-1-linux@fw-web.de>
Date: Wed, 08 Jan 2025 09:25:58 +0100
Message-ID: <87ldvlyand.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gregory.clement@bootlin.com

Frank Wunderlich <linux@fw-web.de> writes:

> From: Frank Wunderlich <frank-w@public-files.de>
>
> Thies series fixes some Errors reported by dtbs_check. First part is taken
> from my old series [1] where i converted sata-platform txt binding to yaml
> because it wasn't picked up.
>
> [1] https://lore.kernel.org/linux-arm-kernel/20220311210357.222830-1-linu=
x@fw-web.de/
>
> I only try to fix the binding errors, i do not have any marvell board, so
> cannot verify that my changes are correct. From my PoV peripheral
> controllers should be disabled in the SoC DT and enabled in board DT.
>
> Frank Wunderlich (2):
>   arm64: dts: marvell: only enable complete sata nodes
>   arm64: dts: marvell: drop additional phy-names for sata


Applied on mvebu/dt64

Thanks,

Gregory

>
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts             | 1 +
>  arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts       | 2 ++
>  arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 1 +
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts             | 5 +++--
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi         | 3 +--
>  arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts    | 2 ++
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi              | 2 ++
>  arch/arm64/boot/dts/marvell/cn9130-crb-B.dts               | 1 +
>  arch/arm64/boot/dts/marvell/cn9131-db.dtsi                 | 1 +
>  arch/arm64/boot/dts/marvell/cn9132-db.dtsi                 | 1 +
>  10 files changed, 15 insertions(+), 4 deletions(-)
>
> --=20
> 2.43.0
>

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
