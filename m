Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228C2C433C1
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 20:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE3B56197B
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 20:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhCSUro (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Mar 2021 16:47:44 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:62747 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhCSUrP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Mar 2021 16:47:15 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Mar 2021 16:47:14 EDT
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id c7471d42;
        Fri, 19 Mar 2021 21:40:32 +0100 (CET)
Date:   Fri, 19 Mar 2021 21:40:32 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     maz@kernel.org, gregory.clement@bootlin.com,
        sven.auhagen@voleatech.de, axboe@kernel.dk, hdegoede@redhat.com,
        robh+dt@kernel.org, tglx@linutronix.de, andrew@lunn.ch,
        devicetree@vger.kernel.org, antoine.tenart@bootlin.com,
        viresh.kumar@linaro.org, rjw@rjwysocki.net,
        maxime.chevallier@bootlin.com, linux-ide@vger.kernel.org,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
        linux-arm-kernel@lists.infradead.org, jaz@semihalf.com
In-Reply-To: <CAPv3WKdfywQpBx0HpeBTAZ2G5U+jFVQ6We8J_WeK7sYgWNiuJg@mail.gmail.com>
        (message from Marcin Wojtas on Fri, 19 Mar 2021 10:48:08 +0100)
Subject: Re: [PATCH v3 0/9] Armada8k enable per-port SATA interrupts and drop
 a hack in the IRQ subsystem
References: <20201109173948.96663-1-sven.auhagen@voleatech.de>
 <20210227105723.7i42cw376qmnozcp@SvensMacBookAir-2.local>
 <CAPv3WKfH_-ydZ4GXW8UUNuvWyT7xAXjPOLGVxt+X2svXt=PYdg@mail.gmail.com>
 <87czvviok9.fsf@BL-laptop>
 <CAPv3WKfiuV5h2m=579-3UajwBFtHB2MP5tdSvzxTZo+0MPnZNA@mail.gmail.com>
 <87wnu3h4hw.wl-maz@kernel.org> <CAPv3WKdfywQpBx0HpeBTAZ2G5U+jFVQ6We8J_WeK7sYgWNiuJg@mail.gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-ID: <c1bcbd5402f4af12@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

> From: Marcin Wojtas <mw@semihalf.com>
> Date: Fri, 19 Mar 2021 10:48:08 +0100
> 
> Hi Marc,
> 
> pt., 19 mar 2021 o 10:33 Marc Zyngier <maz@kernel.org> napisał(a):
> >
> > On Fri, 19 Mar 2021 08:08:34 +0000,
> > Marcin Wojtas <mw@semihalf.com> wrote:
> > >
> > > HI Gregory,
> > >
> > > pt., 19 mar 2021 o 08:35 Gregory CLEMENT <gregory.clement@bootlin.com>
> > > napisał(a):
> > > >
> > > > Hello Marcin,
> > > >
> > > > > [Resend in plain text]
> > > > >
> > > > > Hi,
> > > > >
> > > > > Just letting everyone know - merging only the DT part of this patchset
> > > > > broke AHCI on all Marvell Armada 7k8k / CN913x platforms in v5.11
> > > > > release.
> > > >
> > > > It's unfortunate that we didn't know this when v5.11-rc1 was
> > > > released. However it is still time for a fix, I will submit it.
> > > > As I explained in the other email when I applied this I really though
> > > > that the driver part will be applied, I don't know what happened here.
> > > >
> > >
> > > Sure, looking at the thread it looks more of a communication issue. I
> > > am also surprised the breakage went unnoticed for a while (unless
> > > everyone is using edk2, like myself :) ). I think it would be good to
> > > revert the change on top of v5.11.x. The drivers adoption would have to
> > > land before v5.12 though, so that not to repeat the problem during next release.
> > >
> > > Small rant:
> > > A general issue with the DT binding changes of this kind (previously
> > > clocks, ICU, etc.) that I have, is a side effect of incompatibility
> > > with older kernels/other OSs. The latter must follow the
> > > modifications, but you can forget of booting e.g. Debian Buster with
> > > the ToT device tree. Therefore in edk2 I do not update the device tree
> > > fork to often and need to tweak it in order to have the widest support
> > > coverage.
> >
> > Unfortunately, this has been the case for this machine since it became
> > available. I can happily boot any kernel on other systems of the same
> > vintage without touching anything firmware related, which is crucial
> > to identify regressions.
> >
> > The A8k requires instead a per-kernel DT, something that only works if
> > you treat it as an embedded system, and not a standard system (which
> > is why mine has been collecting dust for some time now). I don't think
> > the maintainers have ever been interested in solving this problem.
> >
> > As for ACPI, that'd probably be the best thing that can happen to this
> > platform. Not sure that's remotely possible though, given how
> > "interesting" the HW is.
> 
> ACPI has been up and running for this platform for a couple of years
> now, on MacchiatoBin you get USB, SATA, network ports, PCIE and even
> SD/MMC (the latter was merged in v5.11 kernel).

Unfortunately ACPI doesn't describe how the SFP cages are connected.

As soon as GPIOs and I2C busses are involved device trees are so much
better than ACPI, and I wouldn't really be interested in adding the
necessary OS support the network ports with ACPI in OpenBSD.

Cheers,

Mark
