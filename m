Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E810DC6FA82
	for <linux-ide@archiver.kernel.org>; Sat,  3 Sep 2022 23:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiICXFd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 3 Sep 2022 19:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiICXFc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 3 Sep 2022 19:05:32 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BA22D1DA;
        Sat,  3 Sep 2022 16:05:30 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v5so5241433plo.9;
        Sat, 03 Sep 2022 16:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=39omKAyF6RwzyKDLT+sCvglcdUotBWfYiDY0pP8ioo8=;
        b=j+FhJIwhCCnr5WVBUSKUdj4rdRdQxN2yD9dzazujBHcNQE8tprsfHMQyRkKyLJSbPJ
         b36GdhnLQ1sCr8RStN/AzvLbqDEU33AvGkDsGEsfDz7uBEqAcQ3GKiYwD3E7MlS+m22Q
         XbZsHX1FIWMcI3F7Qg/2MhhEkJ+EEXw5B5rwhLiHVMQDTHOTGMPxXdOmIRc7JC10Vb5S
         76JRi0c6UL8ZNwzAh9U/riddaa7BoBqAMvJpxyart/i3q7s5Gocm6VMGo3JOdNjMsHSM
         vXw0BQ6F7UhvKASgGAw8xn437bazOkU3o9eJhW8PDNt+LTxn6urTD+G3GfVdE08V5GCB
         hBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=39omKAyF6RwzyKDLT+sCvglcdUotBWfYiDY0pP8ioo8=;
        b=tv9eV8KgAlU6fLteAr6qjK4SgssPv2schCzHNRVp9OqkP1SP9w3ZwSXK5fCPfNpKx1
         xR/LaBK7caqGVsSL9n+BJsJKhHgxwEw6O5JQGKoeSJTD+z6Q6FJt/Ss6c/ClPdlhhPPv
         m7Ev3mavzvZijkla7F5W84kkxdE33AWx+n5AvgjgXy4kNDecZR02nuvw3Sv7QTaHTw1O
         bUttAsIMKgra2LVKSgctlyyzyugf1mkfXP5lVIU0dEIGHt740Zsn30svTvC96ieQcTpu
         2plX81CA24aNXjyN85PjBpvxc8l1pkYnpd7sS/YfXYoIfFElf0Qb+XXWGBHwvMVjUooH
         Nr3A==
X-Gm-Message-State: ACgBeo1uvdIgJwhhiErs9mZgdPVu6NhOKkTelEJhOK6fGE7rSEHMGbgR
        Teu62HiKU3fJjGYN/9wYonqln2LTpX3ISlFzuPPdpURS+qA=
X-Google-Smtp-Source: AA6agR5c9VMfWN12MTK0qlLnFqVsCxtznoBMW/xorlpmzA2wyGVv+qyMfqF8XHlZHClMZJhmy5e6ntie2kihdczP3Bw=
X-Received: by 2002:a17:902:e5cc:b0:16f:1e31:da6c with SMTP id
 u12-20020a170902e5cc00b0016f1e31da6cmr41974605plf.66.1662246330350; Sat, 03
 Sep 2022 16:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220828204443.1954661-1-floridsleeves@gmail.com> <0b17a51f-1de7-600c-7379-c68cc8fbac60@wdc.com>
In-Reply-To: <0b17a51f-1de7-600c-7379-c68cc8fbac60@wdc.com>
From:   Li Zhong <floridsleeves@gmail.com>
Date:   Sat, 3 Sep 2022 16:05:19 -0700
Message-ID: <CAMEuxRppGCcmNjs7+TBG8Z82ShG2-Pj7dcLfVsb+tUK6GPeh6w@mail.gmail.com>
Subject: Re: [PATCH v1] drivers/ata/libata-core: check return value of sata_scr_read()
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Aug 29, 2022 at 6:38 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2022/08/29 5:45, Li Zhong wrote:
> > sata_scr_read() could return 0 on failure. Check the return value.
>
> Looks OK as a fix but the above sentence has a bug. 0 indicates success, not
> failure. So this should read:
>
> sata_scr_read() may fail with a negative error code. Check that function return
> value when reading the control register.
>
> Also, the patch title should be something like:
>
> ata: libata-core: Check errors in sata_print_link_status()
>

Thanks. Will fix it in the new version.

> >
> > Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> > ---
> >  drivers/ata/libata-core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index 826d41f341e4..ae08c7d35cb0 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -3021,7 +3021,8 @@ static void sata_print_link_status(struct ata_link *link)
> >
> >       if (sata_scr_read(link, SCR_STATUS, &sstatus))
> >               return;
> > -     sata_scr_read(link, SCR_CONTROL, &scontrol);
> > +     if (sata_scr_read(link, SCR_CONTROL, &scontrol))
> > +             return;
> >
> >       if (ata_phys_link_online(link)) {
> >               tmp = (sstatus >> 4) & 0xf;
>
> --
> Damien Le Moal
> Western Digital Research
>
