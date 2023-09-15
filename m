Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D15EE6447
	for <linux-ide@archiver.kernel.org>; Fri, 15 Sep 2023 08:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjIOIrb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 15 Sep 2023 04:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjIOIrb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 15 Sep 2023 04:47:31 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB94C2719
        for <linux-ide@vger.kernel.org>; Fri, 15 Sep 2023 01:47:20 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d801c83325fso1860125276.0
        for <linux-ide@vger.kernel.org>; Fri, 15 Sep 2023 01:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694767640; x=1695372440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuvVotKpBcP3UXhgRGN47JnMhQ/d+HXg646hFgnvAdk=;
        b=o6TfgoUxHI5cBoegEcsUmulMvQQZW6sSGJR9jTa9rjt1cmKrhCF3bpZdk7Uo+elQQq
         GYSEMlp9RchLNYHV0EBojwWg5w4QT2FsXVL57sKXF866RP1k/YmWvuYeAePT8t26lhOr
         Z2H2i6hIOO5PU6RgWJHetRrcNNCY/n5ThrQ7W30sx9wQKMPKtg68Tug9XviFakr0uhJj
         LC/9rNYN1KMEk7q8OGCntNO+UANYeyREXLCXDTpnTxioAHILAaHbFU2wwtJ4OkPVygT4
         v9sAMpE/Wj6kCbS9yuacl+PpNADXOuOQJ8K8B8ZtemcexTBVl4X6TwcegSIMXj+8LrmZ
         UTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694767640; x=1695372440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iuvVotKpBcP3UXhgRGN47JnMhQ/d+HXg646hFgnvAdk=;
        b=au5SCpCtokSPmhwcyMnLy/WI7B88vLbmIRX2i4a8WxgWtFsexV2JZud8qY2NK6OS9t
         c8Ft882rbQAdPF6lzOtGnX1EurBhjQopaqh7MObzqY9NLMHgC1qA8O19GEe5tsUWWRMB
         UyArrOLs4ZtiBs512IgtHoRrf3LFqPgn/75/F/fKNg8FXXpbKt0WjNjIa9anN/KzwEPg
         Eym769TViH9nCzhzAElD/rjAspPu/i0PpOTLBCTrlkCAjxC8ckaOoc4cLWrV38oCPr+W
         J0ljxzN3739bwvZ/yed3rT3SoL1vNJs7VLFx81wu6WPfiTdIudpaeXYA8hTjIwDoeqZu
         PGRA==
X-Gm-Message-State: AOJu0YyOR72QmSHz0xEf4o97Rmc0SWbgyjKmXlx569p1sGF/aaaTGml6
        lVtLGfCbCvlZ1NgCRjLT0SgfsPT2mnfjYSX6ifyzIg==
X-Google-Smtp-Source: AGHT+IECDorVo8VjAx+jDFBwvuoWYNY0J/1bRwiUh62Cox0mhsXwvBSj//oORy3ZwY2thNcc8JKGN8rdCLaLcYi0UEQ=
X-Received: by 2002:a25:e010:0:b0:d09:544a:db1b with SMTP id
 x16-20020a25e010000000b00d09544adb1bmr879376ybg.34.1694767639929; Fri, 15 Sep
 2023 01:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me> <20230915-ep93xx-v4-38-a1d779dcec10@maquefel.me>
In-Reply-To: <20230915-ep93xx-v4-38-a1d779dcec10@maquefel.me>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 Sep 2023 10:47:08 +0200
Message-ID: <CACRpkdaRE5LeAZsFiDmeU3iZvaX3a4BrBOHT51aJV8YVH98RoQ@mail.gmail.com>
Subject: Re: [PATCH v4 38/42] ata: pata_ep93xx: remove legacy pinctrl use
To:     nikita.shubin@maquefel.me
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Sep 15, 2023 at 10:12=E2=80=AFAM Nikita Shubin via B4 Relay
<devnull+nikita.shubin.maquefel.me@kernel.org> wrote:

> From: Nikita Shubin <nikita.shubin@maquefel.me>
>
> Drop legacy acquire/release since we are using pinctrl for this now.
>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Acked-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
