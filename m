From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: don't allow sysfs read access to
 force param
Date: Sun, 09 Mar 2008 20:21:53 +0900
Message-ID: <47D3C851.8030401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:8485 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbYCILWA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Mar 2008 07:22:00 -0400
Received: by rv-out-0910.google.com with SMTP id k20so790670rvb.1
        for <linux-ide@vger.kernel.org>; Sun, 09 Mar 2008 04:21:59 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Eric Sesterhenn <snakebyte@gmx.de>

Buffer for force param is deallocated after initialization, so trying
to read it via sysfs results in oops.  Don't allow read access to the
param node.

Spotted by Eric Sesterhenn.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Eric Sesterhenn <snakebyte@gmx.de>
---
 drivers/ata/libata-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4fbcce7..e399eaa 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -106,7 +106,8 @@ static struct ata_force_ent *ata_force_tbl;
 static int ata_force_tbl_size;
 
 static char ata_force_param_buf[PAGE_SIZE] __initdata;
-module_param_string(force, ata_force_param_buf, sizeof(ata_force_param_buf), 0444);
+/* param_buf is thrown away after initialization, disallow read */
+module_param_string(force, ata_force_param_buf, sizeof(ata_force_param_buf), 0);
 MODULE_PARM_DESC(force, "Force ATA configurations including cable type, link speed and transfer mode (see Documentation/kernel-parameters.txt for details)");
 
 int atapi_enabled = 1;
