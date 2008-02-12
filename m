From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/10] libata: reorganize ata_port_operations
Date: Tue, 12 Feb 2008 17:43:13 +0900
Message-ID: <12028058012734-git-send-email-htejun@gmail.com>
References: <1202805801343-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:45012 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbYBLIng (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 03:43:36 -0500
Received: by wx-out-0506.google.com with SMTP id h31so5070470wxd.4
        for <linux-ide@vger.kernel.org>; Tue, 12 Feb 2008 00:43:35 -0800 (PST)
In-Reply-To: <1202805801343-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@arm.linux.org.uk, alessandro.zummo@towertech
Cc: Tejun Heo <htejun@gmail.com>

Over the time, ops in ata_port_operations has become a bit confusing.
Reorganize.  SFF/BMDMA ops are separated into separate a group as they
will be taken out of ata_port_operations later.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/libata.h |  117 +++++++++++++++++++++++++-----------------------
 1 files changed, 61 insertions(+), 56 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index a7882a2..7e012d9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -672,69 +672,74 @@ struct ata_port {
 };
 
 struct ata_port_operations {
-	void (*dev_config) (struct ata_device *);
+	/*
+	 * Command execution
+	 */
+	int  (*qc_defer)(struct ata_queued_cmd *qc);
+	int  (*check_atapi_dma)(struct ata_queued_cmd *qc);
+	void (*qc_prep)(struct ata_queued_cmd *qc);
+	unsigned int (*qc_issue)(struct ata_queued_cmd *qc);
 
-	void (*set_piomode) (struct ata_port *, struct ata_device *);
-	void (*set_dmamode) (struct ata_port *, struct ata_device *);
-	unsigned long (*mode_filter) (struct ata_device *, unsigned long);
+	/*
+	 * Configuration and exception handling
+	 */
+	int  (*cable_detect)(struct ata_port *ap);
+	unsigned long (*mode_filter)(struct ata_device *dev, unsigned long xfer_mask);
+	void (*set_piomode)(struct ata_port *ap, struct ata_device *dev);
+	void (*set_dmamode)(struct ata_port *ap, struct ata_device *dev);
+	int  (*set_mode)(struct ata_link *link, struct ata_device **r_failed_dev);
 
-	void (*tf_load) (struct ata_port *ap, const struct ata_taskfile *tf);
-	void (*tf_read) (struct ata_port *ap, struct ata_taskfile *tf);
+	void (*dev_config)(struct ata_device *dev);
 
-	void (*exec_command)(struct ata_port *ap, const struct ata_taskfile *tf);
+	void (*freeze)(struct ata_port *ap);
+	void (*thaw)(struct ata_port *ap);
+	void (*error_handler)(struct ata_port *ap);
+	void (*post_internal_cmd)(struct ata_queued_cmd *qc);
+
+	/*
+	 * Optional features
+	 */
+	int  (*scr_read)(struct ata_port *ap, unsigned int sc_reg, u32 *val);
+	int  (*scr_write)(struct ata_port *ap, unsigned int sc_reg, u32 val);
+	void (*pmp_attach)(struct ata_port *ap);
+	void (*pmp_detach)(struct ata_port *ap);
+	int  (*enable_pm)(struct ata_port *ap, enum link_pm policy);
+	void (*disable_pm)(struct ata_port *ap);
+
+	/*
+	 * Start, stop, suspend and resume
+	 */
+	int  (*port_suspend)(struct ata_port *ap, pm_message_t mesg);
+	int  (*port_resume)(struct ata_port *ap);
+	int  (*port_start)(struct ata_port *ap);
+	void (*port_stop)(struct ata_port *ap);
+	void (*host_stop)(struct ata_host *host);
+
+	/*
+	 * SFF / taskfile oriented ops
+	 */
+	void (*dev_select)(struct ata_port *ap, unsigned int device);
 	u8   (*check_status)(struct ata_port *ap);
 	u8   (*check_altstatus)(struct ata_port *ap);
-	void (*dev_select)(struct ata_port *ap, unsigned int device);
-
-	void (*phy_reset) (struct ata_port *ap); /* obsolete */
-	int  (*set_mode) (struct ata_link *link, struct ata_device **r_failed_dev);
-
-	int (*cable_detect) (struct ata_port *ap);
-
-	int  (*check_atapi_dma) (struct ata_queued_cmd *qc);
-
-	void (*bmdma_setup) (struct ata_queued_cmd *qc);
-	void (*bmdma_start) (struct ata_queued_cmd *qc);
-
-	unsigned int (*data_xfer) (struct ata_device *dev, unsigned char *buf,
-				   unsigned int buflen, int rw);
-
-	int (*qc_defer) (struct ata_queued_cmd *qc);
-	void (*qc_prep) (struct ata_queued_cmd *qc);
-	unsigned int (*qc_issue) (struct ata_queued_cmd *qc);
-
-	/* port multiplier */
-	void (*pmp_attach) (struct ata_port *ap);
-	void (*pmp_detach) (struct ata_port *ap);
-
-	/* Error handlers.  ->error_handler overrides ->eng_timeout and
-	 * indicates that new-style EH is in place.
+	void (*tf_load)(struct ata_port *ap, const struct ata_taskfile *tf);
+	void (*tf_read)(struct ata_port *ap, struct ata_taskfile *tf);
+	void (*exec_command)(struct ata_port *ap, const struct ata_taskfile *tf);
+	unsigned int (*data_xfer)(struct ata_device *dev, unsigned char *buf,
+				  unsigned int buflen, int rw);
+	u8   (*irq_on)(struct ata_port *);
+
+	void (*irq_clear)(struct ata_port *);
+	void (*bmdma_setup)(struct ata_queued_cmd *qc);
+	void (*bmdma_start)(struct ata_queued_cmd *qc);
+	void (*bmdma_stop)(struct ata_queued_cmd *qc);
+	u8   (*bmdma_status)(struct ata_port *ap);
+
+	/*
+	 * Obsolete
 	 */
-	void (*eng_timeout) (struct ata_port *ap); /* obsolete */
-
-	void (*freeze) (struct ata_port *ap);
-	void (*thaw) (struct ata_port *ap);
-	void (*error_handler) (struct ata_port *ap);
-	void (*post_internal_cmd) (struct ata_queued_cmd *qc);
-
+	void (*phy_reset)(struct ata_port *ap);
+	void (*eng_timeout)(struct ata_port *ap);
 	irq_handler_t irq_handler;
-	void (*irq_clear) (struct ata_port *);
-	u8 (*irq_on) (struct ata_port *);
-
-	int (*scr_read) (struct ata_port *ap, unsigned int sc_reg, u32 *val);
-	int (*scr_write) (struct ata_port *ap, unsigned int sc_reg, u32 val);
-
-	int (*port_suspend) (struct ata_port *ap, pm_message_t mesg);
-	int (*port_resume) (struct ata_port *ap);
-	int (*enable_pm) (struct ata_port *ap, enum link_pm policy);
-	void (*disable_pm) (struct ata_port *ap);
-	int (*port_start) (struct ata_port *ap);
-	void (*port_stop) (struct ata_port *ap);
-
-	void (*host_stop) (struct ata_host *host);
-
-	void (*bmdma_stop) (struct ata_queued_cmd *qc);
-	u8   (*bmdma_status) (struct ata_port *ap);
 };
 
 struct ata_port_info {
-- 
1.5.2.4

