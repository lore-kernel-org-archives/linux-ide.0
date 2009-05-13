From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Bug 13286] dma_timer_expiry: DMA status (0x21)
Date: Wed, 13 May 2009 20:35:31 +0200
Message-ID: <200905132035.31744.bzolnier@gmail.com>
References: <bug-13286-11633@http.bugzilla.kernel.org/> <200905131801.n4DI1Vro032174@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:29305 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662AbZEMSbK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 May 2009 14:31:10 -0400
Received: by mu-out-0910.google.com with SMTP id i2so301172mue.1
        for <linux-ide@vger.kernel.org>; Wed, 13 May 2009 11:31:09 -0700 (PDT)
In-Reply-To: <200905131801.n4DI1Vro032174@demeter.kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-ide@vger.kernel.org

On Wednesday 13 May 2009 20:01:31 bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=13286
> 
> 
> 
> 
> 
> --- Comment #4 from fibre_optic@go2.pl  2009-05-13 18:01:31 ---
> "Does 2.6.27.21 use DMA?"
> 
> Here is part of dmesg output from 2.6.27.21:
> ...
> platform rtc_cmos: registered platform RTC device (no PNP device found)
> squashfs: version 3.4 (2008/08/26) Phillip Lougher
> msgmni has been set to 498
> io scheduler noop registered (default)
> pci 0000:00:01.0: Boot video device
> brd: module loaded
> Uniform Multi-Platform E-IDE driver
> ide_generic: please use "probe_mask=0x3f" module parameter for probing all
> legacy ISA IDE ports
> Probing IDE interface ide0...
> hda: SanDisk SDCFJ-32, CFA DISK drive

This kernel is using ide_generic host driver which doesn't support DMA
instead of piix one (it explains why 2.6.27.21 works and 2.6.29.3 doesn't).

> "Unfortunately there is no software method to check it so
> you need to look at PCB and verify if there are any routes
> connected to pins 21 and 29 (DMARQ and -DMACK lines)."
> 
> Take a look at attached pictures. Do they help to figure this out?

No DMA lines... this is hardware problem -- you can workaround it with
"ide_core.nodma=0.0" boot parameter (see Documentation/ide/ide.txt for
more details on ide parameters).

I'm closing the bug.
