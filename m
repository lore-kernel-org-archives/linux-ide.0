From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/13] libata: add flags for new EH
Date: Mon, 3 Apr 2006 03:31:09 +0900
Message-ID: <11440026693365-git-send-email-htejun@gmail.com>
References: <1144002668278-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:27419 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750866AbWDBSbO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 14:31:14 -0400
Received: by zproxy.gmail.com with SMTP id o37so1550553nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 11:31:14 -0700 (PDT)
In-Reply-To: <1144002668278-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add new device, port and ac flags to be used for new EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

de9fe3323707d4395862b90fa728f310c18f80c8
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 75bdee0..cc57c4d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -125,6 +125,7 @@ enum {
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
+	ATA_DFLAG_FAILED	= (1 << 9), /* device has failed */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
@@ -152,7 +153,8 @@ enum {
 	ATA_FLAG_FLUSH_PORT_TASK = (1 << 18), /* flush port task */
 
 	ATA_FLAG_DISABLED	= (1 << 19), /* port is disabled, ignore it */
-	ATA_FLAG_SUSPENDED	= (1 << 20), /* port is suspended */
+	ATA_FLAG_FROZEN		= (1 << 20), /* port is frozen */
+	ATA_FLAG_SUSPENDED	= (1 << 21), /* port is suspended (power) */
 
 	/* bits 24:31 of ap->flags are reserved for LLDD specific flags */
 
@@ -162,7 +164,10 @@ enum {
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


