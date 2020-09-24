Return-Path: <SRS0=07Tt=DB=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC627C2D0E2
	for <linux-ide@archiver.kernel.org>; Thu, 24 Sep 2020 07:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81AC5235F7
	for <linux-ide@archiver.kernel.org>; Thu, 24 Sep 2020 07:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgIXHW3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Sep 2020 03:22:29 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40529 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbgIXHW3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Sep 2020 03:22:29 -0400
Received: by mail-ot1-f67.google.com with SMTP id c2so199965otp.7;
        Thu, 24 Sep 2020 00:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=doJWUSEuMMX5XwNCFHPsthPQ0ya9qYj2kuRu85qUti0=;
        b=E9ygRWcRUTJFflTne/vC4Rcsm01qjd3z1JoZ+Cef5O2GVw7rENIk5iyi5BRosKxAl3
         1q7GmP4wiqLyvd25g+iPdGAkJf+YHnwJoLGAlFt3WGbNc4Kvty0UhPgTnFT7eb1OE/8k
         kqq38Rdg/QGkBxVEUEzED4TqGJkoTKb+4Hn15Upa6IVhTqKt4qyUU8EURyTdYMU2kMVL
         iItVXuc1zAhZ+idgJI2npv6l+ips+X91tH479Hpeb1LQYFxkSHvRIn56XfWg4xzuebWn
         8dIeEIAbi/kaoX+2dUkzZFG9wGdU0TsJnmWQCkPGd1NMj9kDWLGAWjxf+tbltN8BQgZg
         Qzhg==
X-Gm-Message-State: AOAM5304K3+zxfB5ejy2BKEPBgIiFppUkrH6BzcjlBgOnBnbYAtuKSic
        iQxnvOSv1wt32j9OdtfDHNX+E60gOce3LnRa2s4=
X-Google-Smtp-Source: ABdhPJwjrYu9v7nTc+tMgh9KYdsuHGvFOqnkyNOKYLmjSPS5VINKugoRgAsR/1ACTFe/LzcZfS+u3Zu/r8tn/L3D59A=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr2062693otp.107.1600932148967;
 Thu, 24 Sep 2020 00:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <edd106dad1bbea32500601c6071f37a9f02a8004.1600901284.git.fthain@telegraphics.com.au>
In-Reply-To: <edd106dad1bbea32500601c6071f37a9f02a8004.1600901284.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Sep 2020 09:22:17 +0200
Message-ID: <CAMuHMdXb=bPg=tsmCfTFj_asSyeE=MF=MxmeobUKv0qbHDisig@mail.gmail.com>
Subject: Re: [PATCH v4] ide/macide: Convert Mac IDE driver to platform driver
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

On Thu, Sep 24, 2020 at 1:17 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> Add platform devices for the Mac IDE controller variants. Convert the
> macide module into a platform driver to support two of those variants.
> For the third, use a generic "pata_platform" driver instead.
> This enables automatic loading of the appropriate module and begins
> the process of replacing the driver with libata alternatives.
>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Joshua Thompson <funaho@jurai.org>
> References: commit 5ed0794cde593 ("m68k/atari: Convert Falcon IDE drivers to platform drivers")
> References: commit 7ad19a99ad431 ("ide: officially deprecated the legacy IDE driver")
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
> This patch was tested successfully on a Powerbook 190 (MAC_IDE_BABOON)
> using both pata_platform and ide_platform drivers.
> The next step will be to try using these generic drivers with the other
> IDE controller variants (MAC_IDE_QUADRA or MAC_IDE_PB) so that the macide
> driver can be entirely replaced with libata drivers.
>
> Changed since v3:
>  - Updated Kconfig help text.
>
> Changed since v2:
>  - Enabled CONFIG_BLK_DEV_PLATFORM in multi_defconfig.
>  - Replaced dev_get_drvdata() with platform_get_drvdata().

Thanks for the updates!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.10 branch, hopefully with an
Acked-by from the IDE maintainer.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
