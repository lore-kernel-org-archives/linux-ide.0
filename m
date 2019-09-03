Return-Path: <SRS0=jKCH=W6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6584CC3A5A2
	for <linux-ide@archiver.kernel.org>; Tue,  3 Sep 2019 12:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412CD20820
	for <linux-ide@archiver.kernel.org>; Tue,  3 Sep 2019 12:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfICMkR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:40:17 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46442 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfICMkR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 3 Sep 2019 08:40:17 -0400
Received: by mail-oi1-f194.google.com with SMTP id t24so12574954oij.13;
        Tue, 03 Sep 2019 05:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcH39V4DNdqQS6WWWsrApfpjkeKXVrVclWhhJQ/I6aQ=;
        b=r9rIiZzxHvE+k+MGoC11GOrQig7ooM+TdxoYBnmv3qLYzS4BgXiGsrX+WJleJ2ISYq
         TkpIkXtMfIzSEOjCCSq7oBLq0qdNrtPNcNrbco2xGT0yRtuh8LboIKB33UUo6LcugPCC
         I5aoxF/oOsM/5emUlr4xKhm43QFGx7+oEG8EtpO6Hbd7VrbqddiEVK+iBy8iGebrhDLY
         m/CCTotPfZzjm6YAQEifrTqURLH8O7ABgAPHJG7xjcaW60o3doOdrLlpRvs0MIQK+yJR
         hcJ6zOPDy0++sNr3phJ9dSxMzMF1enM2BWwoeCrdi8rsgJwH8GXitdkfV5vkIDpIpqDK
         WkUw==
X-Gm-Message-State: APjAAAW892Xck3ayBcjNk306NHYYz4v9NvqhSFFo5yiXSPy9C4Vri3dx
        mTfonhYXgOUkRgI9JcFSmtaajqh7Z4pawqsacHw=
X-Google-Smtp-Source: APXvYqxNTbUtrKsQicfzx0dq5ybjGYtIMhR3c5q1wWcUbPtErgqnr1MJ7HV/m49vtBHhBW7LUkXQpR+pLDsORIgB+Nk=
X-Received: by 2002:aca:f305:: with SMTP id r5mr3826728oih.131.1567514416285;
 Tue, 03 Sep 2019 05:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <1562018556-15090-1-git-send-email-schmitzmic@gmail.com> <1562018556-15090-2-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1562018556-15090-2-git-send-email-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Sep 2019 14:40:05 +0200
Message-ID: <CAMuHMdU405QPEk+w7n5tBtSWgeFPrvj44pbJSCi90N_-CxDFAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] m68k/atari: add platform device for Falcon IDE port
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Michael,

On Tue, Jul 2, 2019 at 12:02 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Autoloading of Falcon IDE driver modules requires converting
> these drivers to platform drivers.
>
> Add platform device for Falcon IDE interface in Atari platform
> setup code in preparation for this.
>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>
> --
>
> Changes from RFC
>
> - fix region size (spotted by Szymon Bieganski <S.Bieganski@chello.nl>)
> - define IDE interface address in atari/config.c, create platform device
>   always (suggested by Geert Uytterhoeven <geert@linux-m68k.org>)

Thanks for the update!

Looks good to me.  However, with just this patch applied, pata_falcon
fails with:

    pata_falcon: Atari Falcon PATA controller
    pata_falcon: resources busy

To avoid bisection issues, probably both patches should be combined into a
single patch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
