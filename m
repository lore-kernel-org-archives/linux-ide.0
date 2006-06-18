From: Tejun Heo <htejun@gmail.com>
Subject: Re: Seagate SATA 3GB/s drive connected to via vt8251 using ahci	module
Date: Sun, 18 Jun 2006 11:56:32 +0900
Message-ID: <20060618025632.GE11755@htj.dyndns.org>
References: <1149787827.4180.8.camel@anja> <44890ACA.5070504@gmail.com> <1150108974.4020.3.camel@anja> <448D474E.6020706@gmail.com> <1150111457.4060.2.camel@anja>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:48948 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932072AbWFRC4e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 Jun 2006 22:56:34 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1413532nze
        for <linux-ide@vger.kernel.org>; Sat, 17 Jun 2006 19:56:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1150111457.4060.2.camel@anja>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aalderd Bouwman <aalderd.boac@wanadoo.nl>
Cc: linux-ide@vger.kernel.org

Can you apply the following patch and report back what the kernel
says?  The following might generate quite a bit of log messages, but
if your boot drive doesn't generate spurious interrupts, it should be
bearable.

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index e261b37..be3ee0d 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -909,25 +909,18 @@ static void ahci_host_intr(struct ata_po
 	}
 
 	/* hmmm... a spurious interupt */
+	ata_port_printk(ap, KERN_INFO, "spurious interrupt "
+			"(irq_stat 0x%x active_tag %x sactive 0x%x)\n",
+			status, ap->active_tag, ap->sactive);
 
-	/* some devices send D2H reg with I bit set during NCQ command phase */
-	if (ap->sactive && status & PORT_IRQ_D2H_REG_FIS)
-		return;
-
-	/* ignore interim PIO setup fis interrupts */
-	if (ata_tag_valid(ap->active_tag)) {
-		struct ata_queued_cmd *qc =
-			ata_qc_from_tag(ap, ap->active_tag);
+	if (status & PORT_IRQ_SDB_FIS) {
+		struct ahci_port_priv *pp = ap->private_data;
+		u32 *sdb_fis = pp->rx_fis + 0x58;
 
-		if (qc && qc->tf.protocol == ATA_PROT_PIO &&
-		    (status & PORT_IRQ_PIOS_FIS))
-			return;
+		ata_port_printk(ap, KERN_INFO, "spurious SDB FIS "
+				"%08x:%08x ap->qc_active=%08x qc_active=%08x\n",
+				sdb_fis[0], sdb_fis[1], ap->qc_active, qc_active);
 	}
-
-	if (ata_ratelimit())
-		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
-				"(irq_stat 0x%x active_tag %d sactive 0x%x)\n",
-				status, ap->active_tag, ap->sactive);
 }
 
 static void ahci_irq_clear(struct ata_port *ap)
