Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B088430CDAD;
	Thu, 28 Aug 2025 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386321; cv=none; b=p9fZGcT6cMOYBgqS5rwJSvQmKjls+10UgkUBBxUAfOHbt/GO6CzhNC9sE8A7tFaesmKVOqW0XKPqTmeJSUKvPvhd/Dj/giKdwNOAGGst2ak/egjv/pOEOGzDJumh7K4BDUxHJzKKEg/Ek9KECElSMN6WwdPYgk2WajWkN8CcKMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386321; c=relaxed/simple;
	bh=BedeSX6voxwyyiBkw/RxXqgNPm+x0uuYoTCufQq9ggg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnCaiGNoWTQXQTSi1G/QaLCTyZpU7mA/6hQ9Afa2SJkhVCnLU576KF9M9zETI0fYIoFGxJvkgr2pWXJ3h7S9WK5T61kSYzSBj5EIBZPuHSDhtuIOPQdTC0y0v3jfl8d2euXRRRixPWtrJNizJM83Fw5z/r79pQV/RdO+W20+R7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igaE5j1l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igaE5j1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62EDC4CEEB;
	Thu, 28 Aug 2025 13:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756386321;
	bh=BedeSX6voxwyyiBkw/RxXqgNPm+x0uuYoTCufQq9ggg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=igaE5j1l6RWotK5a9EajP17I9IsRNbqwKA9XvkfQgq0q/PavboD+UJFrIgrb1Gv0Q
	 As4EmCqHCKhV6hQG85S+HGA/lnfO6Y4R6EZ5NiGhJtzSF41G1eqGCLNBmGA9/5kiAl
	 wi1vYQooMJRxl0PQRYMjzvXwR69om/x92gYCGRM29rOJkHBGxGpzOZhi3hDzMDsBWg
	 BATQZqKITtTHOMBY6AZiHcCdPTp2P0E1nF0nUWLXxGxKQz0Cq8vdfsFadZi3vKQapx
	 mNbvtDPfNa1eJZNJufw6mzevxPcAyO1N5Qp7bJGgUxyX3W8Gh7xRnGbmSzLoAMH9Z6
	 3jThBmSmixN5g==
Date: Thu, 28 Aug 2025 15:05:15 +0200
From: Niklas Cassel <cassel@kernel.org>
To: luyulin@eswincomputing.com
Cc: Rob Herring <robh@kernel.org>, dlemoal@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	vkoul@kernel.org, kishon@kernel.org, linux-phy@lists.infradead.org,
	ningyu@eswincomputing.com, zhengyu@eswincomputing.com,
	linmin@eswincomputing.com, huangyifeng@eswincomputing.com,
	fenglin@eswincomputing.com, lianghujun@eswincomputing.com
Subject: Re: Re: [PATCH v2 1/3] dt-bindings: ata: eswin: Document for EIC7700
 SoC ahci
Message-ID: <aLBUC116MdJqDGIJ@flawful.org>
References: <20250819134722.220-1-luyulin@eswincomputing.com>
 <20250819135413.386-1-luyulin@eswincomputing.com>
 <CAL_JsqKFotNLZZXwiy7S6K8qXLdGRAnsa-1zvZRDQBE39Gf5kg@mail.gmail.com>
 <692e11ca.843.198f0337528.Coremail.luyulin@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <692e11ca.843.198f0337528.Coremail.luyulin@eswincomputing.com>

On Thu, Aug 28, 2025 at 06:22:40PM +0800, luyulin@eswincomputing.com wrote:
> 
> Do you mean that ports-implemented should be removed from the dts,
> and the corresponding register should be configured by the firmware
> (which is U-Boot on the HiFive Premier P550 board)? Is this understanding correct?
> If so, when the driver is removed, a reset will be triggered,
> causing the configuration of this register to be lost,
> which will result in an error when insmod the driver again.

My 50 cents,

if the ports implemented register gets reset from the reset_control_reset()
in ahci_platform_assert_rsts(), then it seems like having ports-implemented
in device tree is acceptable.

There are a bunch of device trees that have this already:
arch/arm/boot/dts/qcom/qcom-apq8064.dtsi:                       ports-implemented = <0x1>;
arch/arm/boot/dts/qcom/qcom-ipq8064-v1.0.dtsi:                  ports-implemented = <0x1>;
arch/arm/boot/dts/qcom/qcom-ipq8064-v2.0.dtsi:  ports-implemented = <0x1>;
arch/arm/boot/dts/samsung/exynos5250.dtsi:                      ports-implemented = <0x1>;
arch/arm/boot/dts/socionext/uniphier-pro4.dtsi:                 ports-implemented = <1>;
arch/arm/boot/dts/socionext/uniphier-pro4.dtsi:                 ports-implemented = <1>;
arch/arm/boot/dts/socionext/uniphier-pxs2.dtsi:                 ports-implemented = <1>;
arch/arm/boot/dts/st/stih407-family.dtsi:                       ports-implemented = <0x1>;
arch/arm/boot/dts/st/stih407-family.dtsi:                       ports-implemented = <0x1>;
arch/arm/boot/dts/ti/omap/dra7-l4.dtsi:                         ports-implemented = <0x1>;
arch/arm/boot/dts/ti/omap/omap5-l4.dtsi:                                ports-implemented = <0x1>;
arch/arm64/boot/dts/mediatek/mt7622.dtsi:               ports-implemented = <0x1>;
arch/arm64/boot/dts/rockchip/rk3568.dtsi:               ports-implemented = <0x1>;
arch/arm64/boot/dts/rockchip/rk356x-base.dtsi:          ports-implemented = <0x1>;
arch/arm64/boot/dts/rockchip/rk356x-base.dtsi:          ports-implemented = <0x1>;
arch/arm64/boot/dts/rockchip/rk3576.dtsi:                       ports-implemented = <0x1>;
arch/arm64/boot/dts/rockchip/rk3576.dtsi:                       ports-implemented = <0x1>;
arch/arm64/boot/dts/rockchip/rk3588-base.dtsi:          ports-implemented = <0x1>;
arch/arm64/boot/dts/rockchip/rk3588-base.dtsi:          ports-implemented = <0x1>;
arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi:         ports-implemented = <0x1>;
arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi:                       ports-implemented = <1>;
arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi:                       ports-implemented = <1>;


Sure, if the ports implemented register was sticky (kept its value after a
reset), then I think Rob's suggestion would make sense.



Kind regards,
Niklas
