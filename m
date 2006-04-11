From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/16] libata-eh-fw: add flags for new EH
Date: Tue, 11 Apr 2006 22:42:53 +0900
Message-ID: <11447629731739-git-send-email-htejun@gmail.com>
References: <11447629733305-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.183]:9317 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750879AbWDKNmz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:42:55 -0400
Received: by pproxy.gmail.com with SMTP id i49so1385350pye
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:42:54 -0700 (PDT)
In-Reply-To: <11447629733305-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add new device, port and ac flags to be used for new EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

83d510e57ad1843999195e7c5b00f7086ebf57d9
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1c75024..d80dbb5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -124,6 +124,7 @@ enum {
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
+	ATA_DFLAG_FAILED	= (1 << 9), /* device has failed */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
@@ -151,7 +152,8 @@ enum {
 	ATA_FLAG_FLUSH_PORT_TASK = (1 << 18), /* flush port task */
 
 	ATA_FLAG_DISABLED	= (1 << 19), /* port is disabled, ignore it */
-	ATA_FLAG_SUSPENDED	= (1 << 20), /* port is suspended */
+	ATA_FLAG_FROZEN		= (1 << 20), /* port is frozen */
+	ATA_FLAG_SUSPENDED	= (1 << 21), /* port is suspended (power) */
 
 	/* bits 24:31 of ap->flags are reserved for LLDD specific flags */
 
@@ -161,7 +163,10 @@ enum {
 	ATA_QCFLAG_SINGLE	= (1 << 2), /* no s/g, just a single buffer */
 	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
 	ATA_QCFLAG_IO		= (1 << 3), /* standard IO command */
-	ATA_QCFLAG_EH_SCHEDULED = (1 << 4), /* EH scheduled */
+	ATA_QCFLAG_TIMEOUT	= (1 << 4), /* cmd has timed out */
+	ATA_QCFLAG_FAILED	= (1 << 5), /* cmd has failed */
+	ATA_QCFLAG_EH_SCHEDULED	= (1 << 6), /* EH scheduled */
+	ATA_QCFLAG_SENSE_VALID	= (1 << 7), /* sense data valid */
 
 	/* host set flags */
 	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host_set only */
-- 
1.2.4


