Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AADC3F2D8
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E95721775
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgCCJjo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:47428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727706AbgCCJjn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 29EF2B1CE;
        Tue,  3 Mar 2020 09:39:41 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 02/40] libata.h: whitespace and indentation fixes
Date:   Tue,  3 Mar 2020 10:37:35 +0100
Message-Id: <20200303093813.18523-3-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 include/linux/libata.h | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 710e09dae910..a19ede5644e7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -593,7 +593,7 @@ struct ata_ioports {
 
 struct ata_host {
 	spinlock_t		lock;
-	struct device 		*dev;
+	struct device		*dev;
 	void __iomem * const	*iomap;
 	unsigned int		n_ports;
 	unsigned int		n_tags;			/* nr of NCQ tags */
@@ -813,7 +813,7 @@ struct ata_port {
 	/* Flags that change dynamically, protected by ap->lock */
 	unsigned int		pflags; /* ATA_PFLAG_xxx */
 	unsigned int		print_id; /* user visible unique port ID */
-	unsigned int            local_port_no; /* host local port num */
+	unsigned int		local_port_no; /* host local port num */
 	unsigned int		port_no; /* 0 based port no. inside the host */
 
 #ifdef CONFIG_ATA_SFF
@@ -848,7 +848,7 @@ struct ata_port {
 
 	struct ata_port_stats	stats;
 	struct ata_host		*host;
-	struct device 		*dev;
+	struct device		*dev;
 	struct device		tdev;
 
 	struct mutex		scsi_scan_mutex;
@@ -900,11 +900,14 @@ struct ata_port_operations {
 	 * Configuration and exception handling
 	 */
 	int  (*cable_detect)(struct ata_port *ap);
-	unsigned long (*mode_filter)(struct ata_device *dev, unsigned long xfer_mask);
+	unsigned long (*mode_filter)(struct ata_device *dev,
+				     unsigned long xfer_mask);
 	void (*set_piomode)(struct ata_port *ap, struct ata_device *dev);
 	void (*set_dmamode)(struct ata_port *ap, struct ata_device *dev);
-	int  (*set_mode)(struct ata_link *link, struct ata_device **r_failed_dev);
-	unsigned int (*read_id)(struct ata_device *dev, struct ata_taskfile *tf, u16 *id);
+	int  (*set_mode)(struct ata_link *link,
+			 struct ata_device **r_failed_dev);
+	unsigned int (*read_id)(struct ata_device *dev,
+				struct ata_taskfile *tf, u16 *id);
 
 	void (*dev_config)(struct ata_device *dev);
 
@@ -999,7 +1002,7 @@ struct ata_port_info {
 	unsigned long		mwdma_mask;
 	unsigned long		udma_mask;
 	struct ata_port_operations *port_ops;
-	void 			*private_data;
+	void			*private_data;
 };
 
 struct ata_timing {
@@ -1103,7 +1106,8 @@ extern int ata_host_activate(struct ata_host *host, int irq,
 			     irq_handler_t irq_handler, unsigned long irq_flags,
 			     struct scsi_host_template *sht);
 extern void ata_host_detach(struct ata_host *host);
-extern void ata_host_init(struct ata_host *, struct device *, struct ata_port_operations *);
+extern void ata_host_init(struct ata_host *, struct device *,
+			  struct ata_port_operations *);
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, unsigned int cmd,
 			  void __user *arg);
@@ -1117,7 +1121,8 @@ extern int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *dev,
 			    unsigned int cmd, void __user *arg);
 extern void ata_sas_port_destroy(struct ata_port *);
 extern struct ata_port *ata_sas_port_alloc(struct ata_host *,
-					   struct ata_port_info *, struct Scsi_Host *);
+					   struct ata_port_info *,
+					   struct Scsi_Host *);
 extern void ata_sas_async_probe(struct ata_port *ap);
 extern int ata_sas_sync_probe(struct ata_port *ap);
 extern int ata_sas_port_init(struct ata_port *);
@@ -1188,12 +1193,17 @@ extern int ata_scsi_slave_config(struct scsi_device *sdev);
 extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
 extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
 				       int queue_depth);
-extern int __ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sdev,
+extern int __ata_change_queue_depth(struct ata_port *ap,
+				    struct scsi_device *sdev,
 				    int queue_depth);
 extern struct ata_device *ata_dev_pair(struct ata_device *adev);
-extern int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
-extern void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap);
-extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap, struct list_head *eh_q);
+extern int ata_do_set_mode(struct ata_link *link,
+			   struct ata_device **r_failed_dev);
+extern void ata_scsi_port_error_handler(struct Scsi_Host *host,
+					struct ata_port *ap);
+extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host,
+				       struct ata_port *ap,
+				       struct list_head *eh_q);
 extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
 
 extern int ata_cable_40wire(struct ata_port *ap);
@@ -1223,7 +1233,8 @@ struct pci_bits {
 	unsigned long		val;
 };
 
-extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
+extern int pci_test_config_bits(struct pci_dev *pdev,
+				const struct pci_bits *bits);
 extern void ata_pci_shutdown_one(struct pci_dev *pdev);
 extern void ata_pci_remove_one(struct pci_dev *pdev);
 
@@ -1497,7 +1508,7 @@ static inline bool ata_tag_valid(unsigned int tag)
  * Internal use only, iterate commands ignoring error handling and
  * status of 'qc'.
  */
-#define ata_qc_for_each_raw(ap, qc, tag)					\
+#define ata_qc_for_each_raw(ap, qc, tag)			\
 	__ata_qc_for_each(ap, qc, tag, ATA_MAX_QUEUE, __ata_qc_from_tag)
 
 /*
-- 
2.16.4

