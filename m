From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/14] libata-eh: add constants and flags to be used by EH
Date: Tue, 11 Apr 2006 22:48:22 +0900
Message-ID: <11447633021920-git-send-email-htejun@gmail.com>
References: <11447633013561-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.225]:12958 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750929AbWDKNsX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:48:23 -0400
Received: by wproxy.gmail.com with SMTP id i11so926518wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:48:23 -0700 (PDT)
In-Reply-To: <11447633013561-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add constants and flags to be used by EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/ata.h    |   11 +++++++++++
 include/linux/libata.h |    5 +++++
 2 files changed, 16 insertions(+), 0 deletions(-)

27f8a9a882a40d389aaeea10e03594e8c41911d6
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 312a2c0..283138f 100644
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
@@ -192,6 +195,14 @@ enum {
 	SCR_ACTIVE		= 3,
 	SCR_NOTIFICATION	= 4,
 
+	/* SError bits */
+	SERR_DATA_RECOVERED	= (1 << 0), /* recovered data error */
+	SERR_COMM_RECOVERED	= (1 << 1), /* recovered comm failure */
+	SERR_DATA		= (1 << 8), /* unrecovered data error */
+	SERR_PERSISTENT		= (1 << 9), /* persistent data/comm error */
+	SERR_PROTOCOL		= (1 << 10), /* protocol violation */
+	SERR_INTERNAL		= (1 << 11), /* host internal error */
+
 	/* struct ata_taskfile flags */
 	ATA_TFLAG_LBA48		= (1 << 0), /* enable 48-bit LBA and "HOB" */
 	ATA_TFLAG_ISADDR	= (1 << 1), /* enable r/w to nsect/lba regs */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0ac5214..58ad515 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -222,6 +222,11 @@ enum {
 	ATA_PORT_PRIMARY	= (1 << 0),
 	ATA_PORT_SECONDARY	= (1 << 1),
 
+	/* reset / recovery action types */
+	ATA_PORT_REVALIDATE	= (1 << 0),
+	ATA_PORT_SOFTRESET	= (1 << 1),
+	ATA_PORT_HARDRESET	= (1 << 2),
+
 	/* flags for ata_eh_shduled_port */
 	ATA_EH_ABORT		= (1 << 0), /* abort all active commands */
 	ATA_EH_FREEZE		= (1 << 1), /* freeze port (implies ABORT) */
-- 
1.2.4


