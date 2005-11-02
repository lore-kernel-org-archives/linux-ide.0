From: Don Carroll <ibedonc@star-c.com>
Subject: Re: Asus A8V , via vt8251 AHCI
Date: Tue, 1 Nov 2005 18:39:59 -0600
Message-ID: <20051102003959.GA25525@vcr.star-c.com>
References: <20051101064058.GA4902@vcr.star-c.com> <Pine.LNX.4.58.0511010736550.11761@shark.he.net> <20051101192449.GA9719@vcr.star-c.com> <Pine.LNX.4.58.0511011237080.11761@shark.he.net>
Reply-To: ibedonc@star-c.com, ibedonc@star-c.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dpc6935171158.direcpc.com ([69.35.171.158]:22440 "EHLO
	vcr.star-c.com") by vger.kernel.org with ESMTP id S1751474AbVKBAQo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Nov 2005 19:16:44 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0511011237080.11761@shark.he.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-ide@vger.kernel.org

I am at work , will do the tests when I get home
thanks for your help


On Tue, Nov 01, 2005 at 12:42:02PM -0800, Randy.Dunlap wrote:
> 
> Please don't drop cc's and/or to's.
> Back to the mailing list now...
> 
> On Tue, 1 Nov 2005, Don Carroll wrote:
> 
> > kernel = Mandriva default Linux vcr.star-c.com 2.6.12-12mdksmp #1 SMP Fri Sep 9
> > 17:20:34 CEST 2005 x86_64 AMD Athlon(tm) 64 X2 Dual Core Processor 3800+
> > unknown GNU/Linux
> > attaching default config for mandriva linux , I just edited the ahci.c and
> > built the module from that , did not do a complete kernel install
> 
> The default config is uniprocessor, not SMP.  But your kernel
> verison string above says SMP...
> 
> In either case it looks like it is using local APIC and IO APIC.
> That's all that's required to cause the problem that I am
> familiar with.
> 
> You can at least do test (a) below (boot with the "irqpoll"
> option on the kernel command line) and report on that.
> (without rebuilding the kernel)
> 
> Test (b) requires rebuilding the kernel, which is going
> to be needed to fix this problem (if I'm right about it).
> 
> 
> > On Tue, Nov 01, 2005 at 07:40:06AM -0800, Randy.Dunlap wrote:
> > > On Tue, 1 Nov 2005, Don Carroll wrote:
> > >
> > > > Hi , I added pci id 3349 to achi.c and I get it to load now
> > > > ahci version 1.00
> > > > ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 21 (level, low) -> IRQ 217
> > > > PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 9
> > > > ahci(0000:00:0f.0) AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl SATA mode
> > > > ahci(0000:00:0f.0) flags: 64bit ncq pm led clo pmp pio slum part
> > > > ata3: SATA max UDMA/133 cmd 0xFFFFC20000038900 ctl 0x0 bmdma 0x0 irq 217
> > > > ata4: SATA max UDMA/133 cmd 0xFFFFC20000038980 ctl 0x0 bmdma 0x0 irq 217
> > > > ata5: SATA max UDMA/133 cmd 0xFFFFC20000038A00 ctl 0x0 bmdma 0x0 irq 217
> > > > ata6: SATA max UDMA/133 cmd 0xFFFFC20000038A80 ctl 0x0 bmdma 0x0 irq 217
> > > > ata3: no device found (phy stat 00000000)
> > > > scsi2 : ahci
> > > > ata4: no device found (phy stat 00000000)
> > > > scsi3 : ahci
> > > > ata5: no device found (phy stat 00000000)
> > > > scsi4 : ahci
> > > > ata6 is slow to respond, please be patient
> > > > ata6 failed to respond (30 secs)
> > > > scsi5 : ahci
> > > >
> > > > I have a drive on ata6 , but it does not respond , timesout
> > > >
> > > > this is Mandriva 2006 x86_64 and it has 2.6.12 I have not been able to get .14
> > > > to compile yet , does this look like something that ahci 1.01 would help , any
> > > > ideas ?
> > >
> > > Yes.
> > > (a) boot with "irqpoll" added to the kernel command line to see
> > > if the kernel can route the missed interrupts.
> > >
> > > different test:
> > > (b) Disable CONFIG_PCI_MSI and reboot/retest (without "irqpoll").
> > >
> > > and report the results of those.
> > >
> > > What are your configs for SMP and APIC options?
> > >
> > > --
> > > ~Randy
