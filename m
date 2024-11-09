Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995FE2556E;
	Sat,  9 Nov 2024 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731173808; cv=none; b=H0fJoXsfFhzCQuebyk2FNz4LzEjkbMIDVXbqQNwhV5Mf1OYNB7JzSk5TSbegePrxyONslOsyb/GQ+vQV1lkmssV4x3/h2w4/kZ3NY1vducECkk8LfkzT+9nvZWZkl6f8YMng60Z5Uz9tKtzlu8cWV0iQ5wMGpt37S8X3TU6JkPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731173808; c=relaxed/simple;
	bh=3yK5uP+l1xtcsFycTQzkX6L/0OY+HBh3mJB4rik6Ejg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdxHiJfxT30pFzq1myj/cM4Dzng6E9K1Wkomn9RPpZn1abRHYl4ZIu6VuS5IEj9spOBXahVlgGOk7QPjtHfVbnKEGhz7RUcrcrXw2+r1queL7ziUJc+BLasq/HQFscluAChUx9WOzJabeUv6kq2T+jKIap6TJ0HBMec54Eqyt94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vwQyx+gO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vwQyx+gO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5j6N2GfwM0DWuezOn15oAIWbQPAkiq52COZeaHaZpXY=; b=vwQyx+gO1Ctrky2nufryxOGbT5
	8ejaygT8tjwhbbBOF/WGpsYVMC+ogN7C1iptHjs1PGJrab1xVqXhEfoXrlSaayiUO0QPkDFG2Y3Mc
	TYqYHfZVbFTuIMl0BOURW5qX3jA8eAxIeo+2JwnAGE9mfnzlkqU0/vJca40wN9IY5tfo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t9pO2-00Cipg-HA; Sat, 09 Nov 2024 18:36:38 +0100
Date: Sat, 9 Nov 2024 18:36:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Wunderlich <frank-w@public-files.de>,
	Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 3/3] dt-bindings: ata: ahci-platform: add missing
 iommus property
Message-ID: <be981cc0-58ec-44f2-9874-286960cf0e56@lunn.ch>
References: <20241109094623.37518-1-linux@fw-web.de>
 <20241109094623.37518-4-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109094623.37518-4-linux@fw-web.de>

On Sat, Nov 09, 2024 at 10:46:21AM +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> fix dtbs_check errors in following files:
> 
> arch/arm64/boot/dts/marvell/armada-7040-db.dtb: sata@540000:
> arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dtb: sata@540000:
> arch/arm64/boot/dts/marvell/armada-8040-db.dtb: sata@540000:
> arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtb: sata@540000:
> arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dtb: sata@540000:
>   Unevaluated properties are not allowed ('iommus' was unexpected)
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
