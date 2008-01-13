From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] sata_sil24: fix stupid typo
Date: Sun, 13 Jan 2008 13:49:22 +0900
Message-ID: <47899852.1010806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:28440 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbYAMEt3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 23:49:29 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2810435wah.23
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 20:49:29 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Fix stupid typo.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_sil24.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index b4c674d..d9c8b32 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -301,7 +301,7 @@ static struct sil24_cerr_info {
 	[PORT_CERR_PKT_PROT]	= { AC_ERR_HSM, ATA_EH_SOFTRESET,
 				    "invalid data directon for ATAPI CDB" },
 	[PORT_CERR_SGT_BOUNDARY] = { AC_ERR_SYSTEM, ATA_EH_SOFTRESET,
-				     "SGT no on qword boundary" },
+				     "SGT not on qword boundary" },
 	[PORT_CERR_SGT_TGTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
 				    "PCI target abort while fetching SGT" },
 	[PORT_CERR_SGT_MSTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,

