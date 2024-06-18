Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B599B158216;
	Tue, 18 Jun 2024 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703871; cv=none; b=RSSlxhVrCXMDy8BQ1JbygOA2qCFUNasTN07dGndqxEdUjZEW37/9LEiMOr1OKz+8d2uiN799QMcCuDvYuvD7teYXjb6rsr+toxhFxQO5x4XYBZSlDyvc1bx1zNezy2mY+Df5O/bwmMB83dYL/hQB/+cOn5Vs8OKlLQ8YivW9HZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703871; c=relaxed/simple;
	bh=3oAxYZunFcgJip6AK4A73PGRCJ7aIiU6dscSL48J7rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSmagKrvY3w5YG5PQVxYWFd5O/q9pWgR4WN3ArVwYtY6JW2cvBb05SQNTpaekypdYwC3uY+k43pG4IzM813CjoNptH1lbGjzgVfrOZTzjnzpYHjZjyvR0TGUE9KBlVwz0Sfvh107IzKFy/WIn2IhiXvydqw3OmqT9n+jyd/ZGdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZTdiwBh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZTdiwBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F6AC3277B;
	Tue, 18 Jun 2024 09:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718703871;
	bh=3oAxYZunFcgJip6AK4A73PGRCJ7aIiU6dscSL48J7rY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZTdiwBhX+9KSjDhSjnNqL+CrDUhMwCPPBpLP36PtsBK7q2iOrR5ViF+3jku6yg/t
	 uXc46+MI3Z/s7cd2VtKfwtQU7w/ZcTa2gLR44n8btdWUVD1EW0Qc6cbLBgHIgJv4Mr
	 8Bf9OxOL9kH6X3E+i96C/xs23kox4bl62v2a46hC2EqWGYXxxnEvff3gJzJiO/3rIA
	 FDwQpE7jNnt+aJIof4HrtmVDIOkEWO1eT6uYtQwpfSh0uw3FcIx6YpiazJXNtmE8BJ
	 HGMd4EXJ79ktmuBgko1M4nh8G77tpLnEM1oeCcXsgoGAj9XVTbqEmwUqXbDlbYrB1n
	 mMf1oT9CpfMSA==
Date: Tue, 18 Jun 2024 11:44:25 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: ata: ahci-fsl-qoriq: convert to yaml
 format
Message-ID: <ZnFW-d1ktgWTZutZ@ryzen.lan>
References: <20240617180241.901377-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617180241.901377-1-Frank.Li@nxp.com>

On Mon, Jun 17, 2024 at 02:02:40PM -0400, Frank Li wrote:
> Convert ahci-fsl-qoirq DT binding to yaml format.
> 
> Additional changes:
> - Add reg-names list, ahci and sata-ecc
> - Add fsl,ls1028a-ahci and fsl,lx2060a-ahci
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/ata/ahci-fsl-qoriq.txt           | 21 -------
>  .../devicetree/bindings/ata/fsl,ahci.yaml     | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
> deleted file mode 100644
> index 7c3ca0e13de05..0000000000000
> --- a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -Binding for Freescale QorIQ AHCI SATA Controller
> -
> -Required properties:
> -  - reg: Physical base address and size of the controller's register area.
> -  - compatible: Compatibility string. Must be 'fsl,<chip>-ahci', where
> -    chip could be ls1021a, ls1043a, ls1046a, ls1088a, ls2080a etc.
> -  - clocks: Input clock specifier. Refer to common clock bindings.
> -  - interrupts: Interrupt specifier. Refer to interrupt binding.
> -
> -Optional properties:
> -  - dma-coherent: Enable AHCI coherent DMA operation.
> -  - reg-names: register area names when there are more than 1 register area.
> -
> -Examples:
> -	sata@3200000 {
> -		compatible = "fsl,ls1021a-ahci";
> -		reg = <0x0 0x3200000 0x0 0x10000>;
> -		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&platform_clk 1>;
> -		dma-coherent;
> -	};
> diff --git a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> new file mode 100644
> index 0000000000000..162b3bb5427ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/fsl,ahci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale QorIQ AHCI SATA Controller
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,ls1021a-ahci
> +      - fsl,ls1043a-ahci
> +      - fsl,ls1028a-ahci
> +      - fsl,ls1088a-ahci
> +      - fsl,ls2080a-ahci
> +      - fsl,lx2160a-ahci
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: ahci
> +      - const: sata-ecc
> +    minItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  dma-coherent: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    sata@3200000 {
> +        compatible = "fsl,ls1021a-ahci";
> +        reg = <0x3200000 0x10000>;
> +        interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&platform_clk 1>;
> +        dma-coherent;
> +    };
> -- 
> 2.34.1
> 

Applied:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.11
