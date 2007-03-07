From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_promise SATA300TX4 "intermittent problems"
Date: Wed, 7 Mar 2007 21:12:54 +0100
Message-ID: <17903.7366.875191.751728@alkaid.it.uu.se>
References: <45EECD12.1000506@how.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:33769 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965589AbXCGUNB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Mar 2007 15:13:01 -0500
In-Reply-To: <45EECD12.1000506@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Favrholdt <linux-ide@how.dk>
Cc: linux-ide@vger.kernel.org

Peter Favrholdt writes:
 > Hi,
 > 
 > I've seen "intermittent problems" with Promise SATA300 TX4 controllers
 > and Linux kernel 2.6.19 (through 2.6.20-rc2 with some additional
 > patches).
 > 
 > Sometimes the TX4 will loose a port - a reboot brings the drive back up 
 > again. I'm quite sure the harddrives are not at fault.
 > 
 > I have experienced this using "plain vanilla" Linux 2.6.19.2 and 
 > 2.6.20.1. Today I have tested using Linux 2.6.21-rc2 with Mikael 
 > Petterson's patches (more on that further down).
 > 
 > Yesterday (using 2.6.20.1) I could fail two out of four drives by doing:
 > dd if=/dev/sda of=/dev/null bs=1M &
 > dd if=/dev/sdb of=/dev/null bs=1M &
 > dd if=/dev/sdc of=/dev/null bs=1M &
 > dd if=/dev/sdd of=/dev/null bs=1M &
 > 
 > sdd would fail first then after a while sdc, here is the dmesg output 
 > when sdd failed:
 > 
 > [14895.092650] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000 
 > action 0x2 frozen

SErr 0x01380000 would indicate:
transport state transmission error (bit 24)
CRC error (bit 21)
disparity error (bit 20) [whatever that is]
10b_to_8b decoding error (bit 19)

I.e., serious transmission issues.

 > [52849.930755] pdc_error_intr: port_status 0x00001000 serror 0x00000000
 > [52849.930880] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 
 > frozen
 > [52849.930883] ata2.00: (port_status 0x00001000)

"host bus timeout error" (bit 12).
I wonder why SError was clear now.

 > I would be very happy to help debug this issue. Any suggestions on what 
 > I should try next?

Well, at the moment I have only one possible cure: to forcibly
limit 3Gbps drives to 1.5Gbps operation, as the patch below does.

On one of my test machines (an old UltraSPARC), a SATA300 TX2plus
with a Seagate 3Gbps drive (don't have the model number handy),
will quickly experience "DMA S/G overrun" errors during an fsck
of a large but clean ext3 partition. With the patch below things
work solidly on that particular machine. OTOH, on another test
machine (a 440BX chipset Intel PIII), the same card/cable/disk
combination works flawlessly at 3Gbps. Mysterious.

/Mikael

--- linux-2.6.21-rc2/drivers/ata/sata_promise.c.~1~	2007-03-06 22:17:21.000000000 +0100
+++ linux-2.6.21-rc2/drivers/ata/sata_promise.c	2007-03-06 23:21:36.000000000 +0100
@@ -378,6 +378,18 @@ static int pdc_port_start(struct ata_por
 		writel(tmp, mmio + 0x014);
 	}
 
+	/* hack SControl to limit speed to 1.5Gbps */
+	if ((hp->flags & PDC_FLAG_GEN_II) && sata_scr_valid(ap)) {
+		void __iomem *mmio = (void __iomem *) ap->ioaddr.scr_addr;
+		unsigned int tmp1, tmp2;
+
+		tmp1 = readl(mmio + 0x008);
+		tmp2 = (tmp1 & 0xffffff00) | 0x00000011;
+		writel(tmp2, mmio + 0x008);
+		readl(mmio + 0x008); /* flush */
+		printk("%s(port %u): adjusted SControl from 0x%08x to 0x%08x\n", __FUNCTION__, ap->port_no, tmp1, tmp2);
+	}
+
 	return 0;
 }
 
