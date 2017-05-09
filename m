From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [OpenWrt-Devel] [PATCH 2/4] ata: Add DT bindings for the Gemini
 SATA bridge
Date: Tue, 9 May 2017 08:39:44 +0200
Message-ID: <CACRpkdbPJDPs0bMHbKUGXt2E4O=e_rJveKy=hR-_J-GKG7oLkQ@mail.gmail.com>
References: <20170506121053.11554-1-linus.walleij@linaro.org>
 <CGME20170506121119epcas5p437ea69e802ba94bd7df83d0bbac1b0bc@epcas5p4.samsung.com>
 <20170506121053.11554-2-linus.walleij@linaro.org> <3791456.ZibJefW5cI@amdc3058>
 <CACRpkdYz9Oka0SGJDTr=y4EN-VfggbuKY2s5X43oXg1dgjh1nw@mail.gmail.com>
 <CAKR_QVJTbLMzqsUTEZJOquZ9T5aQ1_=73WAoRWrm+QK9wFhngA@mail.gmail.com> <6e0751d2-8f78-c584-2990-c05bc3090214@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:36812 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdEIGjq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 9 May 2017 02:39:46 -0400
Received: by mail-it0-f42.google.com with SMTP id o5so80831585ith.1
        for <linux-ide@vger.kernel.org>; Mon, 08 May 2017 23:39:45 -0700 (PDT)
In-Reply-To: <6e0751d2-8f78-c584-2990-c05bc3090214@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Tom Psyborg <pozega.tomislav@gmail.com>, openwrt-devel@openwrt.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, John Feng-Hsin Chiang <john453@faraday-tech.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, Greentime Hu <green.hu@gmail.com>, Tejun Heo <tj@kernel.org>, Janos Laube <janos.dev@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, May 9, 2017 at 12:52 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 05/08/2017 02:16 PM, Tom Psyborg wrote:
>> Is it ever going to be added so this endless spam can end?
>
> It's the first iteration of the (S)ATA patchset, and if you are not
> interested, just ignore the thread.

I mailed with Tom and it turns out he thinks openwrt-devel is getting
spammed with these submissions.

It's true in a sense: the patches are targeted for upstream and not
for the openwrt repo.

It's no big deal, I don't want to unnecessarily increase traffic on
openwrt-devel if it is annoying to some.

> Linus is doing everyone a great favor here by making sure that this
> platform gets properly supported upstream such that the cost of
> maintaining in OpenWrt/LEDE/anywhere else comes down to almost zero.

I am porting to D-Link DIR-685 and DNS-313 as part of the
process, so we have two new high-volume routers/NAS boxes
as part of the process. I don't know how to fix the OpenWRT
install and builds for these in the end though.

It is actually probably an even bigger win though.

We have learnt that Faraday Technology is sprinkling silicon blocks
all over any silicon foundries close to Taiwan. Their stuff appear
to be in a lot of cheap routers, NAS etc. They use the number of
successful deployments of the IP block as a selling point. I guess
these guys are commonly called in to consult when kickstarting
silicon design, simply.

It turns out that this and other silicon vendors such as Grain Media,
Andestech, Moschip etc are using the same silicon blocks, so
a bunch of out-of-tree code is actually just duplicate implementations
of Faraday drivers... we already merged Gemini and MoxaArt in
the upstream kernel so we have a common interrupt chip, timer,
PCI driver, and now this IDE/ATA driver (not the FTIDE200 yet though).

So there is maybe not as much unique silicon
in the world as we have come to think, we need to pay attention
to how register maps look on different things.

Yours,
Linus Walleij
