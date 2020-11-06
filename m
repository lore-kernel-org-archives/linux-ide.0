Return-Path: <SRS0=A6T3=EM=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125EFC2D0A3
	for <linux-ide@archiver.kernel.org>; Fri,  6 Nov 2020 16:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3FC22203
	for <linux-ide@archiver.kernel.org>; Fri,  6 Nov 2020 16:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604679321;
	bh=xfmWDp9CFPu+9O0XiLuLZY11roJ1SLzo6d8f8tJX3OU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Psmd0SOBcPZsPwDhJ6ab4xJ8OhLQm7CeO9fmUadeqwlnzZWTSs+o60qWNnvK9ylNH
	 bAW8n60rDMk29EJl/v6STta/qCBYrod3qfVd69vxiCFY45MPcJtU6fgCWyIA0faEPB
	 coBmtX8aGXOSd28XUQ1JWvQ/ge7OgqiFO0ShMnyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgKFQPV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 6 Nov 2020 11:15:21 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36520 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFQPV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 6 Nov 2020 11:15:21 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so1712533otm.3;
        Fri, 06 Nov 2020 08:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B6YSrk+0c+AJwW3qgU6Jh+lEfY+XxZlQQTIhLOcyWxo=;
        b=DuHVmIM6iLp93uRqnLP7xYM2k7FnxsQZlQO78Qv7YeB+sGIG4aI1QFUw6wEg+/dlUO
         HA98e3zi+ILW8VCRneEt8wJtvuyiQ077QAxJBRNsR2TczHZ7juktCn19GXM4u0DwckXQ
         Qj8ADXibhlYMejwktuXjkiYEeXVIAkss5+exdWfWiLKN3VmgQhvU18+4UHPjAWGzWgM2
         xUTXbc9pBCBdqP2GBNGPuS6oCbWSeHvY99K5sSLrpbot65bC8+hpfyWItXZUcusZ0wf+
         qACHLX4nrxDDjJKDT1nvpVT1XXLzeOjJmY1r+zfhpHWWg7vQQhrzi4M0UOvzQJgZsLsZ
         UiPA==
X-Gm-Message-State: AOAM530uI2Uha7QmPyRubTEM/aWTfapK8pC86DyoWxAlFmPpmXVAKHBy
        QpG/gYi15OPzq0mY/v3xQw==
X-Google-Smtp-Source: ABdhPJw5xaJPHanhZ1F9y0LCHHFDvpwMndnpkffIEpq4lPHPQNg8HLJDQWT7Z9LRZljRRMxOqZPcnA==
X-Received: by 2002:a9d:550a:: with SMTP id l10mr1420812oth.357.1604679319573;
        Fri, 06 Nov 2020 08:15:19 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z19sm410303ooi.32.2020.11.06.08.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 08:15:18 -0800 (PST)
Received: (nullmailer pid 3295473 invoked by uid 1000);
        Fri, 06 Nov 2020 16:15:17 -0000
Date:   Fri, 6 Nov 2020 10:15:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: ata: tegra: Convert binding
 documentation to YAML
Message-ID: <20201106161517.GA3290506@bogus>
References: <1604628968-1501-1-git-send-email-skomatineni@nvidia.com>
 <1604628968-1501-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604628968-1501-2-git-send-email-skomatineni@nvidia.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Nov 05, 2020 at 06:16:05PM -0800, Sowjanya Komatineni wrote:
> This patch converts text based dt-binding document to YAML based
> dt-binding document.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 152 +++++++++++++++++++++
>  .../bindings/ata/nvidia,tegra124-ahci.txt          |  44 ------
>  2 files changed, 152 insertions(+), 44 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
>  delete mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
> new file mode 100644
> index 0000000..ac20f6e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
> @@ -0,0 +1,152 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/nvidia,tegra-ahci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tegra AHCI SATA Controller
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Jonathan Hunter <jonathanh@nvidia.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nvidia,tegra124-ahci
> +      - nvidia,tegra132-ahci
> +      - nvidia,tegra210-ahci
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 3
> +    items:
> +      - description: AHCI registers
> +      - description: SATA configuration and IPFS registers
> +      - description: SATA AUX registers
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-names:
> +    maxItems: 2

Don't need maxItems, implied by the size of 'items'.

> +    items:
> +      - const: sata
> +      - const: sata-oob
> +
> +  clocks:
> +    maxItems: 2
> +    description:
> +      Must contain an entry for each entry in clock-names.
> +      See ../clocks/clock-bindings.txt for details.

Drop 'description'. Says nothing specific to this binding.

> +
> +  reset-names:
> +    maxItems: 3

Need to define what each reset is.

> +
> +  resets:
> +    maxItems: 3
> +    description:
> +      Must contain an entry for each entry in reset-names.
> +      See ../reset/reset.txt for details.

Drop 'description'. Says nothing specific to this binding.

> +
> +  phy-names:
> +    items:
> +      - const: sata-0
> +
> +  phys:
> +    maxItems: 1
> +    description:
> +      Must contain an entry for each entry in phy-names.
> +      See ../phy/phy-bindings.txt for details.

Drop 'description'. Says nothing specific to this binding.

> +
> +  hvdd-supply:
> +    description: SATA HVDD regulator supply.
> +
> +  vddio-supply:
> +    description: SATA VDDIO regulator supply.
> +
> +  avdd-supply:
> +    description: SATA AVDD regulator supply.
> +
> +  target-5v-supply:
> +    description: SATA 5V power regulator supply.
> +
> +  target-12v-supply:
> +    description: SATA 12V power regulator supply.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clock-names
> +  - clocks
> +  - reset-names
> +  - resets
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra124-ahci
> +              - nvidia,tegra132-ahci
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 2

> +        reset-names:
> +          minItems: 3
> +          items:
> +            - const: sata
> +            - const: sata-oob
> +            - const: sata-cold
> +        resets:
> +          minItems: 3

This doesn't need to be conditional.

> +      required:
> +        - phys
> +        - phy-names
> +        - hvdd-supply
> +        - vddio-supply
> +        - avdd-supply
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra210-ahci
> +    then:
> +      properties:
> +        reg:
> +          minItems: 3
> +        reset-names:
> +          minItems: 3
> +          items:
> +            - const: sata
> +            - const: sata-oob
> +            - const: sata-cold
> +        resets:
> +          minItems: 3
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/tegra210-car.h>
> +    #include <dt-bindings/reset/tegra210-car.h>
> +
> +    sata@70020000 {
> +            compatible = "nvidia,tegra210-ahci";
> +            reg = <0x0 0x70027000 0x0 0x00002000>, /* AHCI */
> +                  <0x0 0x70020000 0x0 0x00007000>, /* SATA */
> +                  <0x0 0x70001100 0x0 0x00010000>; /* SATA AUX */
> +            interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&tegra_car TEGRA210_CLK_SATA>,
> +                     <&tegra_car TEGRA210_CLK_SATA_OOB>;
> +            clock-names = "sata", "sata-oob";
> +            resets = <&tegra_car 124>,
> +                     <&tegra_car 123>,
> +                     <&tegra_car 129>;
> +            reset-names = "sata", "sata-oob", "sata-cold";
> +    };
> diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt b/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
> deleted file mode 100644
> index 12ab2f7..0000000
> --- a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -Tegra SoC SATA AHCI controller
> -
> -Required properties :
> -- compatible : Must be one of:
> -  - Tegra124 : "nvidia,tegra124-ahci"
> -  - Tegra132 : "nvidia,tegra132-ahci", "nvidia,tegra124-ahci"
> -  - Tegra210 : "nvidia,tegra210-ahci"
> -- reg : Should contain 2 entries:
> -  - AHCI register set (SATA BAR5)
> -  - SATA register set
> -- interrupts : Defines the interrupt used by SATA
> -- clocks : Must contain an entry for each entry in clock-names.
> -  See ../clocks/clock-bindings.txt for details.
> -- clock-names : Must include the following entries:
> -  - sata
> -  - sata-oob
> -- resets : Must contain an entry for each entry in reset-names.
> -  See ../reset/reset.txt for details.
> -- reset-names : Must include the following entries:
> -  - sata
> -  - sata-oob
> -  - sata-cold
> -- phys : Must contain an entry for each entry in phy-names.
> -  See ../phy/phy-bindings.txt for details.
> -- phy-names : Must include the following entries:
> -  - For Tegra124 and Tegra132:
> -    - sata-phy : XUSB PADCTL SATA PHY
> -- For Tegra124 and Tegra132:
> -  - hvdd-supply : Defines the SATA HVDD regulator
> -  - vddio-supply : Defines the SATA VDDIO regulator
> -  - avdd-supply : Defines the SATA AVDD regulator
> -  - target-5v-supply : Defines the SATA 5V power regulator
> -  - target-12v-supply : Defines the SATA 12V power regulator
> -
> -Optional properties:
> -- reg :
> -  - AUX register set
> -- clock-names :
> -  - cml1 :
> -    cml1 clock should be defined here if the PHY driver
> -    doesn't manage them. If it does, they should not be.
> -- phy-names :
> -  - For T210:
> -    - sata-phy
> -- 
> 2.7.4
> 
