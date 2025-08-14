Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B3A1E8335;
	Thu, 14 Aug 2025 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181966; cv=none; b=gBodVNu7hbHsTQd+z7JU9cqWbZxTmRI88ybj+ygQxjsopr+4ww3BWxLCI0WalDK+9SH7tltOFR2ObicMBrTuItRvXf+Q23QbfUzyHpQo24hoVndF+xI2+GDBfU8VhuNqQncCNeSLOZ31Aaj6nub+a/cPFBS5o2W8EbjpMdXT7os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181966; c=relaxed/simple;
	bh=2YgBYu0tho6+NwLlDqBIcjwF8u4K+m2ays0gRmPyQKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdP5lvkK9sBa73M4EIR3vYtCjd9KFB9TJyAo7ehET+gYVQQywo7k/ucRkcZZB8a0ghwPzkBCuiWlUxNsvAIDYRIBNiv8alhWjRRdPzw1gAna3PekxOnUb7LzA+rKjFQFfGUMfjkvScK4JAghBRSU9CtfuTXPAv7DBqG+QT7yx7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gnl9jsm6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gnl9jsm6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D273AC4CEED;
	Thu, 14 Aug 2025 14:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755181965;
	bh=2YgBYu0tho6+NwLlDqBIcjwF8u4K+m2ays0gRmPyQKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gnl9jsm6Xus63Y0SCB/oxV5NkcCTq9ft8Fuo/O44twup8m1YNTvdAUVXmssbIpeOh
	 gg7Y15u+IFfCrDD4kNWuEwEdy5WAPxsMeabPJsRhoJlsmDgeq/hTOH/YkZByslv7dJ
	 KLCTtVP8faTK8IGCCsYYNgSTw9zyZI8uS9t2BMpVWlgeDDxFAM21jiEnxHUj7GlYCb
	 qKXPXQT5e3BgdAuiksK4gqWzCFAg8POUedn5Lb2cyLJxGuNl/XyvUwwN3FJwogPK0W
	 Jx7ly2bnvImgiMeMvjzyGpOqpj92VZZYGKqXDfWGOoIv8YoE7nnuesWte46Qqh41pk
	 HVen4J/VvZoDw==
Date: Thu, 14 Aug 2025 16:32:40 +0200
From: Niklas Cassel <cassel@kernel.org>
To: luyulin@eswincomputing.com
Cc: hehuan1@eswincomputing.com, dlemoal@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, Serge Semin <fancer.lancer@gmail.com>
Subject: Re: Re: [PATCH v1 1/2] dt-bindings: sata: eswin: Document for
 EIC7700 SoC
Message-ID: <aJ3ziEwmGF-KLPuT@ryzen>
References: <20250515085114.1692-1-hehuan1@eswincomputing.com>
 <20250515085723.1706-1-hehuan1@eswincomputing.com>
 <aCXPL8m0OjEOI_q9@ryzen>
 <2630d08e.133.198a7fe5583.Coremail.luyulin@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2630d08e.133.198a7fe5583.Coremail.luyulin@eswincomputing.com>

Hello Yulin,

On Thu, Aug 14, 2025 at 05:51:59PM +0800, luyulin@eswincomputing.com wrote:
> Thank you very much for your constructive suggestions. Based on your advice,
> I have optimized both the driver and the YAML program.
> I sincerely apologize for the delayed response to your suggestions.

No need to apologize for anything :)


> > The good news is that snps,dwc-ahci-common.yaml has defined and documented
> > all the SATA clocks and resets for your board already (a lot of them which
> > you missed to include in this binding).
> > 
> > 
> > Looking quickly at:
> > eswin,hsp_sp_csr = <&hsp_sp_csr 0x1050>;
> > 
> > I can't help to wonder if these regs shouldn't be in a SATA PHY binding
> > instead.
> > 
> > Do e.g. a
> > $ git grep -A 20 snps,dwc-ahci arch/
> > 
> > There are multiple examples that use a PHY driver.
> > 
> > If you were to implement a PHY driver, it is possible that you would
> > not need to create a new (AHCI) DT binding at all, you could probably
> > just add your compatible string to snps,dwc-ahci.yaml, as (from a quick)
> > glance, all the only platform specific things appear to be PHY related.
> > 
> Thank you very much for your expert advice. I have already implemented a 
> independent PHY driver, while the controller driver utilizes ahci_dwc.c.
> Due to our hardware platform's SATA controller has specific constraints on clock, reset
> and port resources, I think adding these to snps,dwc-ahci.yaml might compromise its readability.
> Following reference implementations from other vendors in the Linux kernel, 
> such as rockchip,dwc-ahci.yaml, amlogic,axg-pcie.yaml and others, I plan to create 
> a new eswin,eic7700-ahci.yaml to describe these specifications.
> Based on your professional experience, would you consider this approach acceptable?

That sounds like a good approach.

When you create your device tree binding, make sure to reference
snps,dwc-ahci-common.yaml, like the other DWC based bindings:

$ git grep snps,dwc-ahci-common.yaml
baikal,bt1-ahci.yaml:  - $ref: snps,dwc-ahci-common.yaml#
baikal,bt1-ahci.yaml:    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
rockchip,dwc-ahci.yaml:    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
rockchip,dwc-ahci.yaml:  - $ref: snps,dwc-ahci-common.yaml#
snps,dwc-ahci.yaml:  - $ref: snps,dwc-ahci-common.yaml#
snps,dwc-ahci.yaml:    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port


Kind regards,
Niklas
