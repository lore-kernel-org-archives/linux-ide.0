Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269ECC71156
	for <linux-ide@archiver.kernel.org>; Fri, 18 Aug 2023 14:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347447AbjHROpd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Aug 2023 10:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352392AbjHROpB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Aug 2023 10:45:01 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8775D420C;
        Fri, 18 Aug 2023 07:44:50 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d63c0a6568fso982404276.0;
        Fri, 18 Aug 2023 07:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692369889; x=1692974689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OM1jw7Pl8HjW8nkz0WWffDpt1RK2G0XlpN+d0APEewU=;
        b=UukO6opIUeIxZdkH2GoKgNn66JM8zrqEz4PTtb2GNO1lIXdT+DYlco1OkXv26UwNFt
         iRPaKt6TUIgK1BKOPROO4LXdxe1l0/MPl9uqb7bY4AasvAZCTRpwyg39wMf3Vc/CjSQg
         O/xQmDDE+vobFPonppURZEmVcgHi07EVpMy4d7+1EOWIt7MmwpiPZwuiSfNhU9CkXHwp
         iBj+1UV5QmzPFOTUVBA1FpsQDE6VgLSFjRCRGy3kVzdudQWwOOcP+IGr9+bUsDlqG+5z
         llTD6/KEqok22PG5lT1WYgjtVyz+Ch00lHqrmixjar4JvdP5yI15zBX5nY4Iq7au0gG3
         mhFg==
X-Gm-Message-State: AOJu0YyCsxFkC//WIc+WHlN6fjaEUXlUVNmX3lpvLjKFPBOS4U/ee1+9
        bQ95HuzEZyH00BuncabOg/8Bp8tG6Oi1x4Hw
X-Google-Smtp-Source: AGHT+IFEQFx6cgBiUISKmD6xh4pnmI5TlSiTqRj8BBewZrncvLtoRCOa56+KOAa8rIH4WkAVSPj5iA==
X-Received: by 2002:a25:3296:0:b0:d3f:6caa:b56b with SMTP id y144-20020a253296000000b00d3f6caab56bmr2664252yby.39.1692369889349;
        Fri, 18 Aug 2023 07:44:49 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id m6-20020a056902004600b00c62e0df7ca8sm449100ybh.24.2023.08.18.07.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 07:44:48 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d63c0a6568fso982378276.0;
        Fri, 18 Aug 2023 07:44:48 -0700 (PDT)
X-Received: by 2002:a25:e087:0:b0:d12:77c7:b362 with SMTP id
 x129-20020a25e087000000b00d1277c7b362mr2965860ybg.26.1692369888655; Fri, 18
 Aug 2023 07:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230818071405.28581-1-schmitzmic@gmail.com> <20230818071405.28581-4-schmitzmic@gmail.com>
In-Reply-To: <20230818071405.28581-4-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Aug 2023 16:44:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUkzk9DxAicq7U5yp3LT0mzaP+tgbwcSYNFx7sripBDcg@mail.gmail.com>
Message-ID: <CAMuHMdUkzk9DxAicq7U5yp3LT0mzaP+tgbwcSYNFx7sripBDcg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] m68k/atari: change Falcon IDE platform device to
 id 0
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, will@sowerbutts.com, rz@linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Michael,

On Fri, Aug 18, 2023 at 9:14 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> The pata_falcon data byte swapping patch relies on pdev->id
> being 0 or 1. Q40 uses these IDs, but Atari used -1. Change
> pdev->id to 0 for Atari Falcon IDE platform device so
> selection of drive to byte-swap through pata_falcon.data_swab
> can be used on Falcon as well.
> Tested on ARAnyM so far.
>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

Iff this patch is accepted, it must go in before [PATCH v2 2/3], else
the latter would cause a regression. And backporting to stable must
take that into account, too.

Alternative, only consider pdev->id if it's positive?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
