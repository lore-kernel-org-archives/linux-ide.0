Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC5AC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 25 Nov 2021 07:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhKYHiy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:38:54 -0500
Received: from mail-vk1-f171.google.com ([209.85.221.171]:42629 "EHLO
        mail-vk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbhKYHgy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Nov 2021 02:36:54 -0500
Received: by mail-vk1-f171.google.com with SMTP id b125so3242936vkb.9;
        Wed, 24 Nov 2021 23:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugpVh5eVFcoLVCWRbPKzq92m0amK53xVN2bsl5MSGy0=;
        b=BRjrRgyM+A8McJ/YI5PBg6IXU2XGf3Flp97LxMYFG3celISig3ju7QESHhwH/9GHDa
         42MSvj3c8EI6Fnpn3noNt5Es0FbUOAlmZqo6QNdmR4sgUvCTL8AYKOk7H6jlsiEMXKeN
         apiI0ALbyxLK0sAS1gO/MR4sdlHT3GGrK2C40JQ1UVdwNMOQ6pNP5Bg3v05EAM4LI18q
         Pmb4L3/GKJzIoY0SE9I5H1aGFVxhTnL9v8mtHM1/l2OGsPSNWLguTZOpJn7yTWguf9DY
         oBC2ZSihRBfd8avU5NC1dk6WqB2lMSqGZQrCEvoavyM0E5bLyiuyShr8T7s+rvDypFaW
         XfrA==
X-Gm-Message-State: AOAM531ALBSaqame9OzAv/nPxy03jipBPFbA7faAf9Spzo5Id3SfDpLx
        HStHheR8vii2XdWtWgAfbD+DD2odWsfWbw==
X-Google-Smtp-Source: ABdhPJzi+HXCmPDOWGxSTgzMa52rO2qQxWXcSTOkIAm30J3VSnjVwmW5s4FosaloHqFShx2CbE0i0g==
X-Received: by 2002:a1f:d903:: with SMTP id q3mr2615955vkg.37.1637825622541;
        Wed, 24 Nov 2021 23:33:42 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id v8sm1234705vkc.52.2021.11.24.23.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 23:33:42 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id 188so3254327vku.8;
        Wed, 24 Nov 2021 23:33:42 -0800 (PST)
X-Received: by 2002:a05:6122:104f:: with SMTP id z15mr2634547vkn.39.1637825621983;
 Wed, 24 Nov 2021 23:33:41 -0800 (PST)
MIME-Version: 1.0
References: <44e0213a681f3c8ee4c6ab2ef9d61ce3ac00e368.1637727935.git.fthain@linux-m68k.org>
 <CAMuHMdXTxTABOoVgC6fVR44dxUZZEbZV=ewSk9vKFY=U5u+fcw@mail.gmail.com> <CAOmrzkJhXvN0gOU8fc5jNu3Q9LnT4dgCGdrznYbCbGXxq0dJpQ@mail.gmail.com>
In-Reply-To: <CAOmrzkJhXvN0gOU8fc5jNu3Q9LnT4dgCGdrznYbCbGXxq0dJpQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 25 Nov 2021 08:33:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXfFtn9b_2d5BQdzeyMH_puKJ8tzQeLu-Cw4dxfovcb5w@mail.gmail.com>
Message-ID: <CAMuHMdXfFtn9b_2d5BQdzeyMH_puKJ8tzQeLu-Cw4dxfovcb5w@mail.gmail.com>
Subject: Re: [PATCH] pata_falcon: Add missing __iomem annotations
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Finn Thain <fthain@linux-m68k.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Michael,

On Wed, Nov 24, 2021 at 9:50 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On Wed, Nov 24, 2021 at 8:51 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > --- a/drivers/ata/pata_falcon.c
> > > +++ b/drivers/ata/pata_falcon.c
> > > @@ -55,14 +55,14 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
> > >         /* Transfer multiple of 2 bytes */
> > >         if (rw == READ) {
> > >                 if (swap)
> > > -                       raw_insw_swapw((u16 *)data_addr, (u16 *)buf, words);
> > > +                       raw_insw_swapw((u16 __iomem *)data_addr, (u16 *)buf, words);
> > >                 else
> > > -                       raw_insw((u16 *)data_addr, (u16 *)buf, words);
> > > +                       raw_insw((u16 __iomem *)data_addr, (u16 *)buf, words);
> > >         } else {
> > >                 if (swap)
> > > -                       raw_outsw_swapw((u16 *)data_addr, (u16 *)buf, words);
> > > +                       raw_outsw_swapw((u16 __iomem *)data_addr, (u16 *)buf, words);
> > >                 else
> > > -                       raw_outsw((u16 *)data_addr, (u16 *)buf, words);
> > > +                       raw_outsw((u16 __iomem *)data_addr, (u16 *)buf, words);
> >
> > Can't you just drop the casts? data_addr is an __iomem void *.
>
> It's not u16 though, and the raw_ IO functions require that. But we
> could cast data_addr as __iomem u16 * (compile tested).

The raw_ IO functions do not require that: you can pass a void *
to a function that expects a different pointer type.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
