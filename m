From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream] libata: fix off-by-one in error categorization
Date: Thu, 03 Jan 2008 01:21:14 +0900
Message-ID: <477BB9FA.2030907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:47120 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbYABQVX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 11:21:23 -0500
Received: by py-out-1112.google.com with SMTP id u52so9966994pyb.10
        for <linux-ide@vger.kernel.org>; Wed, 02 Jan 2008 08:21:22 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

ATA_ECAT_DUBIOUS_BASE was too high by one and thus all DUBIOUS error
categorizations were wrong.  This passed test because only ATA_BUS and
UNK_DEV were used during testing and the ones after them - ATA_BUS and
an overflowed entry - behaved similarly.

This patch fixes the problem by adding DUBIOUS_NONE category and use
it as base.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 228a225..04b93a2 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -61,12 +61,11 @@ enum {
 	ATA_ECAT_ATA_BUS		= 1,
 	ATA_ECAT_TOUT_HSM		= 2,
 	ATA_ECAT_UNK_DEV		= 3,
-	ATA_ECAT_DUBIOUS_ATA_BUS	= 4,
-	ATA_ECAT_DUBIOUS_TOUT_HSM	= 5,
-	ATA_ECAT_DUBIOUS_UNK_DEV	= 6,
-	ATA_ECAT_NR			= 7,
-
-	ATA_ECAT_DUBIOUS_BASE		= ATA_ECAT_DUBIOUS_ATA_BUS,
+	ATA_ECAT_DUBIOUS_NONE		= 4,
+	ATA_ECAT_DUBIOUS_ATA_BUS	= 5,
+	ATA_ECAT_DUBIOUS_TOUT_HSM	= 6,
+	ATA_ECAT_DUBIOUS_UNK_DEV	= 7,
+	ATA_ECAT_NR			= 8,
 };
 
 /* Waiting in ->prereset can never be reliable.  It's sometimes nice
@@ -1498,7 +1497,7 @@ static int ata_eh_categorize_error(unsigned int eflags, unsigned int err_mask,
 		*xfer_ok = 1;
 
 	if (!*xfer_ok)
-		base = ATA_ECAT_DUBIOUS_BASE;
+		base = ATA_ECAT_DUBIOUS_NONE;
 
 	if (err_mask & AC_ERR_ATA_BUS)
 		return base + ATA_ECAT_ATA_BUS;


