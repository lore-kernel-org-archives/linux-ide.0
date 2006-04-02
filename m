From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/15] libata: clean up constants
Date: Sun, 2 Apr 2006 18:51:52 +0900
Message-ID: <11439715123942-git-send-email-htejun@gmail.com>
References: <11439715124131-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:5252 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932303AbWDBJwB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 05:52:01 -0400
Received: by zproxy.gmail.com with SMTP id o37so1447008nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 01:51:59 -0800 (PST)
In-Reply-To: <11439715124131-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

* Reorder ATA_DFLAG_* such that feature flags determined by
  ata_dev_configure() are on lower bits.  Reserve lower eight bits
  for this purpose and allocate dynamic flags from bit 8.

* Reorder ATA_FLAG_* such that feature flags determined during driver
  initiailization are on bits 0:15, dynamic flags on 16:23 and LLDD
  specific flags on 24:31.

* Kill trailing white space and lower-case an one line comment for
  consistency.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |   61 +++++++++++++++++++++++++-----------------------
 1 files changed, 32 insertions(+), 29 deletions(-)

709989f4987b39757c9014e6259b3562be502923
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e20b0bf..b7488a3 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -120,9 +120,10 @@ enum {
 	ATA_SHT_USE_CLUSTERING	= 1,
 
 	/* struct ata_device stuff */
-	ATA_DFLAG_LBA48		= (1 << 0), /* device supports LBA48 */
-	ATA_DFLAG_PIO		= (1 << 1), /* device currently in PIO mode */
-	ATA_DFLAG_LBA		= (1 << 2), /* device supports LBA */
+	ATA_DFLAG_LBA		= (1 << 0), /* device supports LBA */
+	ATA_DFLAG_LBA48		= (1 << 1), /* device supports LBA48 */
+
+	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
@@ -132,32 +133,34 @@ enum {
 	ATA_DEV_NONE		= 5,	/* no device */
 
 	/* struct ata_port flags */
-	ATA_FLAG_SLAVE_POSS	= (1 << 1), /* host supports slave dev */
+	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
 					    /* (doesn't imply presence) */
-	ATA_FLAG_PORT_DISABLED	= (1 << 2), /* port is disabled, ignore it */
-	ATA_FLAG_SATA		= (1 << 3),
-	ATA_FLAG_NO_LEGACY	= (1 << 4), /* no legacy mode check */
-	ATA_FLAG_SRST		= (1 << 5), /* (obsolete) use ATA SRST, not E.D.D. */
-	ATA_FLAG_MMIO		= (1 << 6), /* use MMIO, not PIO */
-	ATA_FLAG_SATA_RESET	= (1 << 7), /* (obsolete) use COMRESET */
-	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
-	ATA_FLAG_NOINTR		= (1 << 9), /* FIXME: Remove this once
-					     * proper HSM is in place. */
-	ATA_FLAG_DEBUGMSG	= (1 << 10),
-	ATA_FLAG_NO_ATAPI	= (1 << 11), /* No ATAPI support */
-
-	ATA_FLAG_SUSPENDED	= (1 << 12), /* port is suspended */
-
-	ATA_FLAG_PIO_LBA48	= (1 << 13), /* Host DMA engine is LBA28 only */
-	ATA_FLAG_IRQ_MASK	= (1 << 14), /* Mask IRQ in PIO xfers */
-
-	ATA_FLAG_FLUSH_PORT_TASK = (1 << 15), /* Flush port task */
-
-	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
-	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
-	ATA_QCFLAG_SINGLE	= (1 << 4), /* no s/g, just a single buffer */
+	ATA_FLAG_SATA		= (1 << 1),
+	ATA_FLAG_NO_LEGACY	= (1 << 2), /* no legacy mode check */
+	ATA_FLAG_MMIO		= (1 << 3), /* use MMIO, not PIO */
+	ATA_FLAG_SRST		= (1 << 4), /* (obsolete) use ATA SRST, not E.D.D. */
+	ATA_FLAG_SATA_RESET	= (1 << 5), /* (obsolete) use COMRESET */
+	ATA_FLAG_NO_ATAPI	= (1 << 6), /* No ATAPI support */
+	ATA_FLAG_PIO_DMA	= (1 << 7), /* PIO cmds via DMA */
+	ATA_FLAG_PIO_LBA48	= (1 << 8), /* Host DMA engine is LBA28 only */
+	ATA_FLAG_IRQ_MASK	= (1 << 9), /* Mask IRQ in PIO xfers */
+
+	ATA_FLAG_NOINTR		= (1 << 16), /* FIXME: Remove this once
+					      * proper HSM is in place. */
+	ATA_FLAG_DEBUGMSG	= (1 << 17),
+	ATA_FLAG_FLUSH_PORT_TASK = (1 << 18), /* flush port task */
+
+	ATA_FLAG_PORT_DISABLED	= (1 << 19), /* port is disabled, ignore it */
+	ATA_FLAG_SUSPENDED	= (1 << 20), /* port is suspended */
+
+	/* bits 24:31 of ap->flags are reserved for LLDD specific flags */
+
+	/* struct ata_queued_cmd flags */
+	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */
+	ATA_QCFLAG_SG		= (1 << 1), /* have s/g table? */
+	ATA_QCFLAG_SINGLE	= (1 << 2), /* no s/g, just a single buffer */
 	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
-	ATA_QCFLAG_EH_SCHEDULED = (1 << 5), /* EH scheduled */
+	ATA_QCFLAG_EH_SCHEDULED = (1 << 3), /* EH scheduled */
 
 	/* host set flags */
 	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host_set only */
@@ -206,8 +209,8 @@ enum {
 	/* size of buffer to pad xfers ending on unaligned boundaries */
 	ATA_DMA_PAD_SZ		= 4,
 	ATA_DMA_PAD_BUF_SZ	= ATA_DMA_PAD_SZ * ATA_MAX_QUEUE,
-	
-	/* Masks for port functions */
+
+	/* masks for port functions */
 	ATA_PORT_PRIMARY	= (1 << 0),
 	ATA_PORT_SECONDARY	= (1 << 1),
 
-- 
1.2.4


