Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163ABC433F5
	for <linux-ide@archiver.kernel.org>; Wed,  2 Mar 2022 09:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiCBJq4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Mar 2022 04:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiCBJqz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2022 04:46:55 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EAC7C7B8
        for <linux-ide@vger.kernel.org>; Wed,  2 Mar 2022 01:46:12 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A9EF33F607
        for <linux-ide@vger.kernel.org>; Wed,  2 Mar 2022 09:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646214370;
        bh=lAb27ZgFQOByFHIClEAhJ0N2dL6QzOfjA77CIlXGrDU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=B25LnxqX/lcmJNbbqGSPkysCv4EId/i356TC0RntzrEaLkLXtsw1Doa5PwoXxlsSW
         GuokG2hrE2cGga4JS3tUQF0agPrQzJ8wf4bT/qkNRSkjLHDQ0cueinNTn4V+caRQN5
         b5iuHDF7A+9+g2k44ka/hbqVOYL4MUt8bQkj8YP8KWc+xEhbuyxsLL/B7D60cKRrGH
         AurdDVW7Nu94VkG9592+WAS2XE0Lh+NU5bYDki6h0/1N7WRUdH4JKr7c5CC/OuyHlS
         howBetW4T9o46esgQOwVl80JhlOEM5hYmnO5/XlQlu7FmrQv6AoCQxUXLbJLOEb1sd
         Q/u33cEHm67bg==
Received: by mail-ed1-f72.google.com with SMTP id z24-20020a50cd18000000b00414d5314c35so660636edi.21
        for <linux-ide@vger.kernel.org>; Wed, 02 Mar 2022 01:46:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lAb27ZgFQOByFHIClEAhJ0N2dL6QzOfjA77CIlXGrDU=;
        b=oc2z1MLQO86KTrdHd44xUjffz3b7S+66KK7XfeCMqYKxjysbYC378FuvnyyZEUov83
         tKA1jNhAy9BX3vTGJ5UlPdeygyRJWLr7QpAnfw2NxYOL+XmEm3TRM3IExyLLTk7GhcSS
         ECrdoeGPX4N7i/Ed84Avdjyy0I85abprPJ/aAhrV19M8Z3l4aOagO6uDi7dHa7jAz4Rs
         55bPa42JpYyE0cLqC0468X59Gx2TwgpMFgUpNhC+F0NbmS2S8gMzvtoChuxJG1pgJX6b
         vHRNwqadwB+ZSYZkq53igoUY3YXKRbkizkOlwNlSJVWF886aCD7GKC64F49rjH/f/oKj
         GSTQ==
X-Gm-Message-State: AOAM531M3GeGa2TfhGKjaQ4JWJZU3sy72igphKnGVp8zVO06Ysxn2sla
        NQ9fMdeLim5ABjFWad4OG1LYZCXWXLnBsrH4nEWIZR9xXwZrupKpsWBtscr9oxC2G4tdPJ6/3T0
        XnkXKFwMux/So1a+tNpe37HS2lejV7WJsoW5gTw==
X-Received: by 2002:a17:906:c048:b0:6ce:a6f5:b23a with SMTP id bm8-20020a170906c04800b006cea6f5b23amr21987696ejb.350.1646214370261;
        Wed, 02 Mar 2022 01:46:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxt3m08y7YEqtS4flqRepTSs5Wr7s6n2g6prN66QvwsvFQSR8vFMHL5ix5LeZez52FJ+02DBA==
X-Received: by 2002:a17:906:c048:b0:6ce:a6f5:b23a with SMTP id bm8-20020a170906c04800b006cea6f5b23amr21987679ejb.350.1646214369981;
        Wed, 02 Mar 2022 01:46:09 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id v5-20020a056402184500b00412e1a73c7bsm8152603edy.61.2022.03.02.01.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 01:46:09 -0800 (PST)
Message-ID: <6dae47c3-6083-782e-ecab-7be3f0bca0e1@canonical.com>
Date:   Wed, 2 Mar 2022 10:46:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/5] dt-bindings: Convert ahci-platform DT bindings to
 yaml
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20220301152421.57281-1-linux@fw-web.de>
 <20220301152421.57281-2-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220301152421.57281-2-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 01/03/2022 16:24, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Create a yaml file for dtbs_check from the old txt binding.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v4:
>   - fix min vs. max
>   - fix indention of examples
>   - move up sata-common.yaml
>   - reorder compatible
>   - add descriptions/maxitems
>   - fix compatible-structure
>   - fix typo in example achi vs. ahci
>   - add clock-names and reg-names
>   - fix ns2 errors in separate patch
> v3:
>   - add conversion to sata-series
>   - fix some errors in dt_binding_check and dtbs_check
>   - move to unevaluated properties = false
> 
> ---
> 
> imho all errors should be fixed in the dts not in the yaml...
> 
> errors about the subitem requirement that was defined in txt but not fixed some marvell dts
> 
> some dts for Marvell SoC bring error
> 'phys' is a required property
> 'target-supply' is a required property
> 
> problem is in arch/arm64/boot/dts/marvell/armada-cp11x.dtsi:331
> here the sata-port@0 is defined, but not overridden with phy/target-supply in any following dts
> ---
>  .../devicetree/bindings/ata/ahci-platform.txt |  79 ---------
>  .../bindings/ata/ahci-platform.yaml           | 162 ++++++++++++++++++
>  2 files changed, 162 insertions(+), 79 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> deleted file mode 100644
> index 77091a277642..000000000000
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ /dev/null
> @@ -1,79 +0,0 @@
> -* AHCI SATA Controller
> -
> -SATA nodes are defined to describe on-chip Serial ATA controllers.
> -Each SATA controller should have its own node.
> -
> -It is possible, but not required, to represent each port as a sub-node.
> -It allows to enable each port independently when dealing with multiple
> -PHYs.
> -
> -Required properties:
> -- compatible        : compatible string, one of:
> -  - "brcm,iproc-ahci"
> -  - "hisilicon,hisi-ahci"
> -  - "cavium,octeon-7130-ahci"
> -  - "ibm,476gtr-ahci"
> -  - "marvell,armada-380-ahci"
> -  - "marvell,armada-3700-ahci"
> -  - "snps,dwc-ahci"
> -  - "snps,spear-ahci"
> -  - "generic-ahci"
> -- interrupts        : <interrupt mapping for SATA IRQ>
> -- reg               : <registers mapping>
> -
> -Please note that when using "generic-ahci" you must also specify a SoC specific
> -compatible:
> -	compatible = "manufacturer,soc-model-ahci", "generic-ahci";
> -
> -Optional properties:
> -- dma-coherent      : Present if dma operations are coherent
> -- clocks            : a list of phandle + clock specifier pairs
> -- resets            : a list of phandle + reset specifier pairs
> -- target-supply     : regulator for SATA target power
> -- phy-supply        : regulator for PHY power
> -- phys              : reference to the SATA PHY node
> -- phy-names         : must be "sata-phy"
> -- ahci-supply       : regulator for AHCI controller
> -- ports-implemented : Mask that indicates which ports that the HBA supports
> -		      are available for software to use. Useful if PORTS_IMPL
> -		      is not programmed by the BIOS, which is true with
> -		      some embedded SOC's.
> -
> -Required properties when using sub-nodes:
> -- #address-cells    : number of cells to encode an address
> -- #size-cells       : number of cells representing the size of an address
> -
> -Sub-nodes required properties:
> -- reg		    : the port number
> -And at least one of the following properties:
> -- phys		    : reference to the SATA PHY node
> -- target-supply     : regulator for SATA target power
> -
> -Examples:
> -        sata@ffe08000 {
> -		compatible = "snps,spear-ahci";
> -		reg = <0xffe08000 0x1000>;
> -		interrupts = <115>;
> -        };
> -
> -With sub-nodes:
> -	sata@f7e90000 {
> -		compatible = "marvell,berlin2q-achi", "generic-ahci";
> -		reg = <0xe90000 0x1000>;
> -		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&chip CLKID_SATA>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		sata0: sata-port@0 {
> -			reg = <0>;
> -			phys = <&sata_phy 0>;
> -			target-supply = <&reg_sata0>;
> -		};
> -
> -		sata1: sata-port@1 {
> -			reg = <1>;
> -			phys = <&sata_phy 1>;
> -			target-supply = <&reg_sata1>;;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> new file mode 100644
> index 000000000000..cf67ddfc6afb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> @@ -0,0 +1,162 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AHCI SATA Controller
> +description:
> +  SATA nodes are defined to describe on-chip Serial ATA controllers.
> +  Each SATA controller should have its own node.
> +
> +  It is possible, but not required, to represent each port as a sub-node.
> +  It allows to enable each port independently when dealing with multiple
> +  PHYs.
> +
> +maintainers:
> +  - Hans de Goede <hdegoede@redhat.com>
> +  - Jens Axboe <axboe@kernel.dk>
> +
> +allOf:
> +- $ref: "sata-common.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - enum:
> +          - brcm,iproc-ahci
> +          - marvell,armada-8k-ahci
> +          - marvell,berlin2q-ahci
> +        - const: generic-ahci
> +      - enum:
> +        - brcm,iproc-ahci

This one is already earlier in generic-ahci, so you can skip him here.

> +        - cavium,octeon-7130-ahci
> +        - hisilicon,hisi-ahci
> +        - ibm,476gtr-ahci
> +        - marvell,armada-3700-ahci
> +        - marvell,armada-380-ahci
> +        - snps,dwc-ahci
> +        - snps,spear-ahci
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Clock IDs array as required by the controller.
> +    minItems: 1
> +    maxItems: 3
> +
> +  interrupts:
> +    description:
> +      specifies the interrupt number for the controller.

Skip description, it's obvious.

> +    maxItems: 1
> +
> +  ahci-supply:
> +    description:
> +      regulator for AHCI controller
> +
> +  clock-names:
> +    description:
> +      Names of clocks corresponding to IDs in the clock property.
> +    minItems: 1
> +    maxItems: 3

Put the clock-names next to clocks.

> +
> +  dma-coherent:
> +    true

New line not needed. "dma-coherent: true"

> +
> +  phy-supply:
> +    description:
> +      regulator for PHY power
> +
> +  phys:
> +    description:
> +      List of all PHYs on this controller
> +    maxItems: 1
> +
> +  phy-names:
> +    description:
> +      Name specifier for the PHYs
> +    maxItems: 1
> +
> +  ports-implemented:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description:
> +      Mask that indicates which ports that the HBA supports
> +      are available for software to use. Useful if PORTS_IMPL
> +      is not programmed by the BIOS, which is true with
> +      some embedded SoCs.
> +    maxItems: 1

maxItems are incorrect here, this is not an array.

> +
> +  reg-names:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  target-supply:
> +    description:
> +      regulator for SATA target power
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +patternProperties:
> +  "^sata-port@[0-9a-f]+$":
> +    type: object
> +    description:
> +      Subnode with configuration of the Ports.
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      phys:
> +        minItems: 1

maxItems: 1

> +
> +      target-supply:
> +        description:
> +          regulator for SATA target power
> +
> +    required:
> +      - reg
> +
> +    anyOf:
> +      - required: [ phys ]
> +      - required: [ target-supply ]
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sata@ffe08000 {
> +           compatible = "snps,spear-ahci";
> +           reg = <0xffe08000 0x1000>;
> +           interrupts = <115>;
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/berlin2q.h>
> +    sata@f7e90000 {
> +            compatible = "marvell,berlin2q-ahci", "generic-ahci";
> +            reg = <0xe90000 0x1000>;

You still have wrong address.

> +            interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&chip CLKID_SATA>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            sata0: sata-port@0 {
> +                    reg = <0>;
> +                    phys = <&sata_phy 0>;
> +                    target-supply = <&reg_sata0>;
> +            };
> +
> +            sata1: sata-port@1 {
> +                    reg = <1>;
> +                    phys = <&sata_phy 1>;
> +                    target-supply = <&reg_sata1>;
> +            };
> +    };


Best regards,
Krzysztof
