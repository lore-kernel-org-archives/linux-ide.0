Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250E7C433DB
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 22:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B3961921
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 22:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhCSWNu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Mar 2021 18:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhCSWNU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Mar 2021 18:13:20 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8D4C06175F
        for <linux-ide@vger.kernel.org>; Fri, 19 Mar 2021 15:13:20 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id x14so4560214qki.10
        for <linux-ide@vger.kernel.org>; Fri, 19 Mar 2021 15:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=akhwgBZwBqYs1E9EdtzwjwkaNd6XJZskQMI9Lvw5iuM=;
        b=oTwgt8i8faM+MHywMtUJEPpchwSSKMJ0jEG+SgCu+9kd+WIfS0MWTovDMaqNUS1/qQ
         V+vyN7USl8NnSrbZsJU6+hhvwvKBNJAOsBfez6B4yrLS0/Lhe+9I9brWbckJkc9sZtnH
         xpbIkyNrZ5Tm+eRlBhWoxc7Mbz1hgY0hXfWW7Pp3uJzF2f6v/zE4Sv3cmxB1piAtF8Pl
         hgVmL93yzB57fpepYfom/XmDw/iAPAOtZrPdQnh6m1+QmuEoCpU0jGVszH0r03WWadLV
         1Db5T666S43Yx0kBtQfV2LZyyucWORJaLsli3WIj544uYDSvQ6ae0VFcVvRtT0dSxwbw
         Z7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=akhwgBZwBqYs1E9EdtzwjwkaNd6XJZskQMI9Lvw5iuM=;
        b=CxnwmKyt/tqRHfNfQhAWTuJk4k/BTz4hc3oNfWzcb/54Gz+bfitE/qpU7hEethTgPj
         sSRilhkVdZFa/DbifHddNcAu7gLNXtE+8s+a8HzDiNJ8ekrQD+RxDAMVNjMFjrlWBrQY
         2pI648BzG1j3J9rBgqHAj0GQjaQj092PFhQvuJHqiX9Mp3grKXBFtyaFlC8FKCfntuaM
         mUjUztrYy/Z+DtUpocN7HQUAkfw9qPvgoePK9AtiupeSbHZiaoNjai0FB49PQa20aNPS
         +z/StWHyaMNXihVl/4poc62LLctsi3KSlUbOBOhEuGKv9nKikePx6E+QCpzrmv1Jrn3A
         ysrA==
X-Gm-Message-State: AOAM531m4YdAYeOvSskPaOvo2BJP87K0E7UmmlgKthBx2UmYXlge32o6
        c4BQ5jcB1M7VKRvyDDSzS4a6VNsiRWLgPJz/XSkozQ==
X-Google-Smtp-Source: ABdhPJznRAnFkGewB8R17TJbOZMWszFPk7NtesKeWagtbDQoOr3Hn35s9vADEAKDDhvHVVGNiwXO6wxMKq7oFQCRAsQ=
X-Received: by 2002:a37:9fce:: with SMTP id i197mr742271qke.155.1616191999457;
 Fri, 19 Mar 2021 15:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201109173948.96663-1-sven.auhagen@voleatech.de>
 <20210227105723.7i42cw376qmnozcp@SvensMacBookAir-2.local> <CAPv3WKfH_-ydZ4GXW8UUNuvWyT7xAXjPOLGVxt+X2svXt=PYdg@mail.gmail.com>
 <87czvviok9.fsf@BL-laptop> <CAPv3WKfiuV5h2m=579-3UajwBFtHB2MP5tdSvzxTZo+0MPnZNA@mail.gmail.com>
 <87wnu3h4hw.wl-maz@kernel.org> <CAPv3WKdfywQpBx0HpeBTAZ2G5U+jFVQ6We8J_WeK7sYgWNiuJg@mail.gmail.com>
 <c1bcbd5402f4af12@bloch.sibelius.xs4all.nl> <YFUPTlR/pFjxoKiF@lunn.ch>
In-Reply-To: <YFUPTlR/pFjxoKiF@lunn.ch>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 19 Mar 2021 23:13:09 +0100
Message-ID: <CAPv3WKct6PZq32-wLXrpwA+_0gU3nrA3ieMnvFWqda+GnQ2jyQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Armada8k enable per-port SATA interrupts and drop
 a hack in the IRQ subsystem
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Mark Kettenis <mark.kettenis@xs4all.nl>, maz@kernel.org,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Sven Auhagen <sven.auhagen@voleatech.de>, axboe@kernel.dk,
        Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        viresh.kumar@linaro.org, rjw@rjwysocki.net,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        linux-ide@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Jon Nettleton <jon@solid-run.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Andrew,

pt., 19 mar 2021 o 21:53 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> > Unfortunately ACPI doesn't describe how the SFP cages are connected.
>
> Nor MDIO busses and Ethernet PHYs.
>
> ACPI is missing a lot of support for basic elements of networking. I
> guess this is because it expects firmware in the NIC to be controlling
> these parts, not Linux.
>
> >
> > As soon as GPIOs and I2C busses are involved device trees are so much
> > better than ACPI
>
> Yes, ACPI has along way to go before it is usable for SoCs with
> integrated Ethernet.
>

I agree, however hopefully the MDIO + ACPI patchset, that currently
seems to be pretty advanced on the lists, will land - it will be a big
step forward and open a path for full SFP support. However, my point
is, that in case of MacchiatoBin, I prefer to use a bit limited link
IRQs, just for having a guarantee to boot each Linux kernel with mvpp2
starting from v4.16 until today and being sure to install various
distros/OSs/ESXI. For DT one have to find a matching version, that
luckily won't break the boot.

Of course the DT is more flexible and offers huge possibilities (e.g.
DSA), but the way it's been done, inherited straight from armv7
embedded-hacking times is imo a burden. Unstable, constantly changing
ABI, extending drivers rather than describe HW is too often a problem.
This patchset is a bright example that there is a field for
improvement.

In my ideal world DT should be properly designed (vendors+community),
out of Linux tree, reviewed by maintainers from different projects,
backward compatible and ensuring proper information/heads-up when
planning to do a meaningful change. I know how it looks and I'm aware
it is hard, but we should at least try :)

Best regards,
Marcin
