Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26748C433B4
	for <linux-ide@archiver.kernel.org>; Mon, 26 Apr 2021 07:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB26F613ED
	for <linux-ide@archiver.kernel.org>; Mon, 26 Apr 2021 07:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhDZHky (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Apr 2021 03:40:54 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:42184 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhDZHiE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Apr 2021 03:38:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id F3BF620306;
        Mon, 26 Apr 2021 03:37:16 -0400 (EDT)
Date:   Mon, 26 Apr 2021 17:37:22 +1000 (AEST)
From:   Finn Thain <fthain@fastmail.com.au>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc:     Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Joshua Thompson <funaho@jurai.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] m68k/mac: Replace macide driver with generic platform
 driver
In-Reply-To: <ba908b1d-eab5-a4e5-0c0a-2c745287d121@physik.fu-berlin.de>
Message-ID: <10a08764-c138-9fe5-966c-ce68349b9b6@nippy.intranet>
References: <793432cca963b632709c4d1312baa9874d73e1d8.1619341585.git.fthain@telegraphics.com.au> <ba908b1d-eab5-a4e5-0c0a-2c745287d121@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sun, 25 Apr 2021, John Paul Adrian Glaubitz wrote:

> On 4/25/21 11:06 AM, Finn Thain wrote:
> > This was tested on my Quadra 630. I haven't tested it on my PowerBook 150
> > because I don't have a RAM adapter board for it.
> > 
> > Apparently, the hardware I tested doesn't need macide_clear_irq() or
> > macide_test_irq() -- if it did, the generic driver would not have worked.
> > It's possible that those routines are needed for the PowerBook 150 but
> > we can cross that bridge if and when we come to it.
> > 
> > BTW, macide_clear_irq() appears to suffer from a race condition. The write
> > to the interrupt flags register could easily have unintended side effects
> > as it may alter other flag bits. Fortunately, all of the other bits are
> > unused by Linux. Moreover, when tested on my Quadra 630, that assignment
> > (*ide_ifr &= ~0x20) was observed to have no effect on bit 5.
> 
> Shouldn't we switch to a libata driver instead with legacy IDE been slated
> for removal from the Linux kernel?
> 

This patch means that the Quadra 630/580 config will work the same as the 
Powerbook 190 config. Please see commit 50c5feeea0af ("ide/macide: Convert 
Mac IDE driver to platform driver") for some background.

This patch also means that the kernel/drivers/ide/macide.ko driver module 
will disappear completely. The module that will replace it is up to you.

If you enable CONFIG_IDE and CONFIG_BLK_DEV_PLATFORM, Quadras and 
Powerbooks will use the kernel/drivers/ide/ide_platform.ko module.

If you enable CONFIG_ATA and CONFIG_PATA_PLATFORM, Quadras and
Powerbooks will use the kernel/drivers/ata/pata_platform.ko module.

(If you enable all of the above, you may need to use a blacklist to ensure 
that the preferred driver module gets loaded.)

Was macide the only IDE driver in Debian/m68k kernels without a libata 
alternative? If so, this patch would allow you to finally drop CONFIG_IDE.

> Adrian
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer - glaubitz@debian.org
> `. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
> 
