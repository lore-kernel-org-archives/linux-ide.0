From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/2] libata: shift ATA_FLAG_* bits to make room for a new flag
Date: Mon, 12 Jun 2006 23:44:33 +0900
Message-ID: <20060612144433.GC3892@htj.dyndns.org>
References: <20060612144100.GB3892@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:37515 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751954AbWFLOoj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 10:44:39 -0400
Received: by py-out-1112.google.com with SMTP id x31so1712399pye
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 07:44:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060612144100.GB3892@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Shift ATA_FLAG_* bits to make room for a new flag.  Note that a lot of
flags are scheduled to move out so this juggling won't be needed in
not-so-distant future.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Jeff, I chickened out and chose to kill ATA_FLAG_SRST and make room
for just one flag I need now.  Thinking about BMDMA separation seems
too big at the moment and at least three more flags are scheduled to
be removed / moved out from ATA_FLAG_*, so this should be okay for the
time being.

 include/linux/libata.h |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

61a006e06b82c1a57b37efb5649b4aff3bcfa2bf
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5feb912..369f821 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -148,30 +148,30 @@ enum {
 	ATA_FLAG_SATA		= (1 << 1),
 	ATA_FLAG_NO_LEGACY	= (1 << 2), /* no legacy mode check */
 	ATA_FLAG_MMIO		= (1 << 3), /* use MMIO, not PIO */
-	ATA_FLAG_SATA_RESET	= (1 << 5), /* (obsolete) use COMRESET */
-	ATA_FLAG_NO_ATAPI	= (1 << 6), /* No ATAPI support */
-	ATA_FLAG_PIO_DMA	= (1 << 7), /* PIO cmds via DMA */
-	ATA_FLAG_PIO_LBA48	= (1 << 8), /* Host DMA engine is LBA28 only */
-	ATA_FLAG_PIO_POLLING	= (1 << 9), /* use polling PIO if LLD
+	ATA_FLAG_SATA_RESET	= (1 << 4), /* (obsolete) use COMRESET */
+	ATA_FLAG_NO_ATAPI	= (1 << 5), /* No ATAPI support */
+	ATA_FLAG_PIO_DMA	= (1 << 6), /* PIO cmds via DMA */
+	ATA_FLAG_PIO_LBA48	= (1 << 7), /* Host DMA engine is LBA28 only */
+	ATA_FLAG_PIO_POLLING	= (1 << 8), /* use polling PIO if LLD
 					     * doesn't handle PIO interrupts */
-	ATA_FLAG_NCQ		= (1 << 10), /* host supports NCQ */
-	ATA_FLAG_HRST_TO_RESUME	= (1 << 11), /* hardreset to resume phy */
-	ATA_FLAG_SKIP_D2H_BSY	= (1 << 12), /* can't wait for the first D2H
+	ATA_FLAG_NCQ		= (1 << 9), /* host supports NCQ */
+	ATA_FLAG_HRST_TO_RESUME	= (1 << 10), /* hardreset to resume phy */
+	ATA_FLAG_SKIP_D2H_BSY	= (1 << 11), /* can't wait for the first D2H
 					      * Register FIS clearing BSY */
 
-	ATA_FLAG_DEBUGMSG	= (1 << 13),
-	ATA_FLAG_FLUSH_PORT_TASK = (1 << 14), /* flush port task */
+	ATA_FLAG_DEBUGMSG	= (1 << 12),
+	ATA_FLAG_FLUSH_PORT_TASK = (1 << 13), /* flush port task */
 
-	ATA_FLAG_EH_PENDING	= (1 << 15), /* EH pending */
-	ATA_FLAG_EH_IN_PROGRESS	= (1 << 16), /* EH in progress */
-	ATA_FLAG_FROZEN		= (1 << 17), /* port is frozen */
-	ATA_FLAG_RECOVERED	= (1 << 18), /* recovery action performed */
-	ATA_FLAG_LOADING	= (1 << 19), /* boot/loading probe */
-	ATA_FLAG_UNLOADING	= (1 << 20), /* module is unloading */
-	ATA_FLAG_SCSI_HOTPLUG	= (1 << 21), /* SCSI hotplug scheduled */
+	ATA_FLAG_EH_PENDING	= (1 << 14), /* EH pending */
+	ATA_FLAG_EH_IN_PROGRESS	= (1 << 15), /* EH in progress */
+	ATA_FLAG_FROZEN		= (1 << 16), /* port is frozen */
+	ATA_FLAG_RECOVERED	= (1 << 17), /* recovery action performed */
+	ATA_FLAG_LOADING	= (1 << 18), /* boot/loading probe */
+	ATA_FLAG_UNLOADING	= (1 << 19), /* module is unloading */
+	ATA_FLAG_SCSI_HOTPLUG	= (1 << 20), /* SCSI hotplug scheduled */
 
-	ATA_FLAG_DISABLED	= (1 << 22), /* port is disabled, ignore it */
-	ATA_FLAG_SUSPENDED	= (1 << 23), /* port is suspended (power) */
+	ATA_FLAG_DISABLED	= (1 << 21), /* port is disabled, ignore it */
+	ATA_FLAG_SUSPENDED	= (1 << 22), /* port is suspended (power) */
 
 	/* bits 24:31 of ap->flags are reserved for LLDD specific flags */
 
-- 
1.3.2

