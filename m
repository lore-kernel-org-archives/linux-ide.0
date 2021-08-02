Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF49C432BE
	for <linux-ide@archiver.kernel.org>; Mon,  2 Aug 2021 16:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD8660FC0
	for <linux-ide@archiver.kernel.org>; Mon,  2 Aug 2021 16:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhHBQbK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232532AbhHBQbK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 2 Aug 2021 12:31:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1DDA60EB2;
        Mon,  2 Aug 2021 16:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627921860;
        bh=deMa8sOm0fdhkN25Loqzex5y1RP38vfNesDvTc39xjc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SpXeyiGSPNRkJGspkbdiRDnovqwUkUDNmYX/6u+JYcoo1PRXTJwd8KeEfaqglByA8
         h6kdhR6W+snI5XiJKJJehwOXHSz2x0rnTCRESg+Mgkqzy/L84ke4YogKcwKCsSrJ1Y
         frT9ZTazeVcsh14B7O5mLsrUNU1i574ccKTt96s6Z7cUKxdI7e4yEs6yjRtXSjJkS/
         RosSWvFulGAAsfCtKhHVzMrfJHwBDnVZ823nKcTKmMgTo96rQCLVoDne+BagLcutEc
         3f8a0ww9PiU0w8sU52Y6XwJNPf2f61dYRWfRnxM4vOupULH+1AhV0PeBLIWcM2j7bQ
         +81LQOnoCr4qQ==
Received: by mail-qk1-f174.google.com with SMTP id b20so17127011qkj.3;
        Mon, 02 Aug 2021 09:31:00 -0700 (PDT)
X-Gm-Message-State: AOAM530r++mfFDtSkxauCt3siVSf38IMwDIB0q5Tu95doIaT/UtWt7tR
        tMAIPrChW1x3Pzqt7REjqHcDanbGBKnpMdSJDQ==
X-Google-Smtp-Source: ABdhPJz+eyBM2UvDe+jrkwi3o+EmAmoZheXdtqAU1s05R4CgbGZLOqf4Ggm2alR9tYSzYv0lQZ+Nrx8w/TZjee2t3bo=
X-Received: by 2002:a37:ef13:: with SMTP id j19mr16496359qkk.364.1627921859971;
 Mon, 02 Aug 2021 09:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210731213555.2965356-1-linus.walleij@linaro.org> <20210731213555.2965356-4-linus.walleij@linaro.org>
In-Reply-To: <20210731213555.2965356-4-linus.walleij@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 2 Aug 2021 10:30:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJkWtR_FevXZH7kGiHbFLbDypn-fy1W=twDYRVyn54wWQ@mail.gmail.com>
Message-ID: <CAL_JsqJkWtR_FevXZH7kGiHbFLbDypn-fy1W=twDYRVyn54wWQ@mail.gmail.com>
Subject: Re: [PATCH 4/5 v2] pata: ixp4xx: Add DT bindings
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sat, Jul 31, 2021 at 3:38 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
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

I'll assume this passes with the
'intel,ixp43x-expansion-bus-controller' schema present.

Reviewed-by: Rob Herring <robh@kernel.org>
