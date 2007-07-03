From: Tejun Heo <htejun@gmail.com>
Subject: Re: how to handle pata_via when controller not in fully-pci-native
 mode (two irqs?)
Date: Tue, 03 Jul 2007 18:21:20 +0900
Message-ID: <468A1510.6070803@gmail.com>
References: <467C689E.3050800@genesi-usa.com>	<20070623103349.23cad9b7@the-village.bc.nu>	<467CE8FA.2040304@genesi-usa.com> <20070623105344.3ece6db1@the-village.bc.nu> <467CF1E6.8000905@genesi-usa.com> <4689FBCB.90608@gmail.com> <468A04A0.1020003@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:22782 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264AbXGCJWi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 05:22:38 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1158956nze
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 02:22:38 -0700 (PDT)
In-Reply-To: <468A04A0.1020003@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Matt Sealey wrote:
> So we actually have to fix up some platform support for it? That's not very
> nice.

Well, the hardware isn't very nice, is it?  :-)

> We can't make the controller TRULY legacy since there is not any good way
> of mapping the IDE/BMDMA registers into the lower kilobyte or so of
> memory - obviously PPC has no "io address space", it's all memory mapped,
> so the lower kilobyte of "IO ports" is really the CPU zero page. It's not
> a good idea to be poking around just there and we never intended that to work.

So, the legacy ioport addresses aren't fixed.  It can be determined by
the previously-said arch macros.  Or are you saying that mmio is required?

> Is it possible to perhaps replace ata_pci_init_one with a custom
> function which handles this (in pata_via.c) quirky behaviour and
> #ifdef it out with a Kconfig variable?

Yeah, sure.  I was gonna do it once the native PCI BARs + legacy IRQ
hack I posted to the bugzilla bug is verified to work.  There's a
pending cleanup to ata_pci_init_once() and friends which will make the
job easier.  Can you test the patch and try to determine why it doesn't
work?

Thanks.

-- 
tejun
