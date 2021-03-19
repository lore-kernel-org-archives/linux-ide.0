Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56991C433E0
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 20:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A75761986
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 20:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCSUx7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Mar 2021 16:53:59 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:37924 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhCSUxu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 19 Mar 2021 16:53:50 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1lNM7i-00BwdD-CY; Fri, 19 Mar 2021 21:53:34 +0100
Date:   Fri, 19 Mar 2021 21:53:34 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     Marcin Wojtas <mw@semihalf.com>, maz@kernel.org,
        gregory.clement@bootlin.com, sven.auhagen@voleatech.de,
        axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, devicetree@vger.kernel.org,
        antoine.tenart@bootlin.com, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, maxime.chevallier@bootlin.com,
        linux-ide@vger.kernel.org, thomas.petazzoni@bootlin.com,
        miquel.raynal@bootlin.com, linux-arm-kernel@lists.infradead.org,
        jaz@semihalf.com
Subject: Re: [PATCH v3 0/9] Armada8k enable per-port SATA interrupts and drop
 a hack in the IRQ subsystem
Message-ID: <YFUPTlR/pFjxoKiF@lunn.ch>
References: <20201109173948.96663-1-sven.auhagen@voleatech.de>
 <20210227105723.7i42cw376qmnozcp@SvensMacBookAir-2.local>
 <CAPv3WKfH_-ydZ4GXW8UUNuvWyT7xAXjPOLGVxt+X2svXt=PYdg@mail.gmail.com>
 <87czvviok9.fsf@BL-laptop>
 <CAPv3WKfiuV5h2m=579-3UajwBFtHB2MP5tdSvzxTZo+0MPnZNA@mail.gmail.com>
 <87wnu3h4hw.wl-maz@kernel.org>
 <CAPv3WKdfywQpBx0HpeBTAZ2G5U+jFVQ6We8J_WeK7sYgWNiuJg@mail.gmail.com>
 <c1bcbd5402f4af12@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1bcbd5402f4af12@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

> Unfortunately ACPI doesn't describe how the SFP cages are connected.

Nor MDIO busses and Ethernet PHYs.

ACPI is missing a lot of support for basic elements of networking. I
guess this is because it expects firmware in the NIC to be controlling
these parts, not Linux.

> 
> As soon as GPIOs and I2C busses are involved device trees are so much
> better than ACPI

Yes, ACPI has along way to go before it is usable for SoCs with
integrated Ethernet.

	   Andrew
