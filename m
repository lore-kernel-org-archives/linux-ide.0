From: akpm@linux-foundation.org
Subject: [patch 1/9] drivers/ata/libata-eh.c: fix printk warning
Date: Thu, 13 Dec 2007 16:01:37 -0800
Message-ID: <200712140001.lBE01bbR025425@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39484 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751624AbXLNABo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Dec 2007 19:01:44 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org

From: Andrew Morton <akpm@linux-foundation.org>

drivers/ata/libata-eh.c: In function `ata_port_pbar_desc':
drivers/ata/libata-eh.c:215: warning: long long unsigned int format, long unsigned int arg (arg 4)

Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-eh.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/ata/libata-eh.c~drivers-ata-libata-ehc-fix-printk-warning drivers/ata/libata-eh.c
--- a/drivers/ata/libata-eh.c~drivers-ata-libata-ehc-fix-printk-warning
+++ a/drivers/ata/libata-eh.c
@@ -231,7 +231,8 @@ void ata_port_pbar_desc(struct ata_port 
 	if (offset < 0)
 		ata_port_desc(ap, "%s %s%llu@0x%llx", name, type, len, start);
 	else
-		ata_port_desc(ap, "%s 0x%llx", name, start + offset);
+		ata_port_desc(ap, "%s 0x%llx", name,
+				start + (unsigned long long)offset);
 }
 
 #endif /* CONFIG_PCI */
_
