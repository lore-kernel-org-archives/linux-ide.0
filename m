From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/11] libata-eh-fw: add flags and operations for new EH
Date: Thu, 11 May 2006 21:27:23 +0900
Message-ID: <11473504432606-git-send-email-htejun@gmail.com>
References: <11473504433328-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.197]:56748 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751641AbWEKM1a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:27:30 -0400
Received: by nz-out-0102.google.com with SMTP id 13so175445nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:27:29 -0700 (PDT)
In-Reply-To: <11473504433328-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add ATA_FLAG_EH_{PENDING|FROZEN}, ATA_ATA_QCFLAG_{FAILED|SENSE_VALID}
and ops->freeze, thaw, error_handler, post_internal_cmd() for new EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

7adb784b36e6b4302540a3edb58cddb3ba0a4b83
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7b54d92..302df2d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -146,13 +146,16 @@ enum {
 	ATA_FLAG_PIO_LBA48	= (1 << 8), /* Host DMA engine is LBA28 only */
 	ATA_FLAG_IRQ_MASK	= (1 << 9), /* Mask IRQ in PIO xfers */
 
-	ATA_FLAG_NOINTR		= (1 << 16), /* FIXME: Remove this once
+	ATA_FLAG_NOINTR		= (1 << 13), /* FIXME: Remove this once
 					      * proper HSM is in place. */
-	ATA_FLAG_DEBUGMSG	= (1 << 17),
-	ATA_FLAG_FLUSH_PORT_TASK = (1 << 18), /* flush port task */
+	ATA_FLAG_DEBUGMSG	= (1 << 14),
+	ATA_FLAG_FLUSH_PORT_TASK = (1 << 15), /* flush port task */
 
-	ATA_FLAG_DISABLED	= (1 << 19), /* port is disabled, ignore it */
-	ATA_FLAG_SUSPENDED	= (1 << 20), /* port is suspended */
+	ATA_FLAG_EH_PENDING	= (1 << 16), /* EH pending */
+	ATA_FLAG_FROZEN		= (1 << 17), /* port is frozen */
+
+	ATA_FLAG_DISABLED	= (1 << 22), /* port is disabled, ignore it */
+	ATA_FLAG_SUSPENDED	= (1 << 23), /* port is suspended (power) */
 
 	/* bits 24:31 of ap->flags are reserved for LLDD specific flags */
 
@@ -164,7 +167,9 @@ enum {
 	ATA_QCFLAG_IO		= (1 << 3), /* standard IO command */
 	ATA_QCFLAG_RESULT_TF	= (1 << 4), /* result TF requested */
 
-	ATA_QCFLAG_EH_SCHEDULED = (1 << 16), /* EH scheduled */
+	ATA_QCFLAG_FAILED	= (1 << 16), /* cmd failed and is owned by EH */
+	ATA_QCFLAG_SENSE_VALID	= (1 << 17), /* sense data valid */
+	ATA_QCFLAG_EH_SCHEDULED = (1 << 18), /* EH scheduled (obsolete) */
 
 	/* host set flags */
 	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host_set only */
@@ -463,7 +468,15 @@ struct ata_port_operations {
 	void (*qc_prep) (struct ata_queued_cmd *qc);
 	unsigned int (*qc_issue) (struct ata_queued_cmd *qc);
 
-	void (*eng_timeout) (struct ata_port *ap);
+	/* Error handlers.  ->error_handler overrides ->eng_timeout and
+	 * indicates that new-style EH is in place.
+	 */
+	void (*eng_timeout) (struct ata_port *ap); /* obsolete */
+
+	void (*freeze) (struct ata_port *ap);
+	void (*thaw) (struct ata_port *ap);
+	void (*error_handler) (struct ata_port *ap);
+	void (*post_internal_cmd) (struct ata_queued_cmd *qc);
 
 	irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
 	void (*irq_clear) (struct ata_port *);
-- 
1.2.4


