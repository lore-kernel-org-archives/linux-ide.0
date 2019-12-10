Return-Path: <SRS0=HnBo=2A=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9C3C43603
	for <linux-ide@archiver.kernel.org>; Tue, 10 Dec 2019 15:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98112077B
	for <linux-ide@archiver.kernel.org>; Tue, 10 Dec 2019 15:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfLJPBT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:01:19 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41275 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbfLJPBT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Dec 2019 10:01:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so10029446oie.8
        for <linux-ide@vger.kernel.org>; Tue, 10 Dec 2019 07:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+BUr/bzEoFaU73wrvSWDizMhdHDf3kv8ZgZVmyRl1JE=;
        b=R/uBxSJ/m6QNJmYxX+xbcPXtP5IkjALhjdfCcGXd5uIEir1BWoAgEUsDkYGp8fgnW4
         df//7zK1dWjNk19SEVzp4KNda0bexY3ojnXpfwBGRrh4hPM9inuIzWsoP8fnZITAEWLs
         a3tMRHZY0LkwpGvrn4kzd8shBZ/vftBPwy+CcLpBLRZ08HkChXu9hyjAunsAbdYQi+Bz
         BkKxDP4JABKQxXPUwKfIapUAYVuvOoNCsOJcPYxjhO3ns5tBmNPQ/1EK7iB5pybPST5y
         sLEQzJUFmWkueakwWxHIDAkuaE1rIMMi3qfIdGqAti/kc2gw0FzlsSKdH2IXo4Jf0B5t
         YAJQ==
X-Gm-Message-State: APjAAAXYUmL9toTMrKKr0e6CamEz2uWvc6Qyj+tLROj2F7ZRc+Ol/aV5
        VJeD6KwAzNRINyhKrumLLZr9yiz0xT095OyZYac=
X-Google-Smtp-Source: APXvYqzjWq4IqfZSTYn8F6Wqu6ARVd0HEmWWuxxYOYYzPhIqv5q96kD24ZJnXdx3YvLWf3Ff3/jDraDCaHU7/Ogs550=
X-Received: by 2002:aca:4a41:: with SMTP id x62mr4097215oia.148.1575990078021;
 Tue, 10 Dec 2019 07:01:18 -0800 (PST)
MIME-Version: 1.0
References: <640aeac7-3b83-881d-848d-b851bcaa799f@physik.fu-berlin.de>
 <93395d37-8e03-a828-bd3b-fc0630ad8a2a@chello.nl> <4d63e34d-cca5-7fca-c20c-48a6c5cee3d3@physik.fu-berlin.de>
 <e996d8dd-f47a-ab57-208a-9ced59b29f2d@chello.nl> <44e682cf-85cb-d105-8b7f-199d097e5a6c@gmail.com>
 <94861220-0b7d-b4d1-c5f5-d2c152a27f34@chello.nl> <alpine.LNX.2.21.1906150913430.68@nippy.intranet>
 <f8d6c45a-17fc-eeac-e81e-72a1d1750c5d@gmail.com> <CAMuHMdXx-VHA6Vx=6jwN1ZV+W1ToWYPS1AMV9eJih8BQBC2P8g@mail.gmail.com>
 <9bbdd5c5-5e7a-1a17-930c-1f8e014df479@chello.nl> <0ee3677d-eceb-358a-62e5-df268f9e6a06@gmail.com>
 <0f48c0da-f455-631b-4bf5-602fdfb66566@chello.nl> <69cfda3c-0b1d-64c7-8f1f-132749a24e16@gmail.com>
 <b6a2249b-c460-bb28-cfa0-683d682788d7@chello.nl> <18208161-ef55-fc7c-8185-8127ad45fa26@gmail.com>
 <8e54ccd9-8830-f9d1-2ae8-63fc9be3462f@chello.nl> <CAMuHMdUg_xswJfMrLK-w7UoL-DJDFNS9hCK-AmuiDGs_qpiGpw@mail.gmail.com>
 <alpine.DEB.2.02.1912090653030.3616@scenergy.dfmk.hu> <alpine.DEB.2.02.1912101448061.3616@scenergy.dfmk.hu>
In-Reply-To: <alpine.DEB.2.02.1912101448061.3616@scenergy.dfmk.hu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Dec 2019 16:01:04 +0100
Message-ID: <CAMuHMdUmSbjHiudocvL-mL5xTkc-vOEBGGqQSax3G0JazBeqmg@mail.gmail.com>
Subject: Re: "BUG: soft lockup" on A1200; was: Re: Updated installation images
 for Debian Ports 2019-04-20
To:     "Karoly Balogh (Charlie/SGR)" <charlie@scenergy.dfmk.hu>
Cc:     Szymon Bieganski <S.Bieganski@chello.nl>,
        Debian m68k <debian-68k@lists.debian.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

CC linux-ide, as people there may be more familiar with the quirks and
caveats of SD2IDE adapters

On Tue, Dec 10, 2019 at 3:56 PM Karoly Balogh (Charlie/SGR)
<charlie@scenergy.dfmk.hu> wrote:
> On Mon, 9 Dec 2019, Karoly Balogh (Charlie/SGR) wrote:
> > > It would be interesting to know if other people with A1200s have
> > > issues with IDE or not....
> >
> > Sorry for bumping this thread after a few months, I just wanted to
> > report that I recently built a mainline 4.19.87 kernel with GCC 7.4.0,
> > (playing with some Buildroot thing) and I think I ran into exactly this
> > issue on my A1200.
> > (...)
> > If that's extra info, the same kernel works flawlessly in FS-UAE (with an
> > emulated A1200 IDE controller), so the problems only occur on real
> > hardware.
>
> OK, so I did some more tests:
>
> 1., I tried the PATA Gayle driver. This one fails to boot in UAE, seems to
> be able to probe the units, then unable to read blocks from them it seems.
> At least in FS UAE on my Mac. I could try to fetch a proper crashlog
> somehow... Note that the IDE Gayle driver works fine with the same
> emulator setup.
>
> 2., The PATA Gayle driver also locks up on my Amiga 1200 similar to the
> IDE Gayle driver.
>
> 3., Actually, it still might be a problem with the SD2IDE adapter. With
> the PATA Gayle driver, it doesn't even enumerate the master unit, just
> locks up. With the IDE Gayle driver, it shows the device on the bus, then
> locks up. When the lockup occurs, with the PATA Gayle driver, the HDD LED
> remains lit. With the IDE Gayle driver, it remains dark, but:
>
> If I try to boot the kernel from an actual 2,5" HDD (Samsung 40GB,
> relatively recent), none of the enumeration problems seem to be happening,
> and both the IDE driver and the PATA driver shows the partitions on the
> HDD properly, then waits to the root volume to appear. Sadly this HDD
> doesn't have a Linux root partition tho, and no disk space to make one. :(
> So can't boot further to test the system.
>
> For now, I ordered an SD2IDE adapter with another chipset, and I'll try to
> get a real hard disk, or any other device (maybe an IDE DoM or something)
> to test with. (But again, the problematic SD2IDE works with AmigaOS just
> fine, and also worked with NetBSD 7.1 at least, and as I have two of the
> same SD2IDE adapters, I tried with both, but both show the same symptoms.
> Also tried SD cards from multiple makers, made no difference, so it must
> be that SD2IDE model somehow.)
>
> Cheers,
> --
> Charlie
>
> (Ps: are these tests/sharing this kind of info is useful? I stop spamming
> if no one is really interested.)
