From: Aric Cyr <Aric.Cyr@gmail.com>
Subject: DMA problems with ali15x3 on =?utf-8?b?eDg2XzY0?=
Date: Mon, 12 Dec 2005 06:34:45 +0000 (UTC)
Message-ID: <loom.20051212T070521-199@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:52456 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750852AbVLLGv1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Dec 2005 01:51:27 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1ElhVg-0004Sv-2z
	for linux-ide@vger.kernel.org; Mon, 12 Dec 2005 07:50:08 +0100
Received: from epsonfw.epson.co.jp ([203.179.21.193])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 12 Dec 2005 07:50:08 +0100
Received: from Aric.Cyr by epsonfw.epson.co.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 12 Dec 2005 07:50:08 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I've been trying to track this problem down for quite a while (months).
The exact same problem (with the exact same hardware) I am experiencing has come 
up on the Linux kernel lists a few months ago: http://lkml.org/lkml/2005/6/8/34
This thread never came to any conclusion however, and the problem has persisted
through 2.6.12 to 2.6.14.

I can very easily reproduce the problem on my system by enabling DMA on my DVDRW
and running "cdrecord -atip".  Regardless of what access method I use (dev=ATA:
dev=ATAPI: dev=/dev/hda) the results are the same.  It is not the drive itself
either since I have swapped it out with a known good one and the exact same
problem persisted.  It can't be the IDE cable either since DMA read-only works
just fine (can play DVDs for hours without a hitch).  Dropping to PIO, DMA off
does fix the problem, however then I can only burn at a pitiful speed and cannot
play DVDs due to slow access causing skipping in playback.

The south bridge on this motherboard is a ULI1573 (previously ALi).  It has an
sata channel and an IDE channel.  My HD is on sata and the DVDRW is IDE.  One
thing that I noticed is that the IDE and SATA controls are different functions
of the same device:

0000:00:1f.0 IDE interface: ALi Corporation M5229 IDE (rev c7)
0000:00:1f.1 RAID bus controller: ALi Corporation: Unknown device 5287 (rev 02)

and both of these devices are wired into the same interrupt.  Now SATA gets some
 interrupt (irq117 or such) but the IDE controller is getting the standard IDE
irq14 (as shown by /proc/interrupts).  However lspci shows both functions as
using irq117.  Something seems kind of fishy to me here, can anyone shed some
light on this point perhaps?

So anyways my current theory is either ali15x3 is broken for DMA on this
chipset, or sata_uli is doing something not-nice to the IDE interrupt.

Some other observations:
1) cdrdao does not have any problems burning it seems
2) lsdvd also causes drive lockups and lost interrupts
3) using the unsupported hda=ide-scsi bootparm "cdrecord -atip" no longer fails
but actually trying to burn causes the drive to puke and get disabled
eventually, but at least cdrecord can be killed.
4) changing the PCI latency timer from 32 to 128 to match the SATA timer has no
effect... changing both to 64 also has no effect.
5) chaning UDMA mode of the DVDRW, via hdparm had no effect.

I can post any logs and help with debugging etc.  Please let me know what I can
do to help track this problem down.

Regards,
  Aric

