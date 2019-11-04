Return-Path: <SRS0=j7Np=Y4=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0BCC47E49
	for <linux-ide@archiver.kernel.org>; Mon,  4 Nov 2019 10:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C45C21D7D
	for <linux-ide@archiver.kernel.org>; Mon,  4 Nov 2019 10:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfKDK62 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:58:28 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33201 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbfKDK61 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 4 Nov 2019 05:58:27 -0500
Received: by mail-oi1-f196.google.com with SMTP id m193so13706584oig.0;
        Mon, 04 Nov 2019 02:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HOQkH2KS03U7K6gMvBKfRvzbmw+kx4YDjIamPXg+S8Y=;
        b=ZDj2iz+qk3+IVawnTVBib78bkfqSydKNakD+a0yiw2c+k9tuzRJtc6uO6EBFzEDr1K
         gT5SbfcgL4k3/tjycXd2J1cm1kUVECMoTz7jSRvQg2UpivDfA5xJPVnPDdQgCnH89YWq
         vR05wivjXly+Inf1Rd3PyMDpopdXJuc2Q8zXGCI2ubRF2DjMl5K+xH0gVqnNx+ahTwhi
         VDj//xRK5TNo1kN20mzHEsI0nuTK70p7IduzRNsd8g/4Zo23jEZ5Uuf/WVr2nKoD6mdX
         LYdgljmfD3oGkA3Ztz9GjRc2uN+AToqXgaNYdo+WesyZ64J1ArL0hsA6Cn394n547dRW
         bBvA==
X-Gm-Message-State: APjAAAVnpSjQZN8aaNz7nWD4n/c+mLrOfCPjEFLIJ2mFD2ErNKXfN91Y
        W0jt0V9/3bcsfmbdRHaY/voyIEa6V8de5YbvDVg=
X-Google-Smtp-Source: APXvYqy0SFQrsYBRJVGzrWOjid8x6rBsnfbm0P2tkwHtDlgm1mTkR58CLxzQssXw57acPAW03IS978IjVygoGXqwwN0=
X-Received: by 2002:aca:4ac5:: with SMTP id x188mr1737484oia.148.1572865106728;
 Mon, 04 Nov 2019 02:58:26 -0800 (PST)
MIME-Version: 1.0
References: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com> <1569470064-3977-3-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1569470064-3977-3-git-send-email-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Nov 2019 11:58:15 +0100
Message-ID: <CAMuHMdUWpNp286PoqUHqtktE9V-q6eiH4uJEH0DYh4BF6SHZ+w@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 2/2] drivers/ata: convert pata_falcon to arch
 platform device
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
> The Atari platform device setup now provides a platform device
> for the Falcon IDE interface. Use this in place of the simple platform
> device set up in the old pata_falcon probe code.
>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>
> --

Should be a triple dash.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Minor nit below.

> --- a/drivers/ata/pata_falcon.c
> +++ b/drivers/ata/pata_falcon.c
> @@ -120,24 +119,22 @@ static int pata_falcon_set_mode(struct ata_link *link,
>         .set_mode       = pata_falcon_set_mode,
>  };
>
> -static int pata_falcon_init_one(void)
> +static int __init pata_falcon_init_one(struct platform_device *pdev)
>  {
> +       struct resource *res;
>         struct ata_host *host;
>         struct ata_port *ap;
> -       struct platform_device *pdev;
>         void __iomem *base;
>
> -       if (!MACH_IS_ATARI || !ATARIHW_PRESENT(IDE))
> -               return -ENODEV;
> -
> -       pr_info(DRV_NAME ": Atari Falcon PATA controller\n");
> +       dev_info(&pdev->dev, ": Atari Falcon PATA controller\n");

Please drop the ": ".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
