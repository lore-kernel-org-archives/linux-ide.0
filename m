Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A142C2C9;
	Thu, 15 May 2025 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308340; cv=none; b=g64uf+FAVhRoO1qjmFykV2tRRtPpO9pzXWZSrkgNEh7BXhCh7fQlswJMHCSestXjKPo5FsMhYX3ZdGMNed+k4UUPC0KnyKFY0BSsceWV+hWXQBYO1Mm7GP4Wbe0RJBZ/jxryPIgOMhWXLvpTRELoM/Y5XORrLzcwYucmQsicvk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308340; c=relaxed/simple;
	bh=dwz/u3+zOy3h8MYHRtyeGY65OuHyAgOHZgN6AkWZnhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pg2bmLb9pUusgxR0wCxtKrUTVjKnYa/vCuTNfrBm7HMPJl2NMwgULHDn0sfDQ34N7JLpXIGEWpYGYNE7GsiQeuYTE8dOCTA+vCkDQ3Vstyn0Dkgv/a6MsyJsdhk7f0kuGeXylNdYmxaJAOOV995ayXjm6QGmO4KmzHdPLtQ/StY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF301fk9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF301fk9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E0CC4CEE7;
	Thu, 15 May 2025 11:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747308340;
	bh=dwz/u3+zOy3h8MYHRtyeGY65OuHyAgOHZgN6AkWZnhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bF301fk99/ajvHbrjI0V1mGvhZdznCQ+ov2cubu5JIvBjYPZ4BzOS8cW4H8nIKEuO
	 mBqkE/uMj8e7PaI6YLEzXs5eDic4ynmtt2DMU8Yl408OItlim2lb2hA1tt/jbKdYR0
	 lT16vh+rsH1yDMW5ekxBpiOxPheKJ/qkNk1Vc4xeJznKUrtL2vSHBjesi+mA7H7FQ9
	 0aL8tF+xCIdxymOpZVkGX883C6MYXUwVExMKTJ00Ln6suVuNAnYT1Et0U2lUTIuJqD
	 V/jFfQAMeH89AfbRQAyK6XOxLDPVNBip6CEwTDWUazAD7HRrsduxXZjtUb9ELOaNGG
	 QyycDp2/CF5dw==
Date: Thu, 15 May 2025 13:25:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: hehuan1@eswincomputing.com
Cc: dlemoal@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, luyulin@eswincomputing.com,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: sata: eswin: Document for EIC7700 SoC
Message-ID: <aCXPL8m0OjEOI_q9@ryzen>
References: <20250515085114.1692-1-hehuan1@eswincomputing.com>
 <20250515085723.1706-1-hehuan1@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515085723.1706-1-hehuan1@eswincomputing.com>

Hello Huan He,

On Thu, May 15, 2025 at 04:57:23PM +0800, hehuan1@eswincomputing.com wrote:
> From: Huan He <hehuan1@eswincomputing.com>
> 
> Add eic7700 AHCI SATA controller device with single port support.
> For the eic7700 SATA registers, it supports AHCI standard interface,
> interrupt modes (INTx/MSI/PME), APB reset control,
> and HSP_SP_CSR register configuration.
> 
> Co-developed-by: Yulin Lu <luyulin@eswincomputing.com>
> Signed-off-by: Yulin Lu <luyulin@eswincomputing.com>
> Signed-off-by: Huan He <hehuan1@eswincomputing.com>
> ---
>  .../bindings/ata/eswin,eic7700-sata.yaml      | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/eswin,eic7700-sata.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/eswin,eic7700-sata.yaml b/Documentation/devicetree/bindings/ata/eswin,eic7700-sata.yaml
> new file mode 100644
> index 000000000000..71e1b865ed2a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/eswin,eic7700-sata.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/eswin,eic7700-sata.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Eswin EIC7700 SoC SATA Controller
> +
> +maintainers:
> +  - Yulin Lu <luyulin@eswincomputing.com>
> +  - Huan He <hehuan1@eswincomputing.com>
> +
> +description: |
> +  This binding describes the SATA controller integrated in the Eswin EIC7700 SoC.
> +  The controller is compatible with the AHCI (Advanced Host Controller Interface)
> +  specification and supports up to 1 port.
> +
> +properties:
> +  compatible:
> +    const: eswin,eic7700-ahci
> +
> +  reg:
> +    maxItems: 1
> +    description: Address range of the SATA registers
> +
> +  interrupt-names:
> +    items:
> +      - const: intrq
> +      - const: msi
> +      - const: pme
> +
> +  interrupts:
> +    maxItems: 3
> +    description: The SATA interrupt numbers
> +
> +  ports-implemented:
> +    maximum: 0x1
> +
> +  resets:
> +    maxItems: 1
> +    description: resets to be used by the controller.
> +
> +  reset-names:
> +    const: apb
> +
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 2
> +
> +  eswin,hsp_sp_csr:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: hsp_sp_csr regs to be used by the controller.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-names
> +  - interrupts
> +  - resets
> +  - reset-names
> +  - eswin,hsp_sp_csr
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sata: sata@50420000 {
> +      compatible = "eswin,eic7700-ahci";
> +      reg = <0x50420000 0x10000>;
> +      interrupt-parent = <&plic>;
> +      interrupt-names = "intrq", "msi", "pme";
> +      interrupts = <58>, <59>, <60>;
> +      ports-implemented = <0x1>;
> +      resets = <&reset 7 (1 << 27)>;
> +      reset-names = "apb";
> +      #size-cells = <2>;
> +      eswin,hsp_sp_csr = <&hsp_sp_csr 0x1050>;
> +    };
> -- 
> 2.25.1
> 

I'm surprised that you AHCI controller does not need any clocks ;)


When looking at the EIC7700X TRM:
https://github.com/eswincomputing/EIC7700X-SoC-Technical-Reference-Manual/releases/download/v1.0.0-20250103/EIC7700X_SoC_Technical_Reference_Manual_Part2.pdf

It is obvious that this SoC integrates the DWC AHCI controller.

Thus, I would have expected your DT binding to have a:
$ref: snps,dwc-ahci-common.yaml#

Please have a look at these bindings:
baikal,bt1-ahci.yaml:  - $ref: snps,dwc-ahci-common.yaml#
baikal,bt1-ahci.yaml:    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
rockchip,dwc-ahci.yaml:    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
rockchip,dwc-ahci.yaml:  - $ref: snps,dwc-ahci-common.yaml#
snps,dwc-ahci-common.yaml:$id: http://devicetree.org/schemas/ata/snps,dwc-ahci-common.yaml#
snps,dwc-ahci.yaml:  - $ref: snps,dwc-ahci-common.yaml#
snps,dwc-ahci.yaml:    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port

The good news is that snps,dwc-ahci-common.yaml has defined and documented
all the SATA clocks and resets for your board already (a lot of them which
you missed to include in this binding).


Looking quickly at:
eswin,hsp_sp_csr = <&hsp_sp_csr 0x1050>;

I can't help to wonder if these regs shouldn't be in a SATA PHY binding
instead.

Do e.g. a
$ git grep -A 20 snps,dwc-ahci arch/

There are multiple examples that use a PHY driver.

If you were to implement a PHY driver, it is possible that you would
not need to create a new (AHCI) DT binding at all, you could probably
just add your compatible string to snps,dwc-ahci.yaml, as (from a quick)
glance, all the only platform specific things appear to be PHY related.


Kind regards,
Niklas
