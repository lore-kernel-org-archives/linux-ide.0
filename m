From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes 2/2] libata: ATA_12/16 doesn't fall into ATAPI_MISC
Date: Wed, 02 Apr 2008 17:35:19 +0900
Message-ID: <47F34547.7040601@gmail.com>
References: <47F343BE.4030103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:29431 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbYDBIfZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Apr 2008 04:35:25 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3089657wah.23
        for <linux-ide@vger.kernel.org>; Wed, 02 Apr 2008 01:35:25 -0700 (PDT)
In-Reply-To: <47F343BE.4030103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

SAT passthrus don't really fit into ATAPI_MISC class.  SAT passthru
commands always transfer multiple of 512 bytes and variable length
response is not allowed.  This patch creates a separate category -
ATAPI_PASS_THRU - for these.

This fixes HSM violation on "hdparm -I".

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    5 +++++
 include/linux/libata.h    |    3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

Index: work1/drivers/ata/libata-core.c
===================================================================
--- work1.orig/drivers/ata/libata-core.c
+++ work1/drivers/ata/libata-core.c
@@ -412,6 +412,11 @@ int atapi_cmd_type(u8 opcode)
 	case GPCMD_READ_CD_MSF:
 		return ATAPI_READ_CD;
 
+	case ATA_16:
+	case ATA_12:
+		if (atapi_passthru16)
+			return ATAPI_PASS_THRU;
+		/* fall thru */
 	default:
 		return ATAPI_MISC;
 	}
Index: work1/include/linux/libata.h
===================================================================
--- work1.orig/include/linux/libata.h
+++ work1/include/linux/libata.h
@@ -347,7 +347,8 @@ enum {
 	ATAPI_READ		= 0,		/* READs */
 	ATAPI_WRITE		= 1,		/* WRITEs */
 	ATAPI_READ_CD		= 2,		/* READ CD [MSF] */
-	ATAPI_MISC		= 3,		/* the rest */
+	ATAPI_PASS_THRU		= 3,		/* SAT pass-thru */
+	ATAPI_MISC		= 4,		/* the rest */
 };
 
 enum ata_xfer_mask {
