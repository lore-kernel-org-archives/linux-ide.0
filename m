From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH] libata: clear error mask of old error history
Date: Fri, 20 Apr 2012 09:38:58 +0800
Message-ID: <1334885938.4927.11.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:49981 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141Ab2DTBjA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Apr 2012 21:39:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>

The old error history was cleared in ata_ering_clear().
It only sets ATA_EFLAG_OLD_ER eflags, but the err_mask was not cleared.
So ata_ering_map() still iterates the old error history.

This causes problem, for example, wrong probe trials count were returned in
ata_eh_schedule_probe(), which in turn causes SATA link speed to be slowed down
to 1.5Gbps.

Reported-and-tested-by: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---

Hi Jeff,

This patch fixes an old regression introduced in 2.6.37-rc1
of commit d902747.

So it should be included into stable releases since 2.6.37.

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



