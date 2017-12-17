From: Xinyu Lin <xinyu0123@gmail.com>
Subject: [PATCH] libata: apply MAX_SEC_1024 to all LITEON EP1 series devices
Date: Sun, 17 Dec 2017 20:13:39 +0800
Message-ID: <20171217121339.7772-1-xinyu0123@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40460 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbdLQMOE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 17 Dec 2017 07:14:04 -0500
Received: by mail-pl0-f68.google.com with SMTP id 62so1709335pld.7
        for <linux-ide@vger.kernel.org>; Sun, 17 Dec 2017 04:14:03 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, xinyu0123@gmail.com

LITEON EP1 has the same timeout issues as CX1 series devices.

Revert max_sectors to the value of 1024.

'e0edc8c54646 ("libata: apply MAX_SEC_1024 to all CX1-JB*-HP devices")'

Signed-off-by: Xinyu Lin <xinyu0123@gmail.com>
---
 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2a882929de4a..ca52a15af077 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4443,6 +4443,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=121671
 	 */
 	{ "LITEON CX1-JB*-HP",	NULL,		ATA_HORKAGE_MAX_SEC_1024 },
+	{ "LITEON EP1-*",	NULL,		ATA_HORKAGE_MAX_SEC_1024 },
 
 	/* Devices we expect to fail diagnostics */
 
-- 
2.14.1

