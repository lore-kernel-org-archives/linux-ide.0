Return-Path: <SRS0=j7Np=Y4=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D8BCA9ECF
	for <linux-ide@archiver.kernel.org>; Mon,  4 Nov 2019 10:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D3B20B7C
	for <linux-ide@archiver.kernel.org>; Mon,  4 Nov 2019 10:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfKDKbf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:31:35 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34785 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfKDKbf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 4 Nov 2019 05:31:35 -0500
Received: by mail-ot1-f68.google.com with SMTP id t4so2457802otr.1;
        Mon, 04 Nov 2019 02:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hX/9xpPqM4SzSR8yamk9pjmMqPcG2hVgjnAPhl2H6wE=;
        b=YPfbhEnufYzHrzM/Ba0lbjHS0Tvth9XDh3ai7iIzcNV9s5RECWGydFE+B0G8uiXWOh
         YhRhlFS4YliZDq1nOhDczJfikQiTWUAQKobRhAwMzAGR+6iauz6CkeCrsg9DJ08N41mU
         UltuvEgqpnlQx3mZDqaYxep2l0cgsXek/SKBIT+BfKe3J0KBDvsdtOkoHyuIP+G8tkNo
         lRfuaUZqMhdkgDkCmrmDGUmHs3iKvEhNE5TEUjL5nUIMSOKlhbMKRp4VGkQE0bGTTkpL
         Gnc+d5Rd5yneuCnkJ/nA5eKolkwtpVoTDZCPbskGDWM+DIXmE7gIZTod0ich3xP4mz1K
         hS7g==
X-Gm-Message-State: APjAAAU7bJKiicQ23/5u5Vgj+mZoX76FjCMldZRRIuoXrm+X1WvCKiVB
        YoGcS2A/aW7ifK0OZgpN4b4LCEoCOZrQSSFg3eE=
X-Google-Smtp-Source: APXvYqyGXQZu8U2Yj/YXwGoXDtG3Y1cRkrtsDkdCFzhgWLHzPKNKfR7aqdazkZ5SSswpahFM5cXBFYf2pDSurFwTRjw=
X-Received: by 2002:a9d:73cd:: with SMTP id m13mr18581325otk.145.1572863494191;
 Mon, 04 Nov 2019 02:31:34 -0800 (PST)
MIME-Version: 1.0
References: <1562018556-15090-1-git-send-email-schmitzmic@gmail.com>
 <1562018556-15090-3-git-send-email-schmitzmic@gmail.com> <CAMuHMdXeb2gUz92C-QqWmVLnpncArMkzgsJKNSz3F8J6ri89TQ@mail.gmail.com>
 <afe0f0bc-21fd-7e09-987b-4b13d2597f91@gmail.com>
In-Reply-To: <afe0f0bc-21fd-7e09-987b-4b13d2597f91@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Nov 2019 11:31:23 +0100
Message-ID: <CAMuHMdXSj_mz5cbT3qFykR-ZKVLYvrGYrE=0R2nTKmm2YM=3sw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers/ata: convert pata_falcon to arch platform device
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

On Wed, Sep 25, 2019 at 5:59 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 04.09.2019 um 00:44 schrieb Geert Uytterhoeven:
> > On Tue, Jul 2, 2019 at 12:02 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> >> The Atari platform device setup now provides a platform device
> >> for the Falcon IDE interface. Use this in place of the simple platform
> >> device set up in the old pata_falcon probe code.
> >>
> >> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

> >> +module_platform_driver_probe(pata_falcon_driver, pata_falcon_init_one);
> >
> > This doesn't seem to work in the builtin case (e.g. atari_defconfig with
> > ide replaced by ata): no hard drives are detected.
>
> Due to a dumb naming mismatch between driver and platform code
> (shouldn't have rushed this right before going on leave). This would
> have made the driver fail in the modular case as well.
>
> I'll fix that along with adding some error checking in the Atari
> platform init code.

OK.

> Regarding the potential bisection issue with this series - that ought to
> be fixed as well by renaming the platform resource to match what the new
> driver expects. I'd rather leave the two patches separate so the Atari
> platform code one can go through your tree.

No it isn't: the resource is still busy, and probing fails.
Hence I'll merge them.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
