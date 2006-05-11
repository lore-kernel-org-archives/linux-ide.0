From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/11] libata-eh: add ATA and libata flags for new EH
Date: Thu, 11 May 2006 22:21:27 +0900
Message-ID: <1147353687598-git-send-email-htejun@gmail.com>
References: <11473536873966-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.192]:5193 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751703AbWEKNVd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 09:21:33 -0400
Received: by wx-out-0102.google.com with SMTP id t5so1389wxc
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 06:21:32 -0700 (PDT)
In-Reply-To: <11473536873966-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add ATA and libata flags to be used by new EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/ata.h    |   13 +++++++++++++
 include/linux/libata.h |    8 ++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

f39425fcb9c479e87113475fd214728caebe0c78
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 312a2c0..a7c41f3 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -97,6 +97,9 @@ enum {
 	ATA_DRQ			= (1 << 3),	/* data request i/o */
 	ATA_ERR			= (1 << 0),	/* have an error */
 	ATA_SRST		= (1 << 2),	/* software reset */
+	ATA_ICRC		= (1 << 7),	/* interface CRC error */
+	ATA_UNC			= (1 << 6),	/* uncorrectable media error */
+	ATA_IDNF		= (1 << 4),	/* ID not found */
 	ATA_ABORTED		= (1 << 2),	/* command aborted */
 
 	/* ATA command block registers */
@@ -192,6 +195,16 @@ enum {
 	SCR_ACTIVE		= 3,
 	SCR_NOTIFICATION	= 4,
 
+	/* SError bits */
+	SERR_DATA_RECOVERED	= (1 << 0), /* recovered data error */
+	SERR_COMM_RECOVERED	= (1 << 1), /* recovered comm failure */
+	SERR_DATA		= (1 << 8), /* unrecovered data error */
+	SERR_PERSISTENT		= (1 << 9), /* persistent data/comm error */
+	SERR_PROTOCOL		= (1 << 10), /* protocol violation */
+	SERR_INTERNAL		= (1 << 11), /* host internal error */
+	SERR_PHYRDY_CHG		= (1 << 16), /* PHY RDY changed */
+	SERR_DEV_XCHG		= (1 << 26), /* device exchanged */
+
 	/* struct ata_taskfile flags */
 	ATA_TFLAG_LBA48		= (1 << 0), /* enable 48-bit LBA and "HOB" */
 	ATA_TFLAG_ISADDR	= (1 << 1), /* enable r/w to nsect/lba regs */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e4353cf..80c8f0e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -155,6 +155,7 @@ enum {
 
 	ATA_FLAG_EH_PENDING	= (1 << 16), /* EH pending */
 	ATA_FLAG_FROZEN		= (1 << 17), /* port is frozen */
+	ATA_FLAG_RECOVERED	= (1 << 18), /* recovery action performed */
 
 	ATA_FLAG_DISABLED	= (1 << 22), /* port is disabled, ignore it */
 	ATA_FLAG_SUSPENDED	= (1 << 23), /* port is suspended (power) */
@@ -225,6 +226,13 @@ enum {
 	ATA_PORT_PRIMARY	= (1 << 0),
 	ATA_PORT_SECONDARY	= (1 << 1),
 
+	/* reset / recovery action types */
+	ATA_EH_REVALIDATE	= (1 << 0),
+	ATA_EH_SOFTRESET	= (1 << 1),
+	ATA_EH_HARDRESET	= (1 << 2),
+
+	ATA_EH_RESET_MASK	= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
+
 	/* max repeat if error condition is still set after ->error_handler */
 	ATA_EH_MAX_REPEAT	= 5,
 
-- 
1.2.4


