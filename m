Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26977C433E0
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 22:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2B2061981
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 22:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCSW2f (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Mar 2021 18:28:35 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38180 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230218AbhCSW21 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 19 Mar 2021 18:28:27 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1lNNbM-00BxWC-DN; Fri, 19 Mar 2021 23:28:16 +0100
Date:   Fri, 19 Mar 2021 23:28:16 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     Mark Kettenis <mark.kettenis@xs4all.nl>, maz@kernel.org,
        =?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
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
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Jon Nettleton <jon@solid-run.com>
Subject: Re: [PATCH v3 0/9] Armada8k enable per-port SATA interrupts and drop
 a hack in the IRQ subsystem
Message-ID: <YFUlgLlLG4yoQqwB@lunn.ch>
References: <20201109173948.96663-1-sven.auhagen@voleatech.de>
 <20210227105723.7i42cw376qmnozcp@SvensMacBookAir-2.local>
 <CAPv3WKfH_-ydZ4GXW8UUNuvWyT7xAXjPOLGVxt+X2svXt=PYdg@mail.gmail.com>
 <87czvviok9.fsf@BL-laptop>
 <CAPv3WKfiuV5h2m=579-3UajwBFtHB2MP5tdSvzxTZo+0MPnZNA@mail.gmail.com>
 <87wnu3h4hw.wl-maz@kernel.org>
 <CAPv3WKdfywQpBx0HpeBTAZ2G5U+jFVQ6We8J_WeK7sYgWNiuJg@mail.gmail.com>
 <c1bcbd5402f4af12@bloch.sibelius.xs4all.nl>
 <YFUPTlR/pFjxoKiF@lunn.ch>
 <CAPv3WKct6PZq32-wLXrpwA+_0gU3nrA3ieMnvFWqda+GnQ2jyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPv3WKct6PZq32-wLXrpwA+_0gU3nrA3ieMnvFWqda+GnQ2jyQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

> I agree, however hopefully the MDIO + ACPI patchset, that currently
> seems to be pretty advanced on the lists, will land

Well, it has not yet addressed the standing NACK. Which is why no
networking people are reviewing it. We will have to wait and see if
they can do what it needed to clear the NACK.

     Andrew
