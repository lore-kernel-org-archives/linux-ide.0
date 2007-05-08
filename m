From: Tejun Heo <htejun@gmail.com>
Subject: Re: ASUS M2A-VM - AMD690G - SB600 Non-Raid-5 SATA - problem
Date: Tue, 08 May 2007 15:35:02 +0200
Message-ID: <46407C86.1010304@gmail.com>
References: <816997.34722.qm@web52603.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:22130 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966394AbXEHNfO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 09:35:14 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1963710nzf
        for <linux-ide@vger.kernel.org>; Tue, 08 May 2007 06:35:14 -0700 (PDT)
In-Reply-To: <816997.34722.qm@web52603.mail.re2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-ide@vger.kernel.org, conke.hu@gmail.com

Srihari Vijayaraghavan wrote:
>> Oh well, that's the price you have to pay when you 1. have a device
>> which can't access memory above 4G but 2. don't have IOMMU to do it for
>> the device.  If performance becomes problem, you can always get a
>> not-so-expensive external controller which can do 64.
> 
> Well, I think my AM2 chip is capable of IOMMU (well that's one of the deciding
> factor even since my original AMD64 3200+ :-)). BTW is there an easier way to
> prove whether IOMMU is in use?

Right, I somehow thought you're on intel.  If IOMMU is active, dmesg
should say something about that.  Not sure whether there are other ways
to determine it tho.

>>  It would be best if Conke Hu can
>> verify this but you can also test it by buying a ATA controller which
>> can do 64bit and whether it works properly on the machine.  :-)
> 
> Let's hope he does.
> 
> Buying an (S)ATA controller now is a lofty goal (for the lack of money more
> than anything :-)). But doesn't my current on-board IDE doesn't do 64bit DMA?

Conke Hu, please respond.

> Here is its lspci -vvv:
> 00:14.1 IDE interface: ATI Technologies Inc SB600 IDE (prog-if 82 [Master
> PriP])
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81ef
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Step
> ping- SERR- FastB2B-
>         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort
> - <MAbort- >SERR- <PERR-
>         Latency: 64
>         Interrupt: pin A routed to IRQ 16
>         Region 0: I/O ports at 01f0 [size=8]
>         Region 1: I/O ports at 03f4 [size=1]
>         Region 2: I/O ports at 0170 [size=8]
>         Region 3: I/O ports at 0374 [size=1]
>         Region 4: I/O ports at f900 [size=16]
>         Capabilities: [70] Message Signalled Interrupts: Mask- 64bit-
> Queue=0/0 
> Enable-
>                 Address: 00000000  Data: 0000
> 
> I'm not sure if this IDE controller is operating in 64 bit DMA?? (well if it
> didn't my IDE peripherals might not have worked properly without mem=4095M,
> like the SATA controller, no? They always worked fine.) I thought all PCI-E
> based devices were capable, no?

For the IDE interface, it's not an issue because IDE BMDMA interface
just can't to 64, so the kernel does the right thing and either bounces
the buffer or uses IOMMU.  The problem with ahci controller is that it's
claiming that it can do 64 and then just goes silent when it's actually
asked to do it.  And, yeap, all PCI or PCI-E devices can implement 64bit
DMA but whether a chip actually implements it or not is a different
problem.  Oh well, not doing it and lying about it is also another
problem, I guess.  :-)

-- 
tejun
