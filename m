Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7463D305E10;
	Mon, 22 Sep 2025 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557501; cv=none; b=svLuv7SsPYha2SGhIpOAVu8c9d2+/ziLHMFrsr9Pc4BAMDW82CSFaaYHseBJDrExBubJ8Rsjg4VC/swU+AheDYaQVFo/G0fVtOYVvZgmF6BOoVbehLfvZgyxLdFpzr/VYDTiOoOoyHXHBlrWYqNMsskv7pX3ZD6gkKV3VdMv2BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557501; c=relaxed/simple;
	bh=Y4dexsKXHeZk//jfbzy1vNcOZEXCwdx3La8z6nNKwJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6Xnnub+T20EeLW+Lgc/BD8PJr+gwORyEdX7jzVWob5PeoA/YF7+UmFTHIAHeMABbznj/dLyCngmM5xUTEdvJwGrUG2+OFGum8SxHifcKJx2WSbHZF9lZbLDWCUxEuBSwNMi7aM19cTEFLN5rpvelzkf7Fo7/hH/HpEcynZ6RNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svBdbWtE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svBdbWtE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C796BC4CEF0;
	Mon, 22 Sep 2025 16:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758557501;
	bh=Y4dexsKXHeZk//jfbzy1vNcOZEXCwdx3La8z6nNKwJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=svBdbWtEwjtojsDy0C1kWGJQszMlj2jH0sgM1mMyVwDa5OsQD0H33HzwybTdErCJG
	 rd6an1Ed4ucvaB5lNn3KWy8u9IMr5kTwOYDYtI8Ka1yf/BbcIlk98eyeGIfBtXx7mc
	 8I5EvQ4Go2uJ6P/JNtdiGPMpVMEk95RtIZiC0iseMd7fdJar+RWenXmTYvEOWUEXNg
	 eFevYjCvM2kz2YA4QQZx1ZqsK2y7dfV5Xbjg+5E0dwGSjBRcRQoZ2ANbVzELDC9j9N
	 fm+hN8urMOx0V79vPzer8q8havNkrk945eYN2Yuz1tOFL5oJnrLS7qHlJ6FMVtlIlM
	 yfVwRjk3XVSsQ==
Date: Mon, 22 Sep 2025 11:11:40 -0500
From: Rob Herring <robh@kernel.org>
To: Yulin Lu <luyulin@eswincomputing.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	vkoul@kernel.org, kishon@kernel.org, linux-phy@lists.infradead.org,
	ningyu@eswincomputing.com, zhengyu@eswincomputing.com,
	linmin@eswincomputing.com, huangyifeng@eswincomputing.com,
	fenglin@eswincomputing.com, lianghujun@eswincomputing.com
Subject: Re: [PATCH v4 1/3] Document the EIC7700 SoC sata ahci
Message-ID: <20250922161140.GA150852-robh@kernel.org>
References: <20250915125902.375-1-luyulin@eswincomputing.com>
 <20250915130135.1497-1-luyulin@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915130135.1497-1-luyulin@eswincomputing.com>

On Mon, Sep 15, 2025 at 09:01:35PM +0800, Yulin Lu wrote:
> Document the SATA AHCI controller on the EIC7700 SoC platform,
> including descriptions of its hardware configurations.

Please fix the subject: "dt-bindings: ata: ..."

> 
> Retains the "ports-implemented" property in the DTS, because
> removing it and relying only on the firmware register causes
> problems. If the property is not present and we remove the
> module using `rmmod`, a reset is triggered that clears the
> register. As a result, inserting module again using `insmod`
> will lead to errors.
> 
> The detailed reasons are that the ports-implemented register is
> configured by the firmware (U-Boot on the HiFive Premier P550 board)
> before kernel entry and correctly set to 0x1. During probe,
> ahci_platform_enable_resources() -> ahci_platform_deassert_rsts() is
> called, and when the driver is removed,
> ahci_platform_disable_resources() -> ahci_platform_assert_rsts() is
> called. This reset clears the register, which is defined by the IP
> databook to reset to 0.
> 
> Signed-off-by: Yulin Lu <luyulin@eswincomputing.com>
> ---
>  .../bindings/ata/eswin,eic7700-ahci.yaml      | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/eswin,eic7700-ahci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/eswin,eic7700-ahci.yaml b/Documentation/devicetree/bindings/ata/eswin,eic7700-ahci.yaml
> new file mode 100644
> index 000000000000..40c44f0705ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/eswin,eic7700-ahci.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/eswin,eic7700-ahci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Eswin EIC7700 SoC SATA Controller
> +
> +maintainers:
> +  - Yulin Lu <luyulin@eswincomputing.com>
> +  - Huan He <hehuan1@eswincomputing.com>
> +
> +description:
> +  AHCI SATA controller embedded into the EIC7700 SoC
> +  is based on the DWC AHCI SATA v5.00a IP core.

Wrap at 80 chars.

> +
> +select:
> +  properties:
> +    compatible:
> +      const: eswin,eic7700-ahci
> +  required:
> +    - compatible
> +
> +allOf:
> +  - $ref: snps,dwc-ahci-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: eswin,eic7700-ahci
> +      - const: snps,dwc-ahci
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: aclk
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: arst
> +
> +  ports-implemented:
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - phys
> +  - phy-names
> +  - ports-implemented
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sata@50420000 {
> +        compatible = "eswin,eic7700-ahci", "snps,dwc-ahci";
> +        reg = <0x50420000 0x10000>;
> +        interrupt-parent = <&plic>;
> +        interrupts = <58>;
> +        clocks = <&clock 171>, <&clock 186>;
> +        clock-names = "pclk", "aclk";
> +        phys = <&sata_phy>;
> +        phy-names = "sata-phy";
> +        ports-implemented = <0x1>;
> +        resets = <&reset 96>;
> +        reset-names = "arst";
> +    };
> -- 
> 2.25.1
> 
