From: Tejun Heo <htejun@gmail.com>
Subject: Why we were seeing so many spurious NCQ completions
Date: Fri, 07 Dec 2007 11:18:00 +0900
Message-ID: <4758AD58.3000801@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070401040202070208050200"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:18511 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbXLGCSH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Dec 2007 21:18:07 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1069718wah
        for <linux-ide@vger.kernel.org>; Thu, 06 Dec 2007 18:18:07 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, diego torres <dtorres@coral.dnsalias.org>, Michael Tokarev <mjt@tls.msk.ru>

This is a multi-part message in MIME format.
--------------070401040202070208050200
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello, all.

This has been going on for quite some time now but I finally succeeded
to reproduce the problem and find out what has been going on.  It
wasn't drive's or controller's fault.  The spurious completion
detection logic was wrong which makes all of this my fault.  :-)

The attached patch induces NCQ spurious completions by inserting
artificial delays during irq handling.  The following is log with the
patch applied.

A [ 1125.478813] ata35: MON issue=0x0 SAct=0x1 sactive=0x3 SDB FIS=004040a1:00000002
B [ 1125.480248] ata35: MON issue=0x4 SAct=0x6 sactive=0x7 SDB FIS=004040a1:00000001
C [ 1125.481614] ata35: MON issue=0x0 SAct=0x5 sactive=0x7 SDB FIS=004040a1:00000002
D [ 1125.481704] ata35: YYY 0x2 -> 0x4
E [ 1125.481722] ata35: XXX issue=0x0 SAct=0x1 sactive=0x1 SDB FIS=004040a1:00000004
F [ 1125.483087] ata35: MON issue=0x0 SAct=0x0 sactive=0x1 SDB FIS=004040a1:00000001
G [ 1125.484297] ata35: MON issue=0x4 SAct=0x6 sactive=0x7 SDB FIS=004040a1:00000001

MON lines are printed on each SDB FIS while YYY line indicates that
SDB FIS RX area has changed during the artificial delay.  XXX line
notes condition which triggers spurious NCQ completion - invoking EH
is disabled for debugging.

Here's what happens.

1. On A, NCQ command 0 and 1 are in flight - command 0 is still being
   transmitted to the device.  The first SDB FIS indicates completion
   of command 1.

2. Between A and B, the driver issues NCQ commands 1 and 2.  0 is
   still in flight.

3. On B, command 0 completes and drive sends completion for it.

4. Between B and C, the driver issues NCQ command 0.

5. On C, command 1 completes and drive sends completion for it.

6. On D, then the drive completes command 2 and sends completion for
   it.  This makes SDB FIS RX area updated and as the driver is still
   in IRQ handler, sets IRQ pending bit again.  Note that YYY line is
   printed *before* actually completing commands.  So, after printing
   YYY line, the driver completes both commands 1 and 2.

7. On E, the IRQ handler is invoked again because of the IRQ pending
   status set from #6.  However, completions contained in the SDB FIS
   which triggered this IRQ handler invocation is already processed.
   ie. Completion for command 2 is already processed in the previous
   IRQ handler invocation, so this time IRQ handler has nothing to do
   but SDB FIS RX area shows that this IRQ is for SDB FIS which
   includes completion for command 2, which triggers spurious NCQ
   completion condition.

8. It goes on.

So, trying to detect spurious completions using IRQ and RX FIS area
turns out to be stupid as they aren't interlocked.  I'll soon post a
patch to remove spurious completion check and blacklist resulted from
it.

Thanks a lot.

-- 
tejun

--------------070401040202070208050200
Content-Type: text/x-patch;
 name="spurious-completion-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spurious-completion-debug.patch"

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 4688dbf..9f9a658 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1664,6 +1664,10 @@ static void ahci_port_intr(struct ata_port *ap)
 	}
 
 	if (status & PORT_IRQ_SDB_FIS) {
+		const __le32 *f = pp->rx_fis + RX_FIS_SDB;
+		u32 t = le32_to_cpu(f[1]);
+		int i;
+
 		/* If SNotification is available, leave notification
 		 * handling to sata_async_notification().  If not,
 		 * emulate it by snooping SDB FIS RX area.
@@ -1686,6 +1690,32 @@ static void ahci_port_intr(struct ata_port *ap)
 			if (f0 & (1 << 15))
 				sata_async_notification(ap);
 		}
+
+		if (le32_to_cpu(f[1]) & ~pp->active_link->sactive)
+			ata_link_printk(pp->active_link, KERN_INFO,
+				"XXX issue=0x%x SAct=0x%x sactive=0x%x SDB FIS=%08x:%08x\n",
+				readl(port_mmio + PORT_CMD_ISSUE),
+				readl(port_mmio + PORT_SCR_ACT),
+				pp->active_link->sactive,
+				le32_to_cpu(f[0]), le32_to_cpu(f[1]));
+		else
+			ata_link_printk(pp->active_link, KERN_INFO,
+				"MON issue=0x%x SAct=0x%x sactive=0x%x SDB FIS=%08x:%08x\n",
+				readl(port_mmio + PORT_CMD_ISSUE),
+				readl(port_mmio + PORT_SCR_ACT),
+				pp->active_link->sactive,
+				le32_to_cpu(f[0]), le32_to_cpu(f[1]));
+
+		for (i = 0; i < 100; i++) {
+			if (t != le32_to_cpu(f[1])) {
+				ata_link_printk(pp->active_link, KERN_INFO,
+						"YYY 0x%x -> 0x%x\n",
+						t, le32_to_cpu(f[1]));
+				break;
+			}
+			udelay(1);
+			cpu_relax();
+		}
 	}
 
 	/* pp->active_link is valid iff any command is in flight */
@@ -1746,7 +1776,7 @@ static void ahci_port_intr(struct ata_port *ap)
 			 * with HSM violation.  EH will turn off NCQ
 			 * after several such failures.
 			 */
-			ata_ehi_push_desc(ehi,
+			/*			ata_ehi_push_desc(ehi,
 				"spurious completions during NCQ "
 				"issue=0x%x SAct=0x%x FIS=%08x:%08x",
 				readl(port_mmio + PORT_CMD_ISSUE),
@@ -1754,7 +1784,7 @@ static void ahci_port_intr(struct ata_port *ap)
 				le32_to_cpu(f[0]), le32_to_cpu(f[1]));
 			ehi->err_mask |= AC_ERR_HSM;
 			ehi->action |= ATA_EH_SOFTRESET;
-			ata_port_freeze(ap);
+			ata_port_freeze(ap);*/
 		} else {
 			if (!pp->ncq_saw_sdb)
 				ata_port_printk(ap, KERN_INFO,

--------------070401040202070208050200--
