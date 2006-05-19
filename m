From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/14] libata-hp-prep: add flags and eh_info/context fields for hotplug
Date: Fri, 19 May 2006 06:16:32 -0700 (PDT)
Message-ID: <11480445833575-git-send-email-htejun@gmail.com>
References: <11480445833568-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:4321 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932138AbWESNQd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 09:16:33 -0400
Received: by py-out-1112.google.com with SMTP id z59so920071pyg
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 06:16:33 -0700 (PDT)
In-Reply-To: <11480445833568-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add hotplug related flags and eh_info/context fields.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

95c2d43950709c541509bbedd692e984dc67b474
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2803ab8..3fb6dc3 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -131,6 +131,9 @@ enum {
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
 
+	ATA_DFLAG_DETACH	= (1 << 16),
+	ATA_DFLAG_DETACHED	= (1 << 17),
+
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
 	ATA_DEV_ATA_UNSUP	= 2,	/* ATA device (unsupported) */
@@ -153,6 +156,9 @@ enum {
 	ATA_FLAG_PIO_POLLING	= (1 << 10), /* use polling PIO if LLD
 					      * doesn't handle PIO interrupts */
 	ATA_FLAG_NCQ		= (1 << 11), /* host supports NCQ */
+	ATA_FLAG_HRST_TO_RESUME	= (1 << 12), /* hardreset to resume phy */
+	ATA_FLAG_CANT_WAIT_FIS34 = (1 << 13), /* can't wait for the first D2H
+					       * Register FIS clearing BSY */
 
 	ATA_FLAG_DEBUGMSG	= (1 << 14),
 	ATA_FLAG_FLUSH_PORT_TASK = (1 << 15), /* flush port task */
@@ -160,6 +166,9 @@ enum {
 	ATA_FLAG_EH_PENDING	= (1 << 16), /* EH pending */
 	ATA_FLAG_FROZEN		= (1 << 17), /* port is frozen */
 	ATA_FLAG_RECOVERED	= (1 << 18), /* recovery action performed */
+	ATA_FLAG_LOADING	= (1 << 19), /* boot/loading probe */
+	ATA_FLAG_UNLOADING	= (1 << 20), /* module is unloading */
+	ATA_FLAG_SCSI_HOTPLUG	= (1 << 21), /* SCSI hotplug scheduled */
 
 	ATA_FLAG_DISABLED	= (1 << 22), /* port is disabled, ignore it */
 	ATA_FLAG_SUSPENDED	= (1 << 23), /* port is suspended (power) */
@@ -241,7 +250,9 @@ enum {
 	ATA_EH_RESET_MASK	= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
 
 	/* ata_eh_info->flags */
-	ATA_EHI_DID_RESET	= (1 << 0), /* already reset this port */
+	ATA_EHI_HOTPLUGGED	= (1 << 0),  /* could have been hotplugged */
+
+	ATA_EHI_DID_RESET	= (1 << 16), /* already reset this port */
 
 	/* max repeat if error condition is still set after ->error_handler */
 	ATA_EH_MAX_REPEAT	= 5,
@@ -434,6 +445,10 @@ struct ata_eh_info {
 	unsigned int		err_mask;	/* port-wide err_mask */
 	unsigned int		action;		/* ATA_EH_* action mask */
 	unsigned int		flags;		/* ATA_EHI_* flags */
+
+	unsigned long		hotplug_timestamp;
+	unsigned int		probe_mask;
+
 	char			desc[ATA_EH_DESC_LEN];
 	int			desc_len;
 };
@@ -441,6 +456,8 @@ struct ata_eh_info {
 struct ata_eh_context {
 	struct ata_eh_info	i;
 	int			tries[ATA_MAX_DEVICES];
+	unsigned int		classes[ATA_MAX_DEVICES];
+	unsigned int		did_probe_mask;
 };
 
 struct ata_port {
-- 
1.3.2

