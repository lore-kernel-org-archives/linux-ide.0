Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35739C4743D
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 02:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 147B8610A1
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 02:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFGCIk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Jun 2021 22:08:40 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48286 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFGCIk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jun 2021 22:08:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id DF5832A89A;
        Sun,  6 Jun 2021 22:06:46 -0400 (EDT)
Date:   Mon, 7 Jun 2021 12:07:00 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Zidlicky <rz@linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] m68k/q40: Replace q40ide with pata_falcon and
 falconide
In-Reply-To: <e250cffb-9edd-1b84-3826-58079758b35a@gmail.com>
Message-ID: <4a32d59-ebb-9dc-fec7-ad172547d9a3@linux-m68k.org>
References: <352239036981177050c296ca3deb84a102d9faa2.1622970906.git.fthain@linux-m68k.org> <e250cffb-9edd-1b84-3826-58079758b35a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, 7 Jun 2021, Michael Schmitz wrote:

> Hi Finn,
> 
> are there any substantial changes from what I'd tested before? 

The request_region() stuff is new, and I reworked the host->get_lock and 
host->release_lock changes. So you may want to review it again.

> Your patch conflicts with (I think) the Mac IDE patches now in Geert's 
> tree, and I'd rather avoid hand-patching the lot if at all possible:
> 
> m68k_q40_Replace_q40ide_with_pata_falcon_and_falconide
> Applying: m68k/q40: Replace q40ide with pata_falcon and falconide
> error: patch failed: arch/m68k/configs/multi_defconfig:351
> error: arch/m68k/configs/multi_defconfig: patch does not apply
> error: patch failed: drivers/ide/Kconfig:731
> error: drivers/ide/Kconfig: patch does not apply
> error: patch failed: drivers/ide/Makefile:29
> error: drivers/ide/Makefile: patch does not apply
> 

I should have sent these as a two-part series. Sorry about that.
You'll need to apply this patch first:
https://lore.kernel.org/linux-ide/3de9a93d-2f7-a650-1fa-c2129a4a765b@nippy.intranet/T/

> What's your baseline for this patch?
> 

I've used v5.12 and v5.13-rc5, but mostly I develop on the mac68k branch 
in my github repository.

> (In the alternative: just add my Tested-by if nothing changed aside from the
> IO region reservation)
> 

I have tested these patches in Aranym (including a multi-platform 
atari/q40 build which required your ISA fix) but I don't have any way to 
test the q40-only code.
