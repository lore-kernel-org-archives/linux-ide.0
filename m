From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/14] libata-hp-prep: add flags and eh_info/context fields for hotplug
Date: Fri, 12 May 2006 00:11:58 +0900
Message-ID: <11473603181200-git-send-email-htejun@gmail.com>
References: <1147360318920-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.201]:44528 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751843AbWEKPME (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:12:04 -0400
Received: by nz-out-0102.google.com with SMTP id 13so224767nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:12:04 -0700 (PDT)
In-Reply-To: <1147360318920-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add hotplug related flags and eh_info/context fields.

---

 include/linux/libata.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

d60dd05d2cfd4a63b7ce869694c3060d2aeab9d8
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 97e25a6..1f6e48e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -130,6 +130,9 @@ enum {
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
 
+	ATA_DFLAG_DETACH	= (1 << 16),
+	ATA_DFLAG_DETACHED	= (1 << 17),
+
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
 	ATA_DEV_ATA_UNSUP	= 2,	/* ATA device (unsupported) */
@@ -161,6 +164,9 @@ enum {
 	ATA_FLAG_EH_PENDING	= (1 << 16), /* EH pending */
 	ATA_FLAG_FROZEN		= (1 << 17), /* port is frozen */
 	ATA_FLAG_RECOVERED	= (1 << 18), /* recovery action performed */
+	ATA_FLAG_LOADING	= (1 << 19), /* boot/loading probe */
+	ATA_FLAG_UNLOADING	= (1 << 20), /* module is unloading */
+	ATA_FLAG_SCSI_HOTPLUG	= (1 << 21), /* SCSI hotplug scheduled */
 
 	ATA_FLAG_DISABLED	= (1 << 22), /* port is disabled, ignore it */
 	ATA_FLAG_SUSPENDED	= (1 << 23), /* port is suspended (power) */
@@ -435,6 +441,7 @@ struct ata_eh_info {
 	u32			serror;		/* SError from LLDD */
 	unsigned int		err_mask;	/* port-wide err_mask */
 	unsigned int		action;		/* ATA_EH_* action mask */
+	unsigned int		probe_mask;
 	char			desc[ATA_EH_DESC_LEN];
 	int			desc_len;
 };
@@ -442,7 +449,9 @@ struct ata_eh_info {
 struct ata_eh_context {
 	struct ata_eh_info	i;
 	int			tries[ATA_MAX_DEVICES];
+	unsigned int		classes[ATA_MAX_DEVICES];
 	unsigned int		flags;		/* ATA_EHC_* */
+	unsigned int		did_probe_mask;
 };
 
 struct ata_port {
-- 
1.2.4


