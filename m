From: "Dan" <snyder@fr0zen.com>
Subject: RE: PDC20269 problems on PowerMac with 2.4.27 kernel
Date: Tue, 10 Aug 2004 18:37:51 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200408110137.i7B1bin17028@top.fr0zen.com>
References: <200408110014.i7B0Eit6017963@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.fr0zen.com ([69.57.150.64]:53481 "EHLO top.fr0zen.com")
	by vger.kernel.org with ESMTP id S267738AbUHKBhv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Aug 2004 21:37:51 -0400
In-Reply-To: <200408110014.i7B0Eit6017963@harpo.it.uu.se>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've had similar problems on an x86 system, under any 2.4.x kernel I've
tried.  I had blamed the problem on my Western Digital hard drives, but
perhaps it's an issue with the promise controller after all.  I was running
software raid 5 across five disks, four of them on the a Promise 20268
(Ultra 100 TX2?), and one or another of the drives would drop offline
frequently with this same error.  It would take several tries to get the
array rebuilt but if activity was light it would run for weeks.  All the
drives pass any and all diagnostic tests I've found with flying colors, and
seem to work fine in other systems  (I have one in my Windows box now).
I've replaced more than one disk, all the replacements do the same thing.
As soon as there's a driver for the DAC-SATA-MV8 I'll have the drives
connected to it and I can let you know if it has any of the same symptoms.
(Actually they're already connected, so come on Jeff let's see that driver!
=)

BTW, the drives are WD2000JB, not all the same rev, but one I have sitting
on my desk here is WD2000JB-00EVA0.  I've also tried several different
Promise cards and cables.

I did not try a 2.6.x kernel to see if it has the same problem.

- Dan


> -----Original Message-----
> From: linux-ide-owner@vger.kernel.org 
> [mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Mikael 
> Pettersson
> Sent: Tuesday, August 10, 2004 5:15 PM
> To: linux-ide@vger.kernel.org; linuxppc-dev@lists.linuxppc.org
> Subject: PDC20269 problems on PowerMac with 2.4.27 kernel
> 
> I have a PowerMac G3 (beige) upgraded with a 1GHz G4 processor
> and a PDC20269 (Promise Ultra 133 TX2) IDE PCI controller,
> which works reliably with the 2.6.8-rc kernels. The controller,
> disk, and cable also work in an x86 box with both 2.6 and 2.4 kernels.
> 
> However, with 2.4.27 on the PowerMac I frequently get DMA timeouts
> while doing heavy I/O operations like a cp -ax from my scsi root
> to a partition on the PDC20269's disk:
> 
> hde: dma_timer_expiry: dma status == 0x20
> hde: timeout waiting for DMA
> PDC202XX: Primary channel reset.
> hde: timeout waiting for DMA
> hde: (__ide_dma_test_irq) called while not waiting
> hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> hde: drive not ready for command
> 
> Occasionally I instead get EXT3 meta-data errors, which I suspect
> are caused by data corruption.
> 
> I've compared lspci -vvx on 2.4 and 2.6, but the only difference
> is a ParErr setting on the 53c875 SCSI controller.
> 
> There are some differences in /proc/ide/ide2/hde/settings between
> 2.4 and 2.6, for multicount and wcache, but I don't know if they're
> relevant. (Manually setting multicount on 2.4 to zero like 2.6 reports
> it leads to immediate data corruption. Weird.)
> 
> I've disabled IDEDMA_AUTO and manually lowered the transfer mode to
> udma3 or even udma2, but that doesn't help at all. It does udma4 w/o
> problems in 2.6 kernels.
> 
> Strangely enough, the card worked better earlier when the box still
> had its original 300MHz CPU. It did throw _one_ error at kernel
> boot-up, but never anything afterwards. Disabling IDEDMA_AUTO
> silenced that error.
> 
> Any ideas on what might be causing this? At this point I'm beginning
> to suspect big-endian or timing bugs in pdc202xx_new.c, or a general
> problem with IDE/DMA/PCI in the 2.4.27 kernel on ppc32/pmac.
> 
> /Mikael
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


