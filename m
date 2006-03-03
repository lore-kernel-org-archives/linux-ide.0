From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH] libata-dev: recognize WRITE_MULTI_FUA_EXT for r/w multiple
Date: Fri, 03 Mar 2006 10:34:05 +0800
Message-ID: <4407AB1D.2080506@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:26343 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752163AbWCCCeN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Mar 2006 21:34:13 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k232Y7Ti016297
	for <linux-ide@vger.kernel.org>; Thu, 2 Mar 2006 21:34:07 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k232arYA131372
	for <linux-ide@vger.kernel.org>; Thu, 2 Mar 2006 19:36:53 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k232Y7ku012631
	for <linux-ide@vger.kernel.org>; Thu, 2 Mar 2006 19:34:07 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

Jeff,

Changes:
Recognize ATA_CMD_WRITE_MULTI_FUA_EXT as r/w multiple commands.

Patch against the irq-pio branch
(1ed82ae3df3882bfcb5bfe5e9f97e4e8e23af299).

For your review, thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 
---

--- irq-pio/include/linux/ata.h	2006-03-02 15:22:58.000000000 +0800
+++ irq-pio-catchup/include/linux/ata.h	2006-03-02 17:05:17.000000000 +0800
@@ -314,7 +314,8 @@ static inline int is_multi_taskfile(stru
 	return (tf->command == ATA_CMD_READ_MULTI) ||
 	       (tf->command == ATA_CMD_WRITE_MULTI) ||
 	       (tf->command == ATA_CMD_READ_MULTI_EXT) ||
-	       (tf->command == ATA_CMD_WRITE_MULTI_EXT);
+	       (tf->command == ATA_CMD_WRITE_MULTI_EXT) ||
+	       (tf->command == ATA_CMD_WRITE_MULTI_FUA_EXT);
 }
 
 static inline int ata_ok(u8 status)

