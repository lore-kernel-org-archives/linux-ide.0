From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: Errors with AHCI and 10K Raptor drive
Date: Mon, 19 Mar 2007 14:17:14 -0700
Message-ID: <20070319141714.1632cee4@freekitty>
References: <20070319075321.444c241e@freebird>
	<45FEA5D1.20101@pobox.com>
	<20070319131608.6d93fbf4@freekitty>
	<45FEF6B0.6020502@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:56716 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964960AbXCSVRR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Mar 2007 17:17:17 -0400
In-Reply-To: <45FEF6B0.6020502@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Mon, 19 Mar 2007 16:46:40 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Stephen Hemminger wrote:
> > On Mon, 19 Mar 2007 11:01:37 -0400
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> > 
> >> Stephen Hemminger wrote:
> >>> This is a new drive, so I suspect some driver incompatibility between the
> >>> driver (AHCI) and the hard drive (WD Raptor 10K 74G).
> >> Driver incompatibilities between the driver (LLDD or libata-core) and a 
> >> hard drive are extremely rare.
> >>
> >> The most common problem on modern SATA drives is drive firmware bugs, at 
> >> the moment.
> >>
> > 
> > I moved the drive to another machine with ICH7 and it seems to work fine
> > there. Strange?
> 
> Does dmesg reflect any difference in AHCI version or PHY speed, on 
> either machine?  Did you use the same cables in both tests?
> 
> AHCI version ("0001.0100" == AHCI 1.1):
> ...
> ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
> ...

On the good machine:

[   30.728849] ata1: SATA max UDMA/133 cmd 0x000000000001e400 ctl 0x000000000001e082 bmdma 0x000000000001d880 irq 23
[   30.890918] ata1.00: ATA-7: WDC WD740ADFD-00NLR1, 20.07P20, max UDMA/133
[   30.890966] ata1.00: 145226112 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   30.900957] ata1.00: configured for UDMA/133

Maybe since AHCI isn't enabled in the BIOS on the good machine,
we aren't doing NCQ?

> PHY configuration and speed:
> ...
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ...
> 
> SATA headers (ports) on the motherboard and SATA cables are known to be 
> weak links in the chain, commonly.

I tried a port and cable swap on the bad machine. The good machine
had a new cable, so it still could be the cable.


-- 
Stephen Hemminger <shemminger@linux-foundation.org>
