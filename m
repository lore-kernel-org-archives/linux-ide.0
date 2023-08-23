Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0401EE49A0
	for <linux-ide@archiver.kernel.org>; Wed, 23 Aug 2023 09:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjHWJYN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Aug 2023 05:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbjHWJVx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Aug 2023 05:21:53 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A41659C8;
        Wed, 23 Aug 2023 02:10:52 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-59231a1ca9eso26344457b3.1;
        Wed, 23 Aug 2023 02:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692781851; x=1693386651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wppR3OC0NNfgDsAa7KrzF1hDzSS0MVYBa/DcSmaU58Q=;
        b=F5X9CKZ5gewnQOcpnTlnUcC6OptVzVJ+tRmTGkbKbJ3xWuzLEXm5n3yI+dJBPTUp2N
         1on5Vhg5uQAft9k8ZSTcbvZlflZlfYnoCHeDSF4JAVKHjVkUNplAplUi6S6KliZT+iyK
         9k9tlHVBwiC2TVSMY4d7sUXxYppHjexnu/p05b5kutzd0haS1vgHg75s2Z+uB713/5VG
         +vq/CS6olwS56kirhIsJmg2bM69SLt4gmVY7aoOfQCtjb4t49FTnQmOngFaNVZtI6FV7
         X8fHK14Pcae9NuBt5NXqWNTcG9MM32K0itotejl+RxydFhGAL7Cds9+5OF4Yo9HEpPEw
         PKSw==
X-Gm-Message-State: AOJu0YwNJdDfVbnYSVVKBeifDFAA1ql7BRWcBiAS66hGcm14Q0gVxjsX
        1pArZRT7j348nAKcihB6Jjwk+2sk7o/KLw==
X-Google-Smtp-Source: AGHT+IGcp+jyujQjBb+b1HbUKO5s9d1F2lKPb7dIpEfWqMXSb8DdRatkrdcPtbbv1FmHaFiTYjtEYg==
X-Received: by 2002:a0d:df82:0:b0:583:c105:8501 with SMTP id i124-20020a0ddf82000000b00583c1058501mr12881147ywe.42.1692781851419;
        Wed, 23 Aug 2023 02:10:51 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id l74-20020a0de24d000000b00583d1fa1fccsm3241907ywe.0.2023.08.23.02.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 02:10:51 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d6b0c2cca0aso5208377276.0;
        Wed, 23 Aug 2023 02:10:51 -0700 (PDT)
X-Received: by 2002:a25:b202:0:b0:d3c:2cb2:f678 with SMTP id
 i2-20020a25b202000000b00d3c2cb2f678mr12653431ybj.64.1692781850843; Wed, 23
 Aug 2023 02:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230822221359.31024-1-schmitzmic@gmail.com> <20230822221359.31024-3-schmitzmic@gmail.com>
 <CAMuHMdWaDzG_FJPnc_YEBB7RYrNcwfceeN4QgB-3Z_7PFqCGUw@mail.gmail.com>
In-Reply-To: <CAMuHMdWaDzG_FJPnc_YEBB7RYrNcwfceeN4QgB-3Z_7PFqCGUw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Aug 2023 11:10:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWNfCHLx-nLy3C_afH2KpAMn18KdW=UjS+g5Rq16CWFiw@mail.gmail.com>
Message-ID: <CAMuHMdWNfCHLx-nLy3C_afH2KpAMn18KdW=UjS+g5Rq16CWFiw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ata: pata_falcon: add data_swab option to
 byte-swap disk data
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     sergei.shtylyov@gmail.com, dlemoal@kernel.org,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org,
        will@sowerbutts.com, rz@linux-m68k.org,
        Finn Thain <fthain@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Aug 23, 2023 at 11:10 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Aug 23, 2023 at 12:14 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> > Some users of pata_falcon on Q40 have IDE disks in default
> > IDE little endian byte order, whereas legacy disks use
> > host-native big-endian byte order as on the Atari Falcon.
> >
> > Add module parameter 'data_swab' to allow connecting drives
> > with non-native data byte order. Drives selected by the
> > data_swap bit mask will have their user data byte-swapped to
> > host byte order, i.e. 'pata_falcon.data_swab=2' will byte-swap
> > all user data on drive B, leaving data on drive A in native
> > byte order. On Q40, drives on a second IDE interface may be
> > added to the bit mask as bits 2 and 3.
> >
> > Default setting is no byte swapping, i.e. compatibility with
> > the native Falcon or Q40 operating system disk format.
> >
> > Cc: William R Sowerbutts <will@sowerbutts.com>
> > Cc: Finn Thain <fthain@linux-m68k.org>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Tested-by: William R Sowerbutts <will@sowerbutts.com>
> > Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> >
> > ---
> >
> > Changes since v2:
> >
> > Geert Uytterhoeven:
> > - only shift swap bitmask if pdev->id > 0
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Oops, I meant
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
But it never hurts to have more review tags ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
