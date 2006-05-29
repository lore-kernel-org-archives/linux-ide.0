From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/12] libata-hp-prep: add flags and eh_info/context fields for hotplug
Date: Mon, 29 May 2006 15:25:57 +0900
Message-ID: <11488839572902-git-send-email-htejun@gmail.com>
References: <11488839571850-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.205]:9699 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751245AbWE2G0X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 02:26:23 -0400
Received: by nz-out-0102.google.com with SMTP id s18so475446nze
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 23:26:22 -0700 (PDT)
In-Reply-To: <11488839571850-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add hotplug related flags and eh_info/context fields.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

5577bff1743157fb00b7499d832dd55c47245e3e
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b0ee1c1..4f67c43 100644
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
@@ -152,6 +155,9 @@ enum {
 	ATA_FLAG_PIO_POLLING	= (1 << 10), /* use polling PIO if LLD
 					      * doesn't handle PIO interrupts */
 	ATA_FLAG_NCQ		= (1 << 11), /* host supports NCQ */
+	ATA_FLAG_HRST_TO_RESUME	= (1 << 12), /* hardreset to resume phy */
+	ATA_FLAG_SKIP_D2H_BSY	= (1 << 13), /* can't wait for the first D2H
+					      * Register FIS clearing BSY */
 
 	ATA_FLAG_DEBUGMSG	= (1 << 14),
 	ATA_FLAG_FLUSH_PORT_TASK = (1 << 15), /* flush port task */
@@ -159,6 +165,9 @@ enum {
 	ATA_FLAG_EH_PENDING	= (1 << 16), /* EH pending */
 	ATA_FLAG_FROZEN		= (1 << 17), /* port is frozen */
 	ATA_FLAG_RECOVERED	= (1 << 18), /* recovery action performed */
+	ATA_FLAG_LOADING	= (1 << 19), /* boot/loading probe */
+	ATA_FLAG_UNLOADING	= (1 << 20), /* module is unloading */
+	ATA_FLAG_SCSI_HOTPLUG	= (1 << 21), /* SCSI hotplug scheduled */
 
 	ATA_FLAG_DISABLED	= (1 << 22), /* port is disabled, ignore it */
 	ATA_FLAG_SUSPENDED	= (1 << 23), /* port is suspended (power) */
@@ -240,7 +249,9 @@ enum {
 	ATA_EH_RESET_MASK	= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
 
 	/* ata_eh_info->flags */
-	ATA_EHI_DID_RESET	= (1 << 0), /* already reset this port */
+	ATA_EHI_HOTPLUGGED	= (1 << 0),  /* could have been hotplugged */
+
+	ATA_EHI_DID_RESET	= (1 << 16), /* already reset this port */
 
 	/* max repeat if error condition is still set after ->error_handler */
 	ATA_EH_MAX_REPEAT	= 5,
@@ -433,6 +444,10 @@ struct ata_eh_info {
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
@@ -440,6 +455,8 @@ struct ata_eh_info {
 struct ata_eh_context {
 	struct ata_eh_info	i;
 	int			tries[ATA_MAX_DEVICES];
+	unsigned int		classes[ATA_MAX_DEVICES];
+	unsigned int		did_probe_mask;
 };
 
 struct ata_port {
-- 
1.3.2


