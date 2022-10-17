Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8627C4332F
	for <linux-ide@archiver.kernel.org>; Mon, 17 Oct 2022 10:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiJQKh7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 17 Oct 2022 06:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJQKhz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 17 Oct 2022 06:37:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3164C5A17E
        for <linux-ide@vger.kernel.org>; Mon, 17 Oct 2022 03:37:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r14so15381909edc.7
        for <linux-ide@vger.kernel.org>; Mon, 17 Oct 2022 03:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=astfVBtSyKdKvd0fX3jHrBgZu0AnzDfSsMZqr5EJJDE=;
        b=KM4POit6QqElBFsIloDONBUeZOX6E1PExQRZ8zfvccQ3OU6r1EwiCdmbn/gEDK6GPr
         BgYGit1oxISahB9qFJk/Q6O5ARN8R+HgJQokxk4K3T9z95dB8v8IO9zarTv1QGnTdItS
         HeRRHHhoZYqnKzZB0x1FmLI1AVCSMTli4/jvAd3Ta7XOwVtub8aUD66WPI1vma4Qa38D
         OOWADfaIpngbV32+DL7wmfK/ltz+uS1vNSj+j4sqTiSkBElXGrCGv6uU1cG+ql0SIcKz
         0UzX2pnXBnVakm0xR/wdVtylpRAkIIDp1vaF4DwZhksMepDdaeKBQBuxZhel7I/arN9X
         45Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=astfVBtSyKdKvd0fX3jHrBgZu0AnzDfSsMZqr5EJJDE=;
        b=rtFNVqsDNLGrg2NaidAXbwZyPJpeMXSTcR07keO2q1aaLJdFvmxRhxUfmMEUtj+d4b
         y3Wx2JexUNSu3CIogwEpMm4mVGQmRV7envg2YYmJPx/4Ag5T26Bf/aIp+vhDnKGPUP2G
         +jkVGwf064Ro4VhWSpv5bzL2a3qpDgLkDhRwdI6Yf0Ux5gHtR8OsjkTUF0OC1sR+5RHp
         iQgAKSv47vKrA8GkaW5PGSKRjftifx9RZiQZcXp8Oy4v9fjyJRa6ieRRR26WRAg8T1Ve
         ZSHr4LIZmrIRkOa5iiVttKscFlJwDAG+tmxkRPbfvOsImmTgnKQX857hFcaI0Mb5ZAcp
         6BVw==
X-Gm-Message-State: ACrzQf2hey6hrCG1tr5ineW/Y5tzX/17p4RaRWdSd5t7yWsDQgjvvPPm
        XzEIe2nhIDiP+dchzt7osHS9HZ5DcMfFT1SuIuY4/A==
X-Google-Smtp-Source: AMsMyM59VzK7rtNlUbf5x+F09ZWS45bDB6OAcY3eDwpfVQgGBT551R2eyvVotDsWU6lwqI73+ETPSySEmtMnJqKQUyw=
X-Received: by 2002:a05:6402:d0b:b0:458:a244:4e99 with SMTP id
 eb11-20020a0564020d0b00b00458a2444e99mr9676438edb.46.1666003072753; Mon, 17
 Oct 2022 03:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221011135849.2785834-1-robh@kernel.org>
In-Reply-To: <20221011135849.2785834-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Oct 2022 12:37:41 +0200
Message-ID: <CACRpkdakvkRN29beYoMrcRvQkoNfLL0iTaN51q6V7-tSMLj6ig@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ata: Add 'ata-generic' binding
To:     Rob Herring <robh@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Oct 11, 2022 at 4:00 PM Rob Herring <robh@kernel.org> wrote:

> The 'ata-generic' binding has been around since 2008, but never
> documented.
>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> AFAICT, the ata-generic,use16bit property has no effect in Linux. The
> 32-bit transfers fallback to 16-bit if ATA_PFLAG_PIO32 flag is not set
> which it doesn't appear to ever be set. Looking at the history, the
> driver always used 16-bit mode.
>
> Linus, Okay with being maintainer here?

Yeah one more or less :)
But ATA was never my strong card. What about Sergey Semin?
He surely seems to be on top of ATA stuff. Or add us both.

Yours,
Linus Walleij
