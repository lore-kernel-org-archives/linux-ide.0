Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1878C433E0
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 07:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87EF664D79
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 07:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbhCSHfS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Mar 2021 03:35:18 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:65285 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbhCSHfK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Mar 2021 03:35:10 -0400
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Mar 2021 03:35:09 EDT
X-Originating-IP: 90.66.176.191
Received: from localhost (lfbn-lyo-1-2007-191.w90-66.abo.wanadoo.fr [90.66.176.191])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 3040A40007;
        Fri, 19 Mar 2021 07:35:03 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Marcin Wojtas <mw@semihalf.com>,
        Sven Auhagen <sven.auhagen@voleatech.de>
Cc:     axboe@kernel.dk, Hans de Goede <hdegoede@redhat.com>,
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
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Grzegorz Jaszczyk <jaz@semihalf.com>, upstream@semihalf.com
Subject: Re: [PATCH v3 0/9] Armada8k enable per-port SATA interrupts and
 drop a hack in the IRQ subsystem
In-Reply-To: <CAPv3WKfH_-ydZ4GXW8UUNuvWyT7xAXjPOLGVxt+X2svXt=PYdg@mail.gmail.com>
References: <20201109173948.96663-1-sven.auhagen@voleatech.de>
 <20210227105723.7i42cw376qmnozcp@SvensMacBookAir-2.local>
 <CAPv3WKfH_-ydZ4GXW8UUNuvWyT7xAXjPOLGVxt+X2svXt=PYdg@mail.gmail.com>
Date:   Fri, 19 Mar 2021 08:35:02 +0100
Message-ID: <87czvviok9.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello Marcin,

> [Resend in plain text]
>
> Hi,
>
> Just letting everyone know - merging only the DT part of this patchset
> broke AHCI on all Marvell Armada 7k8k / CN913x platforms in v5.11
> release.

It's unfortunate that we didn't know this when v5.11-rc1 was
released. However it is still time for a fix, I will submit it.
As I explained in the other email when I applied this I really though
that the driver part will be applied, I don't know what happened here.

Grégory

>
> FYI, I'm currently updating the device trees in EDK2 based on the
> v5.11 DT sources - I'm going to keep the previous binding anyway, as
> the new one breaks booting with AHCI not only for older Linux
> versions, but also for other OSs (yet another argument to use ACPI).
>
> Best regards,
> Marcin
>
>
> sob., 27 lut 2021 o 12:02 Sven Auhagen <sven.auhagen@voleatech.de> napisał(a):
>>
>> Hello,
>>
>> can I ask about the status of this patch?
>> As far as I can tell it was not merged to ata and I did not receive
>> any further feedback that there was a problem with the patch series.
>>
>> As a matter of fact the device tree part was already merged by
>> Gregory Clement.
>>
>> Best and thanks
>> Sven
>>
>> On Mon, Nov 09, 2020 at 06:39:39PM +0100, sven.auhagen@voleatech.de wrote:
>> > From: Sven Auhagen <sven.auhagen@voleatech.de>
>> >
>> > Hello,
>> >
>> > There were already 4 versions of this series from Miquèl.
>> > I talked to Miquèl and I fixed up the last comments from v4.
>> > I am looking for feedback if this patch series is now ready to be merged
>> > and what should be further changed.
>> >
>> > Here is the original cover letter:
>> >
>> > Some time ago, when the initial support for Armada CP110 was
>> > contributed, the SATA core was not able to handle per-port
>> > interrupts. Despite the hardware reality, the device tree only
>> > represents one main interrupt for the two ports. Having both SATA
>> > ports enabled at the same time has been achieved by a hack in the ICU
>> > driver(1) that faked the use of the two interrupts, no matter which
>> > SATA port was in use.
>> >
>> > Now that the SATA core is ready to handle more than one interrupt,
>> > this series adds support for it in the libahci_platform code. The
>> > CP110 device tree must be updated to reflect the two SATA ports
>> > available and their respective interrupts. To do not break DT backward
>> > compatibility, the ahci_platform driver now embeds a special quirk
>> > which checks if the DT is valid (only for A8k compatible) and, if
>> > needed, creates the two missing sub-nodes, and assign them the
>> > relevant "reg" and "interrupts" properties, before removing the main
>> > SATA node "interrupts" one.
>> >
>> > (1) The ICU is an irqchip aggregating the CP110 (south-bridge)
>> > interrupts into MSIs for the AP806 (north-bridge).
>> >
>> > Best
>> > Sven
>> >
>> > Change from v2:
>> >   * Fix commit message of custom irq init for host init
>> >
>> > Change from v1:
>> >   * Add a patch to enable custom irq initialization in
>> >     plattform init host
>> >   * Add multi_irq_host_ack callback for the msi irq handler
>> >   * Rework the ahci mvebu patch to initiate the irq and use
>> >     the new multi_irq_host_ack to handle the custom irq code.
>> >     Remove the custom irq handler and duplicate code.
>> >   * Fix the armada8k backwards compatibility code
>> >   * Rename AHCI_PLATFORM_A8K_QUIRK to AHCI_PLATFORM_ARMADA8K_QUIRK
>> >
>> > Miquel Raynal (5):
>> >   ata: ahci: mvebu: Rename a platform data flag
>> >   ata: ahci: mvebu: Support A8k compatible
>> >   irqchip/irq-mvebu-icu: Remove the double SATA ports interrupt hack
>> >   dt-bindings: ata: Update ahci bindings with possible per-port
>> >     interrupts
>> >   dt-bindings: ata: Update ahci_mvebu bindings
>> >
>> > Sven Auhagen (4):
>> >   ata: libahci_platform: Do not try to get an IRQ when
>> >     AHCI_HFLAG_MULTI_MSI is set
>> >   ata: ahci: add ack callback to multi irq handler
>> >   ata: ahci: mvebu: Add support for A8k legacy DT bindings
>> >   arm64: dts: marvell: armada-cp110: Switch to per-port SATA interrupts
>> >
>> >  .../devicetree/bindings/ata/ahci-platform.txt |   7 +
>> >  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   6 +-
>> >  drivers/ata/ahci.h                            |   2 +
>> >  drivers/ata/ahci_mvebu.c                      | 143 ++++++++++++++++--
>> >  drivers/ata/libahci.c                         |   4 +
>> >  drivers/ata/libahci_platform.c                |  19 ++-
>> >  drivers/irqchip/irq-mvebu-icu.c               |  18 ---
>> >  include/linux/ahci_platform.h                 |   1 +
>> >  8 files changed, 160 insertions(+), 40 deletions(-)
>> >
>> > --
>> > 2.20.1
>> >
>> >
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
