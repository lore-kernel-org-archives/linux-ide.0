Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239E2C433EF
	for <linux-ide@archiver.kernel.org>; Sat,  5 Mar 2022 17:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiCERoI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 5 Mar 2022 12:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiCERoG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 5 Mar 2022 12:44:06 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C660200568
        for <linux-ide@vger.kernel.org>; Sat,  5 Mar 2022 09:43:15 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B59A43F5F9
        for <linux-ide@vger.kernel.org>; Sat,  5 Mar 2022 17:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646502193;
        bh=0a7OnLjgpv73TO+6vM+DNDtQMe8kEfSMEHTewavR1aA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=nG8XzYGxs91rtn5CMOMD2raqhK9IJMh7OAPh8f9CH0gpAkKstGekpAD/QWoJi5TxJ
         Ytw6pnDPv33fcWodosj+zJ1dXuP2nR1fHp0falZ2qCcwKgmNawCgBMiEPlrQfw6c3s
         2fuxTwutNbNUNy5sjVbs+KMtemL14LivCJtZjCPPemnQM6ZntkoAiB6P9TQvFLT4IH
         Qg1d/P8iyR1QQz5ZClk9HRy5KH0IhyqkH7emV2MfoBN/3kV+ADzhXxzj351l8jVee7
         Se4ng2xhIW/FYcVAfeNfXyjuPkpdABH855+OfkoLW467YMRglKjnijPP85snUiDEvY
         7Ursw1kRedYrQ==
Received: by mail-ed1-f69.google.com with SMTP id l14-20020a056402344e00b0041593c729adso5935743edc.18
        for <linux-ide@vger.kernel.org>; Sat, 05 Mar 2022 09:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0a7OnLjgpv73TO+6vM+DNDtQMe8kEfSMEHTewavR1aA=;
        b=ZnkjqYnQbu1AGKcWdqGnJh7Ra+Do93Pulhr01eJ5fRVHTduc63rf6X9sAJxH7l3n+o
         brUG5GAvVWx4lMho6u3THaHYk/My9+yuBA196JH8kJWLciFSDaR3rJsRns4Db54Inb1M
         UbDfGRrFX5/P5Z6d8aLMs0xOgFYaDn+6HYFCNUvM65H8yO/qkHyyI64I29w1qGq+baRU
         FbzqABmE2NAh8OeUB8pSwJw9zbTaLAHe5dfyzNB+h3wD53T9GNGH7STz+VzIr72ZMXQj
         fa+85JVtD9zlKuykRVn/nr1edyGOh5PIYYIi0LHuymoXrFFPvPwAkYg+8Y9emQD732gi
         7ESA==
X-Gm-Message-State: AOAM533r1J4nKi5jZ4SPUPrN45sDYk76Ba+TyYdtN1ghAlHNlKZyc7Y4
        o3XOQG6EKU7qStJzSe9A+LLp+uXHtoPPEc2o1pI7Mq/jiggFT+iUQm+0z/tN26tqh7alOEROE+z
        yBCnHcHSBg/TODmGrInibIEA+/9BxJlG3GkmXMw==
X-Received: by 2002:a05:6402:7cb:b0:415:f059:c817 with SMTP id u11-20020a05640207cb00b00415f059c817mr3774027edy.364.1646502193280;
        Sat, 05 Mar 2022 09:43:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyilZu0PIy6v026/Z6mMVO3WIXIVbNJEb1OM1cHfPlQukRYb1GMyVvq751GLXXwH0172z0i3w==
X-Received: by 2002:a05:6402:7cb:b0:415:f059:c817 with SMTP id u11-20020a05640207cb00b00415f059c817mr3773999edy.364.1646502193008;
        Sat, 05 Mar 2022 09:43:13 -0800 (PST)
Received: from [192.168.0.139] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id lb10-20020a170907784a00b006db0aadcbd1sm426931ejc.219.2022.03.05.09.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Mar 2022 09:43:12 -0800 (PST)
Message-ID: <a2839b00-d195-131f-b2a7-d2f030a5bd95@canonical.com>
Date:   Sat, 5 Mar 2022 18:43:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 1/5] dt-bindings: ata: ahci-platform: Convert DT
 bindings to yaml
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20220305112607.257734-1-linux@fw-web.de>
 <20220305112607.257734-2-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220305112607.257734-2-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 05/03/2022 12:26, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Create a yaml file for dtbs_check from the old txt binding.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> 
> v5:
>   - change subject
>   - drop brcm,iproc-ahci from standalone enum
>   - fix reg address in example 2
>   - move clocknames next to clocks, regnames to reg
>   - drop interrupts description
>   - drop newline from dma-coherent
>   - drop max-items from ports-implemented
>   - min2max in child phys
>   - fix identation for compatible and sata-common
>   - add additionalProperties=false for subnodes
>   - pipe for paragraphs and newline after title
>   - add maximum for ports-implemented (found only 0x1 as its value)
>   - add phy-names to sata-ports
> 
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
>  .../devicetree/bindings/ata/ahci-platform.txt |  79 ---------
>  .../bindings/ata/ahci-platform.yaml           | 163 ++++++++++++++++++
>  2 files changed, 163 insertions(+), 79 deletions(-)
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
> index 000000000000..fae042539824
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> @@ -0,0 +1,163 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AHCI SATA Controller
> +
> +description: |
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
> +  - $ref: "sata-common.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - brcm,iproc-ahci
> +              - marvell,armada-8k-ahci
> +              - marvell,berlin2q-ahci
> +          - const: generic-ahci
> +      - enum:
> +          - cavium,octeon-7130-ahci
> +          - hisilicon,hisi-ahci
> +          - ibm,476gtr-ahci
> +          - marvell,armada-3700-ahci
> +          - marvell,armada-380-ahci
> +          - snps,dwc-ahci
> +          - snps,spear-ahci
> +
> +  reg:
> +    maxItems: 1
> +
> +  reg-names:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Clock IDs array as required by the controller.
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names:
> +    description:
> +      Names of clocks corresponding to IDs in the clock property.
> +    minItems: 1
> +    maxItems: 3
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ahci-supply:
> +    description:
> +      regulator for AHCI controller
> +
> +  dma-coherent: true
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
> +    description: |
> +      Mask that indicates which ports that the HBA supports
> +      are available for software to use. Useful if PORTS_IMPL
> +      is not programmed by the BIOS, which is true with
> +      some embedded SoCs.
> +    maximum: 0x1
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
> +    additionalProperties: false
> +    description:
> +      Subnode with configuration of the Ports.
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      phys:
> +        maxItems: 1
> +
> +      phy-names:
> +        maxItems: 1
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

Thanks for the changes, all look good except now I noticed that
indentation of example is unusual. It's not consistent. Starts with four
space (correct) but then goes to 7 spaces. Please adjust entire example
to use 4 spaces indentation.

With that:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
