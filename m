Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F04C4320A
	for <linux-ide@archiver.kernel.org>; Wed, 28 Jul 2021 16:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D5C60F23
	for <linux-ide@archiver.kernel.org>; Wed, 28 Jul 2021 16:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhG1QOw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 28 Jul 2021 12:14:52 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:43761 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhG1QOs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 28 Jul 2021 12:14:48 -0400
Received: by mail-io1-f42.google.com with SMTP id 185so3563982iou.10;
        Wed, 28 Jul 2021 09:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/mtNibC7Fvo1HsXc7idF5QFDgyDNt/2Z97m95bd7FNY=;
        b=kmlx+UaX+fE2FaxL9cctyOthQ2jkQwZTDxplBe52ZPIOjg5N2PTDQmYM2SrfpjmfNA
         BNpRdx0Oo5R8SDPwCULsfJhinY9NDSpJujPtQG5BIqT5GizdPemn+DN1NYIrZ7lUctw+
         S5UjgQBHmdFnJxiTLW/aphwGLvrM4/EfbN91PofaJZEAsWrZF4vFqeYkV3PpyJw6vkyu
         r62RcG5uw9UGDeW1CnkII/qezyWKJkKuWjyoeVl0QJ70YYFhfpRWCfaYeYs1lboedtaK
         eAx5Ub09Yghu1OL6om3QUrl+9Vo0ut8S0+/lLlYCFVNLopt4ns9EhtISNK7kwMzpglWo
         9unQ==
X-Gm-Message-State: AOAM533wZB/eElSi5SODit0zyZYaN0IWEyI1iVVkfcBvmKu3SGmi8lq+
        bg+TLFG0nZ0yoLlAqIC2KA==
X-Google-Smtp-Source: ABdhPJzQ7wN03n2xbbg8YAn/mDpn/QiQPE7/urkDzDsUYKTWFpi4oAUGKuqfdsnDqk1S3nx+Php6GQ==
X-Received: by 2002:a05:6638:22f:: with SMTP id f15mr550556jaq.141.1627488884481;
        Wed, 28 Jul 2021 09:14:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j11sm176849ilu.78.2021.07.28.09.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 09:14:43 -0700 (PDT)
Received: (nullmailer pid 1168840 invoked by uid 1000);
        Wed, 28 Jul 2021 16:14:41 -0000
Date:   Wed, 28 Jul 2021 10:14:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] pata: ixp4xx: Add DT bindings
Message-ID: <20210728161441.GA1163345@robh.at.kernel.org>
References: <20210728090242.2758812-1-linus.walleij@linaro.org>
 <20210728090242.2758812-5-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728090242.2758812-5-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Jul 28, 2021 at 11:02:41AM +0200, Linus Walleij wrote:
> This adds device tree bindings for the Intel IXP4xx compact flash card
> interface.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../ata/intel,ixp4xx-compact-flash.yaml       | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml b/Documentation/devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml
> new file mode 100644
> index 000000000000..b254be858de6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/intel,ixp4xx-compact-flash.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel IXP4xx CompactFlash Card Controller
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: |
> +  The IXP4xx network processors have a CompactFlash interface that presents
> +  a CompactFlash card to the system as a true IDE (parallell ATA) device. The

typo. (you can setup checkpatch.pl to do spell checking)

> +  device is always connected to the expansion bus of the IXP4xx SoCs using one
> +  or two chip select areas and address translating logic on the board. The
> +  node must be placed inside a chip select node on the IXP4xx expansion bus.
> +
> +properties:
> +  compatible:
> +    const: intel,ixp4xx-compact-flash
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 2

What is each entry?

> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - $ref: pata-common.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    bus@c4000000 {
> +      compatible = "intel,ixp43x-expansion-bus-controller", "syscon";
> +      reg = <0xc4000000 0x1000>;
> +      native-endian;
> +      #address-cells = <2>;
> +      #size-cells = <1>;
> +      ranges = <0 0x0 0x50000000 0x01000000>, <1 0x0 0x51000000 0x01000000>;
> +      dma-ranges = <0 0x0 0x50000000 0x01000000>, <1 0x0 0x51000000 0x01000000>;
> +      ide@1,0 {
> +        compatible = "intel,ixp4xx-compact-flash";

> +        intel,ixp4xx-eb-t1 = <3>;
> +        intel,ixp4xx-eb-t2 = <3>;

Can you omit these? Otherwise, this will start failing soon as 
unevaluatedProperties is implemented (I have a test branch). Or you need 
to handle child node properties as discussed.

> +        reg = <1 0x00000000 0x1000>, <1 0x00040000 0x1000>;
> +        interrupt-parent = <&gpio0>;
> +        interrupts = <12 IRQ_TYPE_EDGE_RISING>;
> +      };
> +    };
> +
> +...
> -- 
> 2.31.1
> 
> 
