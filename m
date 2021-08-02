Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CCEC4338F
	for <linux-ide@archiver.kernel.org>; Mon,  2 Aug 2021 13:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF2A560FF2
	for <linux-ide@archiver.kernel.org>; Mon,  2 Aug 2021 13:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbhHBNkF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Aug 2021 09:40:05 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:36424 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbhHBNkB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Aug 2021 09:40:01 -0400
Received: by mail-il1-f177.google.com with SMTP id c3so16442542ilh.3;
        Mon, 02 Aug 2021 06:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=TPqCih5l0C6m1DSrhG/f6ntG5cMzvXrUGP57eGfjKMk=;
        b=U3+46W7TlhMWrA0pVpuBCHyun8uWWGjoCk/SNE3ty+Z9zgmHftfO/it8OCmirVtbsE
         eYVK0S/JsKJeWM+HvXO6f1gwbsdgpFEo2ceNRqXQADmQLPvrw98DJ3wKHhP0OZ+7rhZh
         hJ+CxIOEUXRmyxw1u8lhaIP1x9Ni/efW3Xw4VY6//a34G6g3T5UDsJxtiUxCp00ifRmt
         WDjZM/VzOtKe+2mY3Wui+uiDtLL9n9jbZT9M7QSKGIfS7L/burRqmiemx7tt3CQ6L/h0
         MjjeTzzwOOSrN8jnPJxaf3YXrOh9D9F6qZUFjwj5c/YaJAamYXtor5QtHg6YXZzqxk99
         qZ/g==
X-Gm-Message-State: AOAM531uVkPrDIZEPx+H7OHdHzWhjOb48aca70E0WkFXT3oA2CTdG48v
        SGP4a4UE/S/VH7i9LYJBmw==
X-Google-Smtp-Source: ABdhPJzq2T8/91Rx7eO2vo6nY+3+tkdKu1Q0poPZmFXxr1CH+isnHEZbbaEntg25kJRXNflcW5epEg==
X-Received: by 2002:a92:c524:: with SMTP id m4mr4070980ili.42.1627911592227;
        Mon, 02 Aug 2021 06:39:52 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w17sm7215374iom.20.2021.08.02.06.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 06:39:51 -0700 (PDT)
Received: (nullmailer pid 918764 invoked by uid 1000);
        Mon, 02 Aug 2021 13:39:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Krzysztof Halasa <khalasa@piap.pl>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Imre Kaloz <kaloz@openwrt.org>, linux-ide@vger.kernel.org
In-Reply-To: <20210731213555.2965356-4-linus.walleij@linaro.org>
References: <20210731213555.2965356-1-linus.walleij@linaro.org> <20210731213555.2965356-4-linus.walleij@linaro.org>
Subject: Re: [PATCH 4/5 v2] pata: ixp4xx: Add DT bindings
Date:   Mon, 02 Aug 2021 07:39:43 -0600
Message-Id: <1627911583.076118.918763.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sat, 31 Jul 2021 23:35:54 +0200, Linus Walleij wrote:
> This adds device tree bindings for the Intel IXP4xx compact flash card
> interface.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Itemize the registers
> - Drop the epansion bus set-up to alleviate warnings
> ---
>  .../ata/intel,ixp4xx-compact-flash.yaml       | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/ata/intel,ixp4xx-compact-flash.example.dt.yaml:0:0: /example-0/bus@c4000000: failed to match any schema with compatible: ['intel,ixp43x-expansion-bus-controller', 'syscon']
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1511976

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

