Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F98C433ED
	for <linux-ide@archiver.kernel.org>; Wed, 28 Apr 2021 06:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFA46141B
	for <linux-ide@archiver.kernel.org>; Wed, 28 Apr 2021 06:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbhD1Gyb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 28 Apr 2021 02:54:31 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:34728 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbhD1Gy3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 28 Apr 2021 02:54:29 -0400
Received: by mail-vs1-f51.google.com with SMTP id d25so24681894vsp.1;
        Tue, 27 Apr 2021 23:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qcj7/vi64EhvIZ063r8YI4RxRFbLfs3PNow3a+YW0lg=;
        b=cAf6/mnqHqiNQeHBaIyvNmZqvu+ZKQN1PDms4OPyi/+AcJGZicWBqJGrEiwdxKLfaa
         IcaENgQcasrWvyaoy75av4ukXV7DEAaofWRXaOEAqZP7x7kfM+KGkJP2Iwj0sQ1bVft9
         AyD9ZMSQWzKQXXbB7sNPwGy5BCbeD46h5oE7+wsm6SJ6bE3gj9KXO0bDz3A/Bh2U/q2v
         tNCo4WhxXY5GaxfRL4X/RPn0G21f3BFOBZA4KxPs+NZeSC/BqyKFVO+FP3Ihq5D4p9ZB
         SwGYXsSpeXQ99bbRWPlFE0EWx7onae6BdqOqdoR7hhASNlTPWjW3S3PmJQWE/XwtIwJ+
         CcoQ==
X-Gm-Message-State: AOAM531Dv13R6bucoaudH68z3V1YZHf9Uc4nHO14O0rCBY96YxlJuEjH
        HZZ3eo32D38/xnQTLHvgaf26ckAKz5+RRIo0PMY=
X-Google-Smtp-Source: ABdhPJyELbGS2kG/kxrsEFotGwuE+59fsAnvQWK55bL61m1yNIRT7/aVm3vglBf6ZYvQwO5jkVSO99DpOIS8s+tQ5cQ=
X-Received: by 2002:a67:8745:: with SMTP id j66mr23450138vsd.18.1619592824818;
 Tue, 27 Apr 2021 23:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <793432cca963b632709c4d1312baa9874d73e1d8.1619341585.git.fthain@telegraphics.com.au>
 <ba908b1d-eab5-a4e5-0c0a-2c745287d121@physik.fu-berlin.de>
 <10a08764-c138-9fe5-966c-ce68349b9b6@nippy.intranet> <65f01f42-31d9-522a-e690-73d286405a01@gmail.com>
 <9650358f-a789-7dbd-4495-1d39ff321ded@nippy.intranet> <ada88dd6-f8d7-11dc-9a89-5c7e437a0981@gmail.com>
In-Reply-To: <ada88dd6-f8d7-11dc-9a89-5c7e437a0981@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Apr 2021 08:53:33 +0200
Message-ID: <CAMuHMdUy_B_+pHZQpnDHYsee+gpXOs9ek_HaVxLjE2HVfGmLQg@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Replace macide driver with generic platform driver
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Finn Thain <fthain@fastmail.com.au>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@lst.de>,
        Joshua Thompson <funaho@jurai.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Michael,

On Tue, Apr 27, 2021 at 9:55 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 27/04/21 3:47 pm, Finn Thain wrote:
> > On Tue, 27 Apr 2021, Michael Schmitz wrote:
> >> On 26/04/21 7:37 pm, Finn Thain wrote:
> >>> Was macide the only IDE driver in Debian/m68k kernels without a libata
> >>> alternative? If so, this patch would allow you to finally drop
> >>> CONFIG_IDE.
> >>>
> >> There's still q40ide.c (ISA IDE interface, byte-swapped, so would need
> >> treatment similar to Falcon IDE). Hasn't been updated to a platform
> >> device yet.
> >>
> > AIUI, q40 support is not included in Debian/m68k kernel builds.
> I see.
> > I wonder whether q40 could re-use the pata_falcon driver . I suppose
>
> I'm pretty sure it could, but there is no reason why it would have to be
> crippled in that way. Interrupts should work perfectly fine with IDE on
> Q40.
>
> There is another reason why using the same module binary for both might
> fail - the awkward address translation code in io_mm.h. Not certain at
> all whether we can even have Q40 and Atari in the same kernel binary...

That's supposed to work, else our multi_defconfig is broken.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
