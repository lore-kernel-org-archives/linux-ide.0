From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] libata: fix build warning in ata_scsi_var_len_cdb_xlat
Date: Wed, 28 Jun 2017 22:04:03 +0200
Message-ID: <20170628200421.3047383-1-arnd@arndb.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:62746 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbdF1UEm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 28 Jun 2017 16:04:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Arnd Bergmann <arnd@arndb.de>, Tom Yan <tom.ty89@gmail.com>, Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>, Adam Manzanares <adam.manzanares@wdc.com>, Minwoo Im <dn3108@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

This new harmless warning just showed up:

drivers/ata/libata-scsi.c: In function 'ata_scsi_var_len_cdb_xlat':
drivers/ata/libata-scsi.c:4194:1: error: label 'unspprt_sa' defined but not used [-Werror=unused-label]

The label is obviously unused and can be removed.

Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ata/libata-scsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 815c6e240aea..9d1b66b4ce7b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4191,7 +4191,6 @@ static unsigned int ata_scsi_var_len_cdb_xlat(struct ata_queued_cmd *qc)
 	if (sa == ATA_32)
 		return ata_scsi_pass_thru(qc);
 
-unspprt_sa:
 	/* unsupported service action */
 	return 1;
 }
-- 
2.9.0

