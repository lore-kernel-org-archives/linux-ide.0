Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9307C433E0
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 02:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3D4861580
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 02:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhCSCfT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Mar 2021 22:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhCSCep (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2021 22:34:45 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF057C06175F
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 19:34:44 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id r14so5729592qtt.7
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 19:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=psinH8XtxfklK+mQg/xmh9CTqB4IAWDh1IKdzXhNoWw=;
        b=AkpqkDmnPm8shhKYbgXs3nBRpukr3Bo8xUVon0hsQ2S/oY+FBAjTZIfH0X943SMWcC
         sDKnYxkW+bONV1KMan8nftcYk6dy0Xnby6lh8AzcGY+m9axfCrsbAQ/k8FQAezQMs/g4
         MYlqnXejBjHYg9OJbKcs8eYmEPs0hpU024NxmIBSuYa6OJv5Tkw+tIqaDM/8Z0wgxiqm
         JJgjCiUzGekoIn8/wcISklzJs/RYslSpjmazHQINnX2HScAJY8Oeplm3qAGNqWd8Fb8Z
         z0Fy8pvqV4uBQXLrHLPM4E+QETkq9MKDB3FTUiVHL5p2rWxrtnih63he9tdIbntZlQZ3
         TWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=psinH8XtxfklK+mQg/xmh9CTqB4IAWDh1IKdzXhNoWw=;
        b=NbrFWEMnnzDotPr5rG/BxiqLV4/SdKXs2Us3p/m4zrmgibkvgnNqs6VzZoLESM2CIs
         JYqhYLWH7CZMu0ySjh/PX1bwCI38H7qI5bibIlxxASEYeMrVVZKKrtloXBRuIxkAfx67
         KoNX+JLbL8/mxwM/GlJKr5T/t/QRTK0eaQqwLxvazMhhlyiQ0+/Va4KBTAf6H+Hjzbax
         221ZiLdbie2u3GLZhxq7ftAAzxtNLB51DGR6bMCX58XDpKkmlO5OfH987WBt7fText0V
         2/1WDD8M+aJ4xeqoM4hivFanZiwdoKeaQxYy3eLuVxWjAA/IeACX0fPySh6dl+9mmwBO
         PqOg==
X-Gm-Message-State: AOAM531YPOX2wRr1i+zDFxqxjiJv3O/HMo2isyfvGa4rzLtepv54WGGX
        /NJsV6O7xDR7DpTszBsG7/mCj9Ot+32M/saeXzj93A==
X-Google-Smtp-Source: ABdhPJz1IZdC1Wj1CXh7P9ipIV8QYNLJwTdUg08Fqh8VY3a2JffIhGlfarT0QN6oo2g6XPyTjsezHJEDE4v6eCdacQc=
X-Received: by 2002:ac8:431e:: with SMTP id z30mr6492634qtm.216.1616121283752;
 Thu, 18 Mar 2021 19:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201109173948.96663-1-sven.auhagen@voleatech.de> <20210227105723.7i42cw376qmnozcp@SvensMacBookAir-2.local>
In-Reply-To: <20210227105723.7i42cw376qmnozcp@SvensMacBookAir-2.local>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 19 Mar 2021 03:34:33 +0100
Message-ID: <CAPv3WKfH_-ydZ4GXW8UUNuvWyT7xAXjPOLGVxt+X2svXt=PYdg@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Armada8k enable per-port SATA interrupts and drop
 a hack in the IRQ subsystem
To:     Sven Auhagen <sven.auhagen@voleatech.de>
Cc:     axboe@kernel.dk, Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, maz@kernel.org,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
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

[Resend in plain text]

Hi,

Just letting everyone know - merging only the DT part of this patchset
broke AHCI on all Marvell Armada 7k8k / CN913x platforms in v5.11
release.

FYI, I'm currently updating the device trees in EDK2 based on the
v5.11 DT sources - I'm going to keep the previous binding anyway, as
the new one breaks booting with AHCI not only for older Linux
versions, but also for other OSs (yet another argument to use ACPI).

Best regards,
Marcin


sob., 27 lut 2021 o 12:02 Sven Auhagen <sven.auhagen@voleatech.de> napisa=
=C5=82(a):
>
> Hello,
>
> can I ask about the status of this patch?
> As far as I can tell it was not merged to ata and I did not receive
> any further feedback that there was a problem with the patch series.
>
> As a matter of fact the device tree part was already merged by
> Gregory Clement.
>
> Best and thanks
> Sven
>
> On Mon, Nov 09, 2020 at 06:39:39PM +0100, sven.auhagen@voleatech.de wrote=
:
> > From: Sven Auhagen <sven.auhagen@voleatech.de>
> >
> > Hello,
> >
> > There were already 4 versions of this series from Miqu=C3=A8l.
> > I talked to Miqu=C3=A8l and I fixed up the last comments from v4.
> > I am looking for feedback if this patch series is now ready to be merge=
d
> > and what should be further changed.
> >
> > Here is the original cover letter:
> >
> > Some time ago, when the initial support for Armada CP110 was
> > contributed, the SATA core was not able to handle per-port
> > interrupts. Despite the hardware reality, the device tree only
> > represents one main interrupt for the two ports. Having both SATA
> > ports enabled at the same time has been achieved by a hack in the ICU
> > driver(1) that faked the use of the two interrupts, no matter which
> > SATA port was in use.
> >
> > Now that the SATA core is ready to handle more than one interrupt,
> > this series adds support for it in the libahci_platform code. The
> > CP110 device tree must be updated to reflect the two SATA ports
> > available and their respective interrupts. To do not break DT backward
> > compatibility, the ahci_platform driver now embeds a special quirk
> > which checks if the DT is valid (only for A8k compatible) and, if
> > needed, creates the two missing sub-nodes, and assign them the
> > relevant "reg" and "interrupts" properties, before removing the main
> > SATA node "interrupts" one.
> >
> > (1) The ICU is an irqchip aggregating the CP110 (south-bridge)
> > interrupts into MSIs for the AP806 (north-bridge).
> >
> > Best
> > Sven
> >
> > Change from v2:
> >   * Fix commit message of custom irq init for host init
> >
> > Change from v1:
> >   * Add a patch to enable custom irq initialization in
> >     plattform init host
> >   * Add multi_irq_host_ack callback for the msi irq handler
> >   * Rework the ahci mvebu patch to initiate the irq and use
> >     the new multi_irq_host_ack to handle the custom irq code.
> >     Remove the custom irq handler and duplicate code.
> >   * Fix the armada8k backwards compatibility code
> >   * Rename AHCI_PLATFORM_A8K_QUIRK to AHCI_PLATFORM_ARMADA8K_QUIRK
> >
> > Miquel Raynal (5):
> >   ata: ahci: mvebu: Rename a platform data flag
> >   ata: ahci: mvebu: Support A8k compatible
> >   irqchip/irq-mvebu-icu: Remove the double SATA ports interrupt hack
> >   dt-bindings: ata: Update ahci bindings with possible per-port
> >     interrupts
> >   dt-bindings: ata: Update ahci_mvebu bindings
> >
> > Sven Auhagen (4):
> >   ata: libahci_platform: Do not try to get an IRQ when
> >     AHCI_HFLAG_MULTI_MSI is set
> >   ata: ahci: add ack callback to multi irq handler
> >   ata: ahci: mvebu: Add support for A8k legacy DT bindings
> >   arm64: dts: marvell: armada-cp110: Switch to per-port SATA interrupts
> >
> >  .../devicetree/bindings/ata/ahci-platform.txt |   7 +
> >  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   6 +-
> >  drivers/ata/ahci.h                            |   2 +
> >  drivers/ata/ahci_mvebu.c                      | 143 ++++++++++++++++--
> >  drivers/ata/libahci.c                         |   4 +
> >  drivers/ata/libahci_platform.c                |  19 ++-
> >  drivers/irqchip/irq-mvebu-icu.c               |  18 ---
> >  include/linux/ahci_platform.h                 |   1 +
> >  8 files changed, 160 insertions(+), 40 deletions(-)
> >
> > --
> > 2.20.1
> >
> >
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
