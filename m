From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13286] dma_timer_expiry: DMA status (0x21)
Date: Wed, 13 May 2009 18:31:12 GMT
Message-ID: <200905131831.n4DIVC4o002228@demeter.kernel.org>
References: <bug-13286-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:35382 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755090AbZEMSbL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 May 2009 14:31:11 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4DIVCrT002229
	for <linux-ide@vger.kernel.org>; Wed, 13 May 2009 18:31:12 GMT
In-Reply-To: <bug-13286-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13286





--- Comment #7 from Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  2009-05-13 18:31:12 ---
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

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
