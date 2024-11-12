Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DA13C908;
	Tue, 12 Nov 2024 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415573; cv=none; b=lEOngvzlSrM1t33G/GpzN+nfZLzHOsBMK++doXjXyr9BwUj2mE8Q0XxP/lEv46X/FIl3PUtnDKB7ggxWXD5XT+BMzM+FNzaQziN9A3CwED7dNvUaz84Exqydc4aK+uHvPHbWsKQgaiK0yRI4nxQaXPHs4wkeV4b/T0HSKgDgGFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415573; c=relaxed/simple;
	bh=nMAsToNIcVM8JoD6fxjSGbyscGJjSG2b6I49R2ndqy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX8DO/K9gsZm0OcTX4zWPaO2ogbtp3jKRqESM2Jot64/OA1qoo/hbBib5HYkcxnP9eT+SkrbE+JQvnZzTYxoWXkcDqzIm+3FSwHfVhZhynT5iGsi9kefOcQ9Ic+09Be46o/QEaQCe69AwVdSmS99xhH47yynX1rUcVyGc06Vmeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck8YQQJV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck8YQQJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFECC4CECD;
	Tue, 12 Nov 2024 12:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731415573;
	bh=nMAsToNIcVM8JoD6fxjSGbyscGJjSG2b6I49R2ndqy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ck8YQQJVavF0HxwsvFfVoCb4+GhgMju3ccWHOYSso34WQ689bu3iMeMOcfxa1pHWR
	 /MubC0TWmb/xSzcfnl61EjLghyo+YXana+m0D/HM8cd3bvXXb2vu/BDrd+oVsC+KHa
	 jiXYA9H7yIXtvJsUesu760tX3deoUxoLGsEVR+L2g7n50CElVCjuuccxO9WLFmFJSs
	 xrOY7e003xZ+gVeOOTEm1QChAmTa5jbz1UWaquiScIYYbTCtfnQh3owMTmhkOHgpAz
	 Z6CYgzkEPXJfGTi9iFXsIFmraH5JKb4Sw71hkvr+gZ4EOCPgCiMln6Et0HsoaICOCP
	 +uJj/KsZ/5FYQ==
Date: Tue, 12 Nov 2024 13:46:07 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: frank-w@public-files.de, Andrew Lunn <andrew@lunn.ch>,
	Frank Wunderlich <linux@fw-web.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/3] arm64: dts: marvell: Fix anyOf conditional failed
Message-ID: <ZzNOD_dpK0e4WFLL@ryzen>
References: <20241109094623.37518-1-linux@fw-web.de>
 <20241109094623.37518-2-linux@fw-web.de>
 <e534c723-6d65-433f-8ab5-1c0d424d7367@lunn.ch>
 <9B1A5D20-3DE5-40C1-8B2D-B1C4F53FA5F4@public-files.de>
 <CAL_JsqJnOa_9Poz86vOWBCQigvv-Ab4Tt1hrwTxSa5zNraVxXQ@mail.gmail.com>
 <ZzNL4_dFxHfMmMcR@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzNL4_dFxHfMmMcR@ryzen>

On Tue, Nov 12, 2024 at 01:36:51PM +0100, Niklas Cassel wrote:
> On Mon, Nov 11, 2024 at 10:25:12AM -0600, Rob Herring wrote:
> > > >
> > > >I don't know the yaml too well, but it is not obvious how adding a few
> > > >status = "disabled"; status = "okay"; fixes a "'anyOf' conditional failed".
> > > >
> > > >Maybe you can expand the explanation a bit?
> > > >
> > > >       Andrew
> > >
> > > Hi angelo,
> > >
> > > I guess the dtbs_check only checks required properties from yaml if the node is enabled.
> > 
> > Yes, that is exactly how it works.
> > 
> > Rob
> 
> Hello Rob,
> 
> If we look at e.g. this binding:
> Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> 
> We can see that it does not define iommu-map in the binding,
> likewise the binding does have:
> unevaluatedProperties: false
> 
> 
> If I apply my patch that adds iommu-map for e.g. the pcie2x1l0 node:
> (the patch does not add anything to the binding above):
> https://lore.kernel.org/linux-rockchip/20241107123732.1160063-2-cassel@kernel.org/
> 
> 
> If look at the pcie2x1l0 node, it is marked as status = "disabled"
> in arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
> 
> but is marked as status = "enabled"
> in arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> 
> If I run CHECK_DTBS for this dts/dtb:
> $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CHECK_DTBS=y rockchip/rk3588-rock-5b.dtb
>   DTC [C] arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb
> $ 
> 
> No warnings.
> 
> What am I missing?
> 
> Considering the warning in this series where the binding also
> had unevaluatedProperties: false
> I would have expected the same error for the pcie2x1l0 node.
> 
> (And if I look at most PCI controler bindings, they actually do define
> iommu-map, so it seems a requirement for it to be defined if used.)
> 

Or perhaps the question should have been, if iommu-map is an exception,
why isn't iommus also an exception?


Kind regards,
Niklas
