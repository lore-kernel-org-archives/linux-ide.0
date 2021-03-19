Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510C6C433E0
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 08:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2484C64F68
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 08:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhCSIJO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Mar 2021 04:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbhCSIIp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Mar 2021 04:08:45 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0E9C06175F
        for <linux-ide@vger.kernel.org>; Fri, 19 Mar 2021 01:08:45 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c4so2012617qkg.3
        for <linux-ide@vger.kernel.org>; Fri, 19 Mar 2021 01:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O0/6ovKk6e5e9v6C+r5vC4t97AsQ1nSKAQGB3wUp3R8=;
        b=xoea1+ttxpXo14phYMldJAKtZliRDt3pJfxB9BchVuSX13moGzFDAx6dr8WKFISuX7
         gIxmI/jTC+70ICwPXIqIG8DrgI3bRy0Oo8sg7iywQQtfpfsBuAWNVZRakjHHsyLfezNe
         4UM/OTupfw2eTba+yodxgaaMOiBy/DCF4RrviN3ojsYZpyfLJ1GArqFON+51o9qejNcQ
         Jz9CGmTPV7gMvARCENI4FuU0Pagbvcx5eKyeQt+IhlG9AKjqthmRnu4W+/eUmBOC6Ik7
         kPLTEB1AlgzCdFHuTtSYIwEo21oe8RXjx5i9i7p9HsYLBEybYd+pBn2KC8jWBInheNHU
         5oJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O0/6ovKk6e5e9v6C+r5vC4t97AsQ1nSKAQGB3wUp3R8=;
        b=gtWzv3jGkvNJgtMFmngRpvdqiFeMrzBIeFTanixrN8NOiai3m5IFovg/6BNPnD5CQd
         96U9JwJ2ckbl/lf20X+/cAC9ZxNPdE4Pui2gy+aRxfMdfi65nCFkVltIjXuxFTsFxe99
         qWw+AcMAUJnZbiBN5B07JbkELuo5ZaXpeaRFioZA3kDl3+CXsqeOTMBm4zrobPfzWVGE
         j1FCUz1znu+dpyI7MOH+ZIzFZy1wFf7v8v0uvVYjWWP8Hj1LtZ1w3dWKCf1PkxY36dub
         UXu4swvdnjz5I6yE4nSqFpbI3Cb53OzhlPkH8iuK4hCYt/WtLKvFM+HP6qtRy2EG7NMd
         1Lbg==
X-Gm-Message-State: AOAM530H2DAd8Daitn1bZ7HjwczWKLBmhQrPWM9zFJqEAq2Heuraf6wA
        frGJCqOHMf/hatymEkGzHiHbz3hmzhT0bJYgT9JInQ==
X-Google-Smtp-Source: ABdhPJxCUx9zkP+WQdqoxgUy4GnwOCwNUzbWvrEkLsCplC3eoVB8F6tuhl91Bjb/oWLV4SfzajK7jz/bGa88znNg4uY=
X-Received: by 2002:a05:620a:c95:: with SMTP id q21mr8018254qki.360.1616141324728;
 Fri, 19 Mar 2021 01:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201109173948.96663-1-sven.auhagen@voleatech.de>
 <20210227105723.7i42cw376qmnozcp@SvensMacBookAir-2.local> <CAPv3WKfH_-ydZ4GXW8UUNuvWyT7xAXjPOLGVxt+X2svXt=PYdg@mail.gmail.com>
 <87czvviok9.fsf@BL-laptop>
In-Reply-To: <87czvviok9.fsf@BL-laptop>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 19 Mar 2021 09:08:34 +0100
Message-ID: <CAPv3WKfiuV5h2m=579-3UajwBFtHB2MP5tdSvzxTZo+0MPnZNA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Armada8k enable per-port SATA interrupts and drop
 a hack in the IRQ subsystem
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Sven Auhagen <sven.auhagen@voleatech.de>, axboe@kernel.dk,
        Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, maz@kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>,
        devicetree@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        viresh.kumar@linaro.org, rjw@rjwysocki.net,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        linux-ide@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Grzegorz Jaszczyk <jaz@semihalf.com>, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

HI Gregory,

pt., 19 mar 2021 o 08:35 Gregory CLEMENT <gregory.clement@bootlin.com>
napisa=C5=82(a):
>
> Hello Marcin,
>
> > [Resend in plain text]
> >
> > Hi,
> >
> > Just letting everyone know - merging only the DT part of this patchset
> > broke AHCI on all Marvell Armada 7k8k / CN913x platforms in v5.11
> > release.
>
> It's unfortunate that we didn't know this when v5.11-rc1 was
> released. However it is still time for a fix, I will submit it.
> As I explained in the other email when I applied this I really though
> that the driver part will be applied, I don't know what happened here.
>

Sure, looking at the thread it looks more of a communication issue. I
am also surprised the breakage went unnoticed for a while (unless
everyone is using edk2, like myself :) ). I think it would be good to
revert the change on top of v5.11.x. The drivers adoption would have to
land before v5.12 though, so that not to repeat the problem during next rel=
ease.

Small rant:
A general issue with the DT binding changes of this kind (previously
clocks, ICU, etc.) that I have, is a side effect of incompatibility
with older kernels/other OSs. The latter must follow the
modifications, but you can forget of booting e.g. Debian Buster with
the ToT device tree. Therefore in edk2 I do not update the device tree
fork to often and need to tweak it in order to have the widest support
coverage.

I'm dropping this note, so that in similar case in future, there is additio=
nal
consideration, how the change impacts a wider ecosystem, not only
today's Linux top of tree.

Thanks,
Marcin


> >
> > FYI, I'm currently updating the device trees in EDK2 based on the
> > v5.11 DT sources - I'm going to keep the previous binding anyway, as
> > the new one breaks booting with AHCI not only for older Linux
> > versions, but also for other OSs (yet another argument to use ACPI).
> >
> > Best regards,
> > Marcin
> >
> >
> > sob., 27 lut 2021 o 12:02 Sven Auhagen <sven.auhagen@voleatech.de> napi=
sa=C5=82(a):
> >>
> >> Hello,
> >>
> >> can I ask about the status of this patch?
> >> As far as I can tell it was not merged to ata and I did not receive
> >> any further feedback that there was a problem with the patch series.
> >>
> >> As a matter of fact the device tree part was already merged by
> >> Gregory Clement.
> >>
> >> Best and thanks
> >> Sven
> >>
> >> On Mon, Nov 09, 2020 at 06:39:39PM +0100, sven.auhagen@voleatech.de wr=
ote:
> >> > From: Sven Auhagen <sven.auhagen@voleatech.de>
> >> >
> >> > Hello,
> >> >
> >> > There were already 4 versions of this series from Miqu=C3=A8l.
> >> > I talked to Miqu=C3=A8l and I fixed up the last comments from v4.
> >> > I am looking for feedback if this patch series is now ready to be me=
rged
> >> > and what should be further changed.
> >> >
> >> > Here is the original cover letter:
> >> >
> >> > Some time ago, when the initial support for Armada CP110 was
> >> > contributed, the SATA core was not able to handle per-port
> >> > interrupts. Despite the hardware reality, the device tree only
> >> > represents one main interrupt for the two ports. Having both SATA
> >> > ports enabled at the same time has been achieved by a hack in the IC=
U
> >> > driver(1) that faked the use of the two interrupts, no matter which
> >> > SATA port was in use.
> >> >
> >> > Now that the SATA core is ready to handle more than one interrupt,
> >> > this series adds support for it in the libahci_platform code. The
> >> > CP110 device tree must be updated to reflect the two SATA ports
> >> > available and their respective interrupts. To do not break DT backwa=
rd
> >> > compatibility, the ahci_platform driver now embeds a special quirk
> >> > which checks if the DT is valid (only for A8k compatible) and, if
> >> > needed, creates the two missing sub-nodes, and assign them the
> >> > relevant "reg" and "interrupts" properties, before removing the main
> >> > SATA node "interrupts" one.
> >> >
> >> > (1) The ICU is an irqchip aggregating the CP110 (south-bridge)
> >> > interrupts into MSIs for the AP806 (north-bridge).
> >> >
> >> > Best
> >> > Sven
> >> >
> >> > Change from v2:
> >> >   * Fix commit message of custom irq init for host init
> >> >
> >> > Change from v1:
> >> >   * Add a patch to enable custom irq initialization in
> >> >     plattform init host
> >> >   * Add multi_irq_host_ack callback for the msi irq handler
> >> >   * Rework the ahci mvebu patch to initiate the irq and use
> >> >     the new multi_irq_host_ack to handle the custom irq code.
> >> >     Remove the custom irq handler and duplicate code.
> >> >   * Fix the armada8k backwards compatibility code
> >> >   * Rename AHCI_PLATFORM_A8K_QUIRK to AHCI_PLATFORM_ARMADA8K_QUIRK
> >> >
> >> > Miquel Raynal (5):
> >> >   ata: ahci: mvebu: Rename a platform data flag
> >> >   ata: ahci: mvebu: Support A8k compatible
> >> >   irqchip/irq-mvebu-icu: Remove the double SATA ports interrupt hack
> >> >   dt-bindings: ata: Update ahci bindings with possible per-port
> >> >     interrupts
> >> >   dt-bindings: ata: Update ahci_mvebu bindings
> >> >
> >> > Sven Auhagen (4):
> >> >   ata: libahci_platform: Do not try to get an IRQ when
> >> >     AHCI_HFLAG_MULTI_MSI is set
> >> >   ata: ahci: add ack callback to multi irq handler
> >> >   ata: ahci: mvebu: Add support for A8k legacy DT bindings
> >> >   arm64: dts: marvell: armada-cp110: Switch to per-port SATA interru=
pts
> >> >
> >> >  .../devicetree/bindings/ata/ahci-platform.txt |   7 +
> >> >  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   6 +-
> >> >  drivers/ata/ahci.h                            |   2 +
> >> >  drivers/ata/ahci_mvebu.c                      | 143 +++++++++++++++=
+--
> >> >  drivers/ata/libahci.c                         |   4 +
> >> >  drivers/ata/libahci_platform.c                |  19 ++-
> >> >  drivers/irqchip/irq-mvebu-icu.c               |  18 ---
> >> >  include/linux/ahci_platform.h                 |   1 +
> >> >  8 files changed, 160 insertions(+), 40 deletions(-)
> >> >
> >> > --
> >> > 2.20.1
> >> >
> >> >
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com
