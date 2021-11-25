Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFFFC433F5
	for <linux-ide@archiver.kernel.org>; Thu, 25 Nov 2021 07:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbhKYHpV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:45:21 -0500
Received: from mail-ua1-f48.google.com ([209.85.222.48]:41664 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349771AbhKYHnV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Nov 2021 02:43:21 -0500
Received: by mail-ua1-f48.google.com with SMTP id p37so10482061uae.8;
        Wed, 24 Nov 2021 23:40:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Xww3NmiLJg8wUoKC432ZnWMLq8MLYHwiXtDDzGojtg=;
        b=kkH41+E1MnsSGhvNufobE8N6ssD+chgtULuG5c5PFetYRdeNfV9GuVptUl0VxAWatT
         SAo7NjiskRn+/4LHIZrKnXwRlCb1EkqoJ/4jY0giGPCJy9eUHyCJ79LS1eYHYGRDIWkd
         4qqnaEtojy/xhT3DsJxrPEW1XLAB1kOToOyVhbuSQlqHn3bbNNbNqnZm7eIr0+Vtbv1b
         94CE8AvMmHIBRNitcby5l/F+cIVsRiVxq9AOLs8r2b/hmFfVfRVNCBosBdXsqIChZ8Ji
         ezz0kLVs2rRfqSMFgNLPS7uJaxjgXBPuFVZDybHTzyFX/5fX1b84WjsNHmeuaWeBrvwn
         jg5Q==
X-Gm-Message-State: AOAM533oJ566udOOlcNaCK1bns+K9pVOe7fc5PDwfad4urU9Xae+jXqF
        8WVVXfHPKsJBqNjt2O/7uHNjLfTWqQ2CRA==
X-Google-Smtp-Source: ABdhPJxMKPnYCHfMILvXueqVlLfPc8y6KRbt59Epoe4Hl8lhvi2INUzQqIVWB4g7v7d0D8HBtPJEPA==
X-Received: by 2002:a05:6102:dc7:: with SMTP id e7mr6400909vst.21.1637826009266;
        Wed, 24 Nov 2021 23:40:09 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 17sm1445511uaq.10.2021.11.24.23.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 23:40:09 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id m16so2339684vkl.13;
        Wed, 24 Nov 2021 23:40:08 -0800 (PST)
X-Received: by 2002:a1f:ac48:: with SMTP id v69mr7479303vke.0.1637826003913;
 Wed, 24 Nov 2021 23:40:03 -0800 (PST)
MIME-Version: 1.0
References: <44e0213a681f3c8ee4c6ab2ef9d61ce3ac00e368.1637727935.git.fthain@linux-m68k.org>
 <CAMuHMdXTxTABOoVgC6fVR44dxUZZEbZV=ewSk9vKFY=U5u+fcw@mail.gmail.com> <35a85d2f-ab6a-4ab7-85a8-626f1560a57d@linux-m68k.org>
In-Reply-To: <35a85d2f-ab6a-4ab7-85a8-626f1560a57d@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 25 Nov 2021 08:39:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXy-XyR5PtczK9J1p_i=jugp4yq6JF8_MhVC1FMK5dtPw@mail.gmail.com>
Message-ID: <CAMuHMdXy-XyR5PtczK9J1p_i=jugp4yq6JF8_MhVC1FMK5dtPw@mail.gmail.com>
Subject: Re: [PATCH] pata_falcon: Add missing __iomem annotations
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

On Thu, Nov 25, 2021 at 2:06 AM Finn Thain <fthain@linux-m68k.org> wrote:
> On Wed, 24 Nov 2021, Geert Uytterhoeven wrote:
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
> Yes, that works here (i.e. removing the data_addr casts and not the buf
> casts). But is it prudent?
>
> Given the implementation of raw_in/out is subject to change, it seems like
> the original casts were defensive programming.
>
> Here's an example of a recent regression that was fixed by casting a macro
> argument to a specific width:
>
> https://lore.kernel.org/linuxppc-dev/79ae1f49-f6b1-e9ad-977d-0cc7e553c7b9@csgroup.eu/
> https://lore.kernel.org/linuxppc-dev/08bbe7240b384016e0b2912ecf3bf5e2d25ef2c6.1636501628.git.fthain@linux-m68k.org/

Yeah, you do have to be careful with macros that derive a size from
the type of the passed data.  The *{in,out}sw() functions do not suffer
from that: they are defined to operate on a 16-bit I/O register.
It is very unlikely these semantics will ever change.

Here I'm more worried about the other danger: keeping casts will
silence any warning that may be introduced in a future change to the
driver code.

BTW, insw() and readsw() in asm-generic take void *.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
