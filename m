From: "Trent George" <trent@norwalkdist.com>
Subject: Re: dvd-r detection problem with port multiplier
Date: Tue, 26 Sep 2006 17:22:46 -0700
Message-ID: <KMS--2047072133-2724@mail.norwalkdist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adsl-64-165-178-101.dsl.lsan03.pacbell.net ([64.165.178.101]:58372
	"EHLO mail.norwalkdist.com") by vger.kernel.org with ESMTP
	id S1750801AbWI0AWR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Sep 2006 20:22:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi Tejun,

Well after 2 days and nights of trying to hack into the driver to figure what is my problem....

I have a fix for me, and an explanation
The problem seemed related to a pioneer drive and bridgeboard

I modified sata_sil24.c with the following addition

in the sil24_do_softreset funtion:

+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;

	/* put the port into known state */
	if (sil24_init_port(ap)) {
		reason ="port not ready";
		goto err;
	}

+	ata_wait_register(port + PORT_CTRL_STAT, 0x1f0000,
+		x1f0000, 10, 2000);
+	
	/* do SRST */
	ata_tf_init(link->device, &tf);	/* doesn't really matter */

this will wait until the "active slot" of the "port status" field changes from the port mulitpler pmp id of 0x1f (still executing previous command)

it seemed there was a delay from 12 to 84 jiffies for this to clear.

everything works perfect for me now.

sorry I dont know how to post a patch using the correct method.

and I know this is not the "correct" fix, but it is the essence of what needs to be done. This will probablly fix the issue of mixing ATAPI and ATA devices, slow devices or bridgeboards causing reset cycling, and using or not the pmp port 0

Trent

ps: I used this ugly code to see what was happening:
------------
	tmp0 = ata_wait_register(port + PORT_CTRL_STAT,	PORT_CS_RDY,
		0, 10, 10);
	tmp1 = jiffies;
	tmp = ata_wait_register(port + PORT_CTRL_STAT,	0x1f0000,
		0x1f0000, 10, 1000);
	ata_link_printk(link, KERN_ERR, "wait for ready on pmp %d %x %x %d\n ", pmp, tmp0, tmp, jiffies-tmp1);
--------------


> Hello, Trent.
> 
> Trent George wrote:
> [--snip--]
> > I should have mentioned that they have sata to pata bridgeboards
> > on the drives.
> 
> That shouldn't change much.
> 
> > I tried rebooting, with discs in and not in the drives.
> > I can send you a physical bridgeboard, or drive if it helps you...
> > the samsung hard drive is on the motherboard sata controller.
> > the dvd drives are on pmp on the sata_sil24 board
> 
> I have plenty of SATA and PMP hardware these days, so thanks but that 
> wouldn't be necessary.
> 
> [--snip--]
> > sata_sil24 0000:01:00.0: version 0.3
> > ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
> > PCI: Setting latency timer of device 0000:01:00.0 to 64
> > ata3: SATA max UDMA/100 cmd 0xFFFFC20000020000 ctl 0x0 bmdma 0x0 irq 169
> > ata4: SATA max UDMA/100 cmd 0xFFFFC20000022000 ctl 0x0 bmdma 0x0 irq 169
> > scsi2 : sata_sil24
> > sd 0:0:0:0: Attached scsi generic sg0 type 0
> > ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 5 ports, feat 0x9/0x9
> > ata3.00: hard resetting port
> > ata3.00: softreset failed (timeout)
> > ata3.00: follow-up softreset failed, retrying in 5 secs
> > ata3.00: hard resetting port
> > ata3.00: COMRESET failed (errno=3D-16)
> > ata3.00: reset failed, giving up
> > ata3.15: hard resetting port
> > ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > ata3.00: hard resetting port
> > ata3.00: softreset failed (timeout)
> > ata3.00: follow-up softreset failed, retrying in 5 secs
> > ata3.00: hard resetting port
> > ata3.00: COMRESET failed (errno=3D-16)
> > ata3.00: reset failed, giving up
> > ata3.00: failed to recover link after 2 tries, disabling
> 
> Is the first port occupied?  3726 seems to fail initialization if the 
> first port is not occupied.  At the moment, I'm not very sure whether 
> the hardware or the driver is responsible for this.  When this happens, 
> all other ports fail too which is consistent with your result.
> 
> [--snip--]
> > sata_sil24 0000:01:00.0: version 0.3
> > ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
> > PCI: Setting latency timer of device 0000:01:00.0 to 64
> > ata3: SATA max UDMA/100 cmd 0xFFFFC20000020000 ctl 0x0 bmdma 0x0 irq 169
> > Losing some ticks... checking if CPU frequency changed.
> > sd 0:0:0:0: Attached scsi generic sg0 type 0
> > ata4: SATA max UDMA/100 cmd 0xFFFFC20000022000 ctl 0x0 bmdma 0x0 irq 169
> > scsi2 : sata_sil24
> > ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > ata3.00: ATAPI, max UDMA/66
> > ata3.00: configured for UDMA/66
> > scsi3 : sata_sil24
> > ata4: SATA link down (SStatus 0 SControl 300)
> >   Vendor: _NEC      Model: DVD_RW ND-3550A   Rev: 1.G3
> >   Type:   CD-ROM                             ANSI SCSI revision: 05
> 
> Ah... So your ATAPI device is connected to the first port.  Can you swap 
> the two and see what happens?  Does the same setup work okay on windows?
> 
> Thanks for testing.
> 
> -- 
> tejun

