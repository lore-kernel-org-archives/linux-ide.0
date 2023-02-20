Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC54CC636CC
	for <linux-ide@archiver.kernel.org>; Mon, 20 Feb 2023 11:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjBTLse (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 20 Feb 2023 06:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjBTLsa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2023 06:48:30 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4A519F29
        for <linux-ide@vger.kernel.org>; Mon, 20 Feb 2023 03:48:28 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cq23so3296439edb.1
        for <linux-ide@vger.kernel.org>; Mon, 20 Feb 2023 03:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=onVDiy96v825/uJ1iMb7Bbjnmgpcg/nz9khxi7KW7is=;
        b=AuhcG2m5ZIgATkxaASn3sSsvo2bCz5hOnqDW7kbirbXW5fYyLsc8LFQxq6nHRErYv3
         Klf5aMfFFADf/m058vg9KxNT+Vnuki4Wo7sqquWrRVXaeK2l1BeYK0QzP+lXDntMNR23
         H29rNTIgI0WwP4i4zvGWMuTns2slSKRIffU5jU8kHXqYbrvPy64le8909HN8tOkfEOkS
         SvXkWVg6HoVrwpiPt/6eRM9GAzydz1ijwrqGHEW389/2C+Pnf9fJh63ui5Ra5bCADJaU
         VInnzxJfAzaX1UvsDEsX93ZuTJBnP/8/qV68/VtKGlHaRgxMEsLVdCnmlP4Rj2CSwej8
         s5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=onVDiy96v825/uJ1iMb7Bbjnmgpcg/nz9khxi7KW7is=;
        b=NllrIs3ZO7y565XL1Jhv8v4qqMVc2gAPbbmgXMB8FB1Mvc69cgSeOjtgawTs7Kg2fo
         EKiZZLF1Whte863/cGS4OzDFc1t8UUHS3JZZm55WHfwyqC0GMTwSG4altrIIWmp0uywP
         dPnY6K7aHiOXVHlgwntM45GcKB03QNWmW1BsxEHjMxZV10E+ZHyaOmuy7eNssLoBn/ag
         Iln/jg6xYMvHHnGsH9aSA8pfkCCGgfNiy1LpzT/6iCKBPNE/Aec15DHdZ9vZUlaDMDvM
         Q5cJCBXrWUWz+lEzrQHwPjS/wDDTLjqciM3ylzBLbKwPAuBaE0neJ+bmWbm/PC8gpf0x
         BX2w==
X-Gm-Message-State: AO0yUKWt2WKJdmhYZAo6itqc6VmcUI2YipJnRgv6mKjZf+H4NjS9f9/h
        Hd4sSxhgkplNirIAcSTj8o+OJw==
X-Google-Smtp-Source: AK7set+4sJwBOTSX5AqToqDhUHako8Ac7flMPeiZuxUAxQtDd7OpNAwGlthKCHsfHtRSxnTh1nuu7Q==
X-Received: by 2002:a05:6402:5156:b0:4ad:7205:8427 with SMTP id n22-20020a056402515600b004ad72058427mr1160950edd.27.1676893706949;
        Mon, 20 Feb 2023 03:48:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v11-20020a50c40b000000b004acaa4d51bdsm963808edf.32.2023.02.20.03.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 03:48:26 -0800 (PST)
Message-ID: <8a4042fd-02a3-261e-4126-7a3090850fda@linaro.org>
Date:   Mon, 20 Feb 2023 12:48:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] dt-bindings: ata: Add UniPhier controller binding
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230220054711.4584-1-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220054711.4584-1-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 20/02/2023 06:47, Kunihiko Hayashi wrote:
> Add UniPhier SATA controller compatible string to the platform binding.
> This controller needs two or three reset controls.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/ata/ahci-platform.yaml           | 32 ++++++++++++++++---
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> Changes since v2:
> - Add compatible strings to select property
> - Add minItems and change maxItems for resets
> - Move condition schema under allOf property
> - Change resets to "required" for uniphier-*-ahci
> 
> Changes since v1:
> - Restrict resets property changes with compatible strings
> - Fix maxItems from two to three
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> index 7dc2a2e8f598..4b2ee68097b8 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> @@ -30,12 +30,12 @@ select:
>            - marvell,armada-3700-ahci
>            - marvell,armada-8k-ahci
>            - marvell,berlin2q-ahci
> +          - socionext,uniphier-pro4-ahci
> +          - socionext,uniphier-pxs2-ahci
> +          - socionext,uniphier-pxs3-ahci
>    required:
>      - compatible
>  
> -allOf:
> -  - $ref: "ahci-common.yaml#"
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -45,6 +45,9 @@ properties:
>                - marvell,armada-8k-ahci
>                - marvell,berlin2-ahci
>                - marvell,berlin2q-ahci
> +              - socionext,uniphier-pro4-ahci
> +              - socionext,uniphier-pxs2-ahci
> +              - socionext,uniphier-pxs3-ahci
>            - const: generic-ahci
>        - enum:
>            - cavium,octeon-7130-ahci
> @@ -67,14 +70,33 @@ properties:
>      minItems: 1
>      maxItems: 3
>  
> +  resets:
> +    minItems: 1
> +    maxItems: 3
> +
>    interrupts:
>      maxItems: 1
>  
>    power-domains:
>      maxItems: 1
>  
> -  resets:
> -    maxItems: 1

Why moving it?

> +allOf:

This goes to the same place as in example-schema.

> +  - $ref: ahci-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - socionext,uniphier-pro4-ahci
> +              - socionext,uniphier-pxs2-ahci
> +              - socionext,uniphier-pxs3-ahci
> +    then:
> +      properties:
> +        resets:
> +          minItems: 2
> +          maxItems: 3

You need to describe the items, what's expected here.

> +      required:
> +        - resets

The entire point was to add:

else - maxItems: 1

>  
>  patternProperties:
>    "^sata-port@[0-9a-f]+$":

Best regards,
Krzysztof

