Return-Path: <SRS0=j7Np=Y4=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D3CC47E49
	for <linux-ide@archiver.kernel.org>; Mon,  4 Nov 2019 10:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFA021D7D
	for <linux-ide@archiver.kernel.org>; Mon,  4 Nov 2019 10:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfKDK5I (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:57:08 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46990 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfKDK5I (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 4 Nov 2019 05:57:08 -0500
Received: by mail-ot1-f66.google.com with SMTP id n23so3742865otr.13;
        Mon, 04 Nov 2019 02:57:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pGQ4gD0I1FZ6dwxxybtlK40/QHMirWL/gzWuIysg0DM=;
        b=dPDw6SbAnkn1VbhRaRocLDEMxnotZTh0UkYvR9Mc4xelICw/ohbjCUA96M3VneZbyL
         eWW8SjZuTLRFdk1sWVPZB0x5WjQ+tMxbnK5x4ZpYgZYRGjsfvYIDvKzlci1zYgd2Hp7o
         v9geefMdT9CaijZpXUqNPJHlQp4gIg+Ina7vjaHV3PEm1iTYKPViNNckbtOE0VMQuLPa
         1Z3HvYUSbS0IXXiQcaBuft7BoNPfRXNpPDuBIlzExOQjUGtZMF6lBrnuCggezi8JG48Z
         bbtzdLXs7C1gtZVaY3jcHxQ8LT0+Tbwb+Y7nrO+bR79QzupONvc9mRrzO0GYz4heCd71
         HIGQ==
X-Gm-Message-State: APjAAAWTfHgPT+vrjTTo8EkFDC/KGZ0+6ER0DaAGTDuX+TG2FB+8vZHm
        RiGU+iUpV7vzt69p/hRqCJmxnNxFiGbDYcJbpX8=
X-Google-Smtp-Source: APXvYqwC8wqBGh0YvOC7EMnHt6kRo2jwjscRoETKpSbjobHIoNnISKPDJ5z8r8yhrmJ4RAVCLpUJN0cfgZZQODTj3rI=
X-Received: by 2002:a05:6830:2363:: with SMTP id r3mr14984160oth.39.1572865026350;
 Mon, 04 Nov 2019 02:57:06 -0800 (PST)
MIME-Version: 1.0
References: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com> <1569470064-3977-2-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1569470064-3977-2-git-send-email-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Nov 2019 11:56:55 +0100
Message-ID: <CAMuHMdULi8F8Ky4VxiQew25p5vOTQuf1tXrg7Dx-6aRu1Tj3qw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] m68k/atari: add platform device for Falcon
 IDE port
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

On Thu, Sep 26, 2019 at 5:54 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Autoloading of Falcon IDE driver modules requires converting
> these drivers to platform drivers.
>
> Add platform device for Falcon IDE interface in Atari platform
> setup code in preparation for this.
>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>
> --

This should be a triple dash.

>
> Changes from RFC
>
> - fix region size (spotted by Szymon Bieganski <S.Bieganski@chello.nl>)
> - define IDE interface address in atari/config.c, create platform device
>   always (suggested by Geert Uytterhoeven <geert@linux-m68k.org>)
>
> Changes from v1
>
> - add error checking for Falcon IDE platform device register

Thanks for the update!

> --- a/arch/m68k/atari/config.c
> +++ b/arch/m68k/atari/config.c
> @@ -939,6 +959,13 @@ int __init atari_platform_init(void)
>                         atari_scsi_tt_rsrc, ARRAY_SIZE(atari_scsi_tt_rsrc));
>  #endif
>
> +       if (ATARIHW_PRESENT(IDE)) {
> +               pdev = platform_device_register_simple("atari-falcon-ide", -1,
> +                       atari_falconide_rsrc, ARRAY_SIZE(atari_falconide_rsrc));
> +               if (IS_ERR(pdev))
> +                       rv = PTR_ERR(pdev);
> +       }
> +
>         return rv;
>  }

This breaks both falconide and pata_falcon, as it marks the resource
busy:

    ide: Falcon IDE controller
    falconide: resources busy

and

    pata_falcon: Atari Falcon PATA controller
    pata_falcon: resources busy

For pata_falcon, that regression can easily be fixed by merging both patches.
For falconide, I think the sensible thing to do is just remove the driver.
But before that, the defconfigs should be updated to use pata_falcon
instead of falconide.

For the actual code changes:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
