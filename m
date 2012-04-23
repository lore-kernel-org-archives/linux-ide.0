From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH v2] libata: clear error mask of old error history
Date: Mon, 23 Apr 2012 09:09:25 +0800
Message-ID: <1335143365.4927.49.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60686 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753062Ab2DWBJ1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Apr 2012 21:09:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, Grant Grundler <grundler@google.com>, sshtylyov@mvista.com

The old error history was cleared in ata_ering_clear().
It only sets ATA_EFLAG_OLD_ER eflags, but the err_mask was not cleared.
So ata_ering_map() still iterates the old error history.

This causes problem, for example, wrong probe trials count were returned in
ata_eh_schedule_probe(), which in turn causes SATA link speed to be slowed down
to 1.5Gbps.

Reported-and-tested-by: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Reviewed-by: Grant Grundler <grundler@google.com>
Cc: stable <stable@vger.kernel.org> # 2.6.37+
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---

v2:
- Add Grant's review
- CC stable

 drivers/ata/libata-eh.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index c61316e..4c6f49b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -419,9 +419,10 @@ int ata_ering_map(struct ata_ering *ering,
 	return rc;
 }
 
-int ata_ering_clear_cb(struct ata_ering_entry *ent, void *void_arg)
+static int ata_ering_clear_cb(struct ata_ering_entry *ent, void *void_arg)
 {
 	ent->eflags |= ATA_EFLAG_OLD_ER;
+	ent->err_mask = 0;
 	return 0;
 }
 
-- 
1.7.2.5



