From: Larry Battraw <lbattraw@insightbb.com>
Subject: Re: Problems with SiL3114 and WDC WD2500SD-01K
Date: Mon, 22 Aug 2005 21:29:03 -0500
Message-ID: <1124764143.4075.18.camel@rambo.fortresscode.com>
References: <1124581007.5764.10.camel@rambo.fortresscode.com>
	 <4307CE8B.1030403@gmail.com>
	 <1124678422.4075.3.camel@rambo.fortresscode.com> <43093E46.70202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 12-208-38-136.client.insightBB.com ([12.208.38.136]:7674 "EHLO
	12-203-209-98.client.insightBB.com") by vger.kernel.org with ESMTP
	id S1750911AbVHWC3K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Aug 2005 22:29:10 -0400
In-Reply-To: <43093E46.70202@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

  Thanks, I had seen that earlier and was really hoping it wasn't just a
bad card :-)  It and the drive are brand-new.  As an aside, it looks
like the drive may get confused shortly after the initial probe.
Unloading and reloading the driver causes this:

libata version 1.11 loaded.
sata_sil version 0.9
ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNKA] -> GSI 11 (level,
low) -> IRQ 11
ata_device_add: ENTER
ata_host_add: ENTER
ata_port_start: prd alloc, virt ee8c2000, dma 2e8c2000
ata1: SATA max UDMA/100 cmd 0xF08C2080 ctl 0xF08C208A bmdma 0xF08C2000
irq 11
ata_host_add: ENTER
ata_port_start: prd alloc, virt caf03000, dma af03000
ata2: SATA max UDMA/100 cmd 0xF08C20C0 ctl 0xF08C20CA bmdma 0xF08C2008
irq 11
ata_host_add: ENTER
ata_port_start: prd alloc, virt c589a000, dma 589a000
ata3: SATA max UDMA/100 cmd 0xF08C2280 ctl 0xF08C228A bmdma 0xF08C2200
irq 11
ata_host_add: ENTER
ata_port_start: prd alloc, virt eabe7000, dma 2abe7000
ata4: SATA max UDMA/100 cmd 0xF08C22C0 ctl 0xF08C22CA bmdma 0xF08C2208
irq 11
ata_device_add: probe begin
ata_device_add: ata1: probe begin
ata1 is slow to respond, please be patient
ata1 failed to respond (30 secs)
ata_device_add: ata1: probe end

  It never responds after the initial load of the module.  I wish I had
a different brand of drive to try and see if that's part of the problem.
Is anybody else using a WD drive?

Larry


On Mon, 2005-08-22 at 11:53 +0900, Tejun Heo wrote:
> 
>  Hello, Larry.
> 
>  The following thread deals with similar problem.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112379743726061&w=2
> 
>  The diagnostic/conclusion being...
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112393534926655&w=2
> 
>  Hope it helps.
> 

