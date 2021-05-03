Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C392FC433ED
	for <linux-ide@archiver.kernel.org>; Mon,  3 May 2021 19:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C08D613B3
	for <linux-ide@archiver.kernel.org>; Mon,  3 May 2021 19:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhECT3B (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 3 May 2021 15:29:01 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:39574 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhECT3A (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 3 May 2021 15:29:00 -0400
Received: by mail-ot1-f49.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso6121041otv.6;
        Mon, 03 May 2021 12:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iR5lJyB1TrAOZNykGlZNXsLYDNaojWhhq9zflyVwyeA=;
        b=h4Naft0HbsyJAwobHUjLSNk+ZuGseENr+TDPHMQE66vbBpJL+IpURhoMLTejtRcSop
         MF6ftAE4mFH0Za2GnWDIxnZBy4ILIYYQmvrhENys3lfqLSaN7fjgpxfdQtcp1LWgQpzy
         d6r25Y0+CExg0TSrw+l3pCgq6ZPVNFkfq/VTFalrC/Qm4AA7mVhHLHtsuuLRFf/O1Dho
         hHh2EuuRBtb5MZGK7ewTR0mjaBADppQ2si8c1nop285bXazTZDvmo4u37ep/vhY1A8Kr
         1KZVsAzS0gqgyTA2v3/ESWVk398q+a7AdIG00p5mFMmorCQv7Hp6Nc8i3eGemLQxkAnq
         6yvw==
X-Gm-Message-State: AOAM533flArqGnJY2yjsECrVG2dsb/5CCttcujPpoaKiSD+q+iKzxVPG
        8Zvc9eprCsmSooSUifscFiuAcLYVXg==
X-Google-Smtp-Source: ABdhPJxptf+ZNEp6y1FZypR9E5s+MySSo7XCPWzSr+PZ1Hs8Tt2g78JhAant7OXnbL2OUi8qm4hIVg==
X-Received: by 2002:a9d:5f0c:: with SMTP id f12mr15844361oti.258.1620070086953;
        Mon, 03 May 2021 12:28:06 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j5sm178967otq.10.2021.05.03.12.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 12:28:06 -0700 (PDT)
Received: (nullmailer pid 2241244 invoked by uid 1000);
        Mon, 03 May 2021 19:28:05 -0000
Date:   Mon, 3 May 2021 14:28:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: ata: Add device tree binding fir
 Mikrotik RB532 PATA controller
Message-ID: <20210503192805.GA2232229@robh.at.kernel.org>
References: <20210428163336.73125-1-tsbogend@alpha.franken.de>
 <20210428163336.73125-3-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428163336.73125-3-tsbogend@alpha.franken.de>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Apr 28, 2021 at 06:33:36PM +0200, Thomas Bogendoerfer wrote:
> Add YAML devicetree binding for Mikrotik RB532 PATA controller.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  .../bindings/ata/mikrotek,rb532-pata.yaml     | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/mikrotek,rb532-pata.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/mikrotek,rb532-pata.yaml b/Documentation/devicetree/bindings/ata/mikrotek,rb532-pata.yaml
> new file mode 100644
> index 000000000000..f74880c4fd82
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/mikrotek,rb532-pata.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/mikrotek,rb532-pata.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mikrotek RB532 PATA Controller bindings

We have a common binding for this (ata/pata-common.yaml). Really, all 
you'd gain is how to support 2 devices is defined. Should you use that? 
Is CompactFlash only a single device, I don't remember. If so, is that a 
limitation for the board or could 2 devices be supported?

> +
> +maintainers:
> +  - Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> +
> +properties:
> +  compatible:
> +    const: mikrotik,rb532-pata
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  gpio:

'<name>-gpios' is the preferred form (even for singular).

> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - gpio
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cf@18a10000 {
> +        compatible = "mikrotik,rb532-pata";
> +        reg = <0x18a10000 0xc04>;
> +
> +        gpio = <&gpio0 13 0>;
> +
> +        interrupt-parent = <&gpio0>;
> +        interrupts = <13 0>;
> +    };
> -- 
> 2.29.2
> 
