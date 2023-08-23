Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF57EE49A0
	for <linux-ide@archiver.kernel.org>; Wed, 23 Aug 2023 09:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbjHWJYt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Aug 2023 05:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbjHWJVn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Aug 2023 05:21:43 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637DD4224;
        Wed, 23 Aug 2023 02:10:20 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-58fba83feb0so41622237b3.3;
        Wed, 23 Aug 2023 02:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692781819; x=1693386619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMzl4BCA4DRK0lVs2u4Le4t7NjTwoBo2Uy8T/CZNDNA=;
        b=UTs1/WXyezY1ZCT6o36w904awdjyTNc/0K05Ys1W+sGVBdgocExLU2Lqz1juvEDJdb
         0YLLsH1sVl1NQyynQlyriddwonNVin71P9Ho8Rmn4Hnbwp1vGtE0mVlOFjml/TKs4cKe
         mUe2IKe5nVps1uKTBAPQvIRHewQWjsveJReHk7iXpfTwzUFXcrGwP+AOqY70PbUwEUKI
         cs5Jm2q+eo9De5/hBROZ8WfX2F4Kjef9sX4YMsMcYVAoS6sLTIARnyS+1TrNk0lsNOfS
         vFNKYUXO3EqskFKcYUCDvso8ChDSpFEwar4qDsaud+WVqIvvgdOOES+fVvdOFxtn7rN9
         DTUQ==
X-Gm-Message-State: AOJu0YxhmqanqiFH7OBtBleNdJacDImHc2EfmK5y5N3O1CkIRTbM+g73
        lKBA5S0Rzd4wsz7dn32nFLl/n6oeuf3qWQ==
X-Google-Smtp-Source: AGHT+IGOBImwo3b34QiGySjbOWRxFagPOaNTFZ6splzu43TSjVMcZaprVgnSXVJNOeGjdlel67CWEA==
X-Received: by 2002:a0d:e291:0:b0:58c:873e:3174 with SMTP id l139-20020a0de291000000b0058c873e3174mr9646373ywe.6.1692781819315;
        Wed, 23 Aug 2023 02:10:19 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id a186-20020a0df1c3000000b005840861b15fsm3248693ywf.13.2023.08.23.02.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 02:10:19 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d7260fae148so5351079276.1;
        Wed, 23 Aug 2023 02:10:18 -0700 (PDT)
X-Received: by 2002:a25:9782:0:b0:ca2:f20:4139 with SMTP id
 i2-20020a259782000000b00ca20f204139mr10885616ybo.64.1692781818517; Wed, 23
 Aug 2023 02:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230822221359.31024-1-schmitzmic@gmail.com> <20230822221359.31024-3-schmitzmic@gmail.com>
In-Reply-To: <20230822221359.31024-3-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Aug 2023 11:10:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWaDzG_FJPnc_YEBB7RYrNcwfceeN4QgB-3Z_7PFqCGUw@mail.gmail.com>
Message-ID: <CAMuHMdWaDzG_FJPnc_YEBB7RYrNcwfceeN4QgB-3Z_7PFqCGUw@mail.gmail.com>
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

On Wed, Aug 23, 2023 at 12:14 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Some users of pata_falcon on Q40 have IDE disks in default
> IDE little endian byte order, whereas legacy disks use
> host-native big-endian byte order as on the Atari Falcon.
>
> Add module parameter 'data_swab' to allow connecting drives
> with non-native data byte order. Drives selected by the
> data_swap bit mask will have their user data byte-swapped to
> host byte order, i.e. 'pata_falcon.data_swab=2' will byte-swap
> all user data on drive B, leaving data on drive A in native
> byte order. On Q40, drives on a second IDE interface may be
> added to the bit mask as bits 2 and 3.
>
> Default setting is no byte swapping, i.e. compatibility with
> the native Falcon or Q40 operating system disk format.
>
> Cc: William R Sowerbutts <will@sowerbutts.com>
> Cc: Finn Thain <fthain@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: William R Sowerbutts <will@sowerbutts.com>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>
> ---
>
> Changes since v2:
>
> Geert Uytterhoeven:
> - only shift swap bitmask if pdev->id > 0

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
