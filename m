From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git patches] IDE updates (part 2)
Date: Mon, 15 Oct 2007 07:15:00 +1000
Message-ID: <1192396500.6188.4.camel@pasglop>
References: <200710131825.24768.bzolnier@gmail.com>
	 <200710140041.25152.bzolnier@gmail.com> <1192320489.22054.40.camel@pasglop>
	 <200710141807.24295.bzolnier@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40299 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759534AbXJNVPL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 Oct 2007 17:15:11 -0400
In-Reply-To: <200710141807.24295.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


> How's about this patch?
> 
> [PATCH] ide-pmac: fix pmac_ide_init_hwif_ports()
> 
> * pmac_ide_init_hwif_ports() can be called by ide_init_hwif_ports()
>   (through ppc_ide_md.ide_init_hwif hook) for non IDE PMAC interfaces.
>   If this is the case the hw->io_ports[] should be already setup by
>   ide_init_hwif_ports()->ide_std_init_ports() so remove redundant code
>   from pmac_ide_init_hwif_ports().
> 
>   As side-effect this change fixes ctl_addr == 0 special handling in
>   ide_init_hwif_ports().
> 
> * Fix misleading comment while at it.

I would have to try it. Problem is, I don't actually have any powermac
with a PCI IDE controller at hand.. ouch. I'll see what I can find.

Ben.


