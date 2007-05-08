From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: ASUS M2A-VM - AMD690G - SB600 Non-Raid-5 SATA - problem
Date: Tue, 8 May 2007 22:39:55 +1000 (EST)
Message-ID: <816997.34722.qm@web52603.mail.re2.yahoo.com>
References: <46405B16.3000502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web52603.mail.re2.yahoo.com ([206.190.48.206]:33409 "HELO
	web52603.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S934507AbXEHMj4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 08:39:56 -0400
In-Reply-To: <46405B16.3000502@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, conke.hu@gmail.com

--- Tejun Heo <htejun@gmail.com> wrote:
> Hello,

Hello,
 
> Srihari Vijayaraghavan wrote:
> > --- Tejun Heo <htejun@gmail.com> wrote:
> >> It just seems sb600 claims that it can do DMA above 4G while it actually
> >> can't.  Can you test the attached patch?

[...]

> > With your patch, with 4 GB of RAM, all SATA drives are detected & working
> > normally. For the record dmesg is attached.
> 
> Thanks for testing.

Thank you for providing a good patch.

[...]

> Oh well, that's the price you have to pay when you 1. have a device
> which can't access memory above 4G but 2. don't have IOMMU to do it for
> the device.  If performance becomes problem, you can always get a
> not-so-expensive external controller which can do 64.

Well, I think my AM2 chip is capable of IOMMU (well that's one of the deciding
factor even since my original AMD64 3200+ :-)). BTW is there an easier way to
prove whether IOMMU is in use?

> Yeap, I'll forward it upstream and probably to -stable too.  The problem
> here is that I'm not sure whether the problem is in the ahci controller
> itself or some bridge chip above it.

Fair enough.

>  It would be best if Conke Hu can
> verify this but you can also test it by buying a ATA controller which
> can do 64bit and whether it works properly on the machine.  :-)

Let's hope he does.

Buying an (S)ATA controller now is a lofty goal (for the lack of money more
than anything :-)). But doesn't my current on-board IDE doesn't do 64bit DMA?

Here is its lspci -vvv:
00:14.1 IDE interface: ATI Technologies Inc SB600 IDE (prog-if 82 [Master
PriP])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81ef
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at 01f0 [size=8]
        Region 1: I/O ports at 03f4 [size=1]
        Region 2: I/O ports at 0170 [size=8]
        Region 3: I/O ports at 0374 [size=1]
        Region 4: I/O ports at f900 [size=16]
        Capabilities: [70] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 
Enable-
                Address: 00000000  Data: 0000

I'm not sure if this IDE controller is operating in 64 bit DMA?? (well if it
didn't my IDE peripherals might not have worked properly without mem=4095M,
like the SATA controller, no? They always worked fine.) I thought all PCI-E
based devices were capable, no?

Thanks


Send instant messages to your online friends http://au.messenger.yahoo.com 
