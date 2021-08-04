Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8FAC4338F
	for <linux-ide@archiver.kernel.org>; Wed,  4 Aug 2021 12:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F02860F22
	for <linux-ide@archiver.kernel.org>; Wed,  4 Aug 2021 12:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbhHDMkq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 4 Aug 2021 08:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbhHDMko (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 4 Aug 2021 08:40:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C18FC0613D5
        for <linux-ide@vger.kernel.org>; Wed,  4 Aug 2021 05:40:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id n17so1472560lft.13
        for <linux-ide@vger.kernel.org>; Wed, 04 Aug 2021 05:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gbbjr/HPtx9f7C74Fj3YfSdUYQxwWjsve6R9asXX9j4=;
        b=XDTU9DoH2XvkuXYpiO94yV4E7u/sYw78MGhhWsot155jTqR/INsiyl6UbXtMQYt3XO
         RTpUWFNt9EddUMg1ZELO/bK2V5cmwGBJy8pFQEM/KhUXKA/q2Gv9lz+io6OhAtpg/P5M
         s2xYwPiVFohWQUF3zFAKphNO7X5YCHEi7dVAELG2gdwHyC60HUFHSvtbP7QB4KiVF/ik
         QWphjtEiOYstrm6754K/XS2q1ySoH/6A2VNOzieTHlIbQTGVONEs7xms62Ti8dGWKBKT
         JO84lJ8r2bh1zsJYd9J1KImpBmJaSHGSJnHNuWNxN81wpOn/OGN5hj28kwtK9NkBeR/S
         Fq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gbbjr/HPtx9f7C74Fj3YfSdUYQxwWjsve6R9asXX9j4=;
        b=oQZFpMSvugvyJzyFPqWiquvPViCCvmIyfmh0VtXW7NPt3HJZh58EzSAJTFJ+mFrb9/
         te6HzkHF0ZSmUGLPLi81aQMlTIWKJqoDOMLwSJPSnPkHOHfX42Xtgdt2o8u9TBl/Ft/F
         e9xFbtopWB2JqXYF+W/DEd5XDhcojShhDS6rofoOwUEHQgTfFKz1N9fPy/zWnvlPTazz
         J9TIBnZmqghT0DjqRlmJlzcKFeuzoS8twB4+ROaQoWnO2gJcciIsnRpWiy4ZgfxbgvhE
         kHT+EVNjUkZKoUSEQzbfBVgtiWboK3SGLGzYHUwOkTkzGk9ZIkuqsBYeeJT5jveR2m/X
         xMeg==
X-Gm-Message-State: AOAM530yMY+3iZXRUyj4ic9IuBEYasA6Q2t36DG64fQ6uNQ8nSA4Y27S
        wJWU9xzM4jsBAB19nLQJa1/7jTmi2Z4siRH+HanTvg==
X-Google-Smtp-Source: ABdhPJzkI6Mc7+7v0iwyBjEXw7WKG0pSUwXL+KPm1hl90GtpjZmDv90l+kSWtsqISW7O/2IlokCZ0cRHqVrvTqpQkPQ=
X-Received: by 2002:ac2:4d0f:: with SMTP id r15mr12211393lfi.649.1628080830108;
 Wed, 04 Aug 2021 05:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210731213555.2965356-1-linus.walleij@linaro.org>
In-Reply-To: <20210731213555.2965356-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 Aug 2021 14:40:18 +0200
Message-ID: <CACRpkdbf9TfFyObuqCzOEe_QrS=Gru8i6x-1P7v_N-a11g_iiA@mail.gmail.com>
Subject: Re: [PATCH 1/5 v2] pata: ixp4xx: Use local dev variable
To:     Jens Axboe <axboe@kernel.dk>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sat, Jul 31, 2021 at 11:38 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> Let's simplify all &pdev->dev references by creating a
> local struct device *dev variable.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I will send a pull request to the SoC tree for all of these changes
since it has effect on device trees and the like.

Jens: if you prefer to take them through your tree, just yell!

Yours,
Linus Walleij
