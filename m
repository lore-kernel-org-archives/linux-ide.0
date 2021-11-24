Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFD8C433F5
	for <linux-ide@archiver.kernel.org>; Wed, 24 Nov 2021 20:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbhKXUx7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 24 Nov 2021 15:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240489AbhKXUx7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 24 Nov 2021 15:53:59 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A44C061574;
        Wed, 24 Nov 2021 12:50:48 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id t5so16257837edd.0;
        Wed, 24 Nov 2021 12:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpsx3MMLlTBUydbXgUazzGgW2XNsr3KXIZIpZG5k49A=;
        b=G8Bz3qQ+YB6mQX6ayLZFC73394al/8xOPMOCkkW6avVNd3+hbxJaV9RVDlbI9jLfGu
         0hJ+wBWJhnT6V8NAEwOcX8BFShQHsBkVCxqZaVFIZmxyRh3gNFttaj0w2zvIA4VXt0+2
         2AOkceMmA96+Nwx5+4wyu+tLC2LLmvw2JENFvpM5YVWwfZUc2VL13LPe2mpxRlN6M/nq
         JceIJimvE45nZ/cEbSVvT8jKTLt1Rmf/MJR0u7JtXvlkVs3/y2c6J95JpZb9B1smwh/J
         NH7vfmWWqlMUw7bST8I0yQzQdkdqwRzs3RLaRiwjdW8e54URY35lkO2UYDMyDvKKCNvU
         0zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpsx3MMLlTBUydbXgUazzGgW2XNsr3KXIZIpZG5k49A=;
        b=rZ9rI5Ek5MFasdE1oBd5izVz0TfgcZJzgVJxkoYlxHb+RQZv4cSCkeqwDIbu1jab0V
         L4KerZSoc8826PGykfN5IRVSy16TlAM7IbeGQ5O3bvCRduBMHGnL7xgX5eXSQdZHJE4y
         yrAVe3xts8hhD97fNxwdeqk8id+2oAfLSbmLe1xOhZaTPoA+8KXdXYQfdeBmtA7jsh3V
         u+4EOYGYYSJ4FPi12f3C8dIW2gTSStJYCi95YT8NZ9SIagvBfODQ1w9UV6ef/7+98m09
         NpklN4fcRt3MZ06eojzRHdo/DnluZomY/MaEVT+IryCnxEuA/6/7BJ9suA7vvRaxpuHj
         chxQ==
X-Gm-Message-State: AOAM532Emz//u+Bd/OIH6kRK043cJ3J55AvNEDLdIqR8gM6n8BEubtsZ
        cYMy544ZXG/UoLByI8Lju8jBXMNtItma+fnkOCxsBc6cywxk7A==
X-Google-Smtp-Source: ABdhPJz3C3SCSsHACUDoYfKlRZ5A9P5v/4kiUjZrmr38Hwvl8IVPpBnfdYlh8WES9YYBz6HfvsFUR8prKuz6pwmEoSM=
X-Received: by 2002:a17:907:868f:: with SMTP id qa15mr24488031ejc.187.1637787047509;
 Wed, 24 Nov 2021 12:50:47 -0800 (PST)
MIME-Version: 1.0
References: <44e0213a681f3c8ee4c6ab2ef9d61ce3ac00e368.1637727935.git.fthain@linux-m68k.org>
 <CAMuHMdXTxTABOoVgC6fVR44dxUZZEbZV=ewSk9vKFY=U5u+fcw@mail.gmail.com>
In-Reply-To: <CAMuHMdXTxTABOoVgC6fVR44dxUZZEbZV=ewSk9vKFY=U5u+fcw@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Date:   Thu, 25 Nov 2021 09:50:35 +1300
Message-ID: <CAOmrzkJhXvN0gOU8fc5jNu3Q9LnT4dgCGdrznYbCbGXxq0dJpQ@mail.gmail.com>
Subject: Re: [PATCH] pata_falcon: Add missing __iomem annotations
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Finn Thain <fthain@linux-m68k.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

On Wed, Nov 24, 2021 at 8:51 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > --- a/drivers/ata/pata_falcon.c
> > +++ b/drivers/ata/pata_falcon.c
> > @@ -55,14 +55,14 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
> >         /* Transfer multiple of 2 bytes */
> >         if (rw == READ) {
> >                 if (swap)
> > -                       raw_insw_swapw((u16 *)data_addr, (u16 *)buf, words);
> > +                       raw_insw_swapw((u16 __iomem *)data_addr, (u16 *)buf, words);
> >                 else
> > -                       raw_insw((u16 *)data_addr, (u16 *)buf, words);
> > +                       raw_insw((u16 __iomem *)data_addr, (u16 *)buf, words);
> >         } else {
> >                 if (swap)
> > -                       raw_outsw_swapw((u16 *)data_addr, (u16 *)buf, words);
> > +                       raw_outsw_swapw((u16 __iomem *)data_addr, (u16 *)buf, words);
> >                 else
> > -                       raw_outsw((u16 *)data_addr, (u16 *)buf, words);
> > +                       raw_outsw((u16 __iomem *)data_addr, (u16 *)buf, words);
>
> Can't you just drop the casts? data_addr is an __iomem void *.

It's not u16 though, and the raw_ IO functions require that. But we
could cast data_addr as __iomem u16 * (compile tested).

Cheers,

    Michael

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
