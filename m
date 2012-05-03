From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH] libata: skip old error history when counting probe trials
Date: Thu, 03 May 2012 09:23:09 +0800
Message-ID: <1336008189.5520.25.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45515 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753428Ab2ECBXM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 May 2012 21:23:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, Grant Grundler <grundler@google.com>, Gwendal Grignou <gwendal@google.com>

Commit d902747 introduced ATA_EFLAG_OLD_ER to mark entries in the
error ring as cleared.

But ata_count_probe_trials_cb() didn't check this flag and it still
counts the old error history. So wrong probe trials count is returned
and it causes problem, for example, SATA link speed is slowed down from
3.0Gbps to 1.5Gbps.

Fix it by checking ATA_EFLAG_OLD_ER in ata_count_probe_trials_cb().

Cc: stable <stable@vger.kernel.org> # 2.6.37+
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/ata/libata-eh.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index c61316e..d1fbd59 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3501,7 +3501,8 @@ static int ata_count_probe_trials_cb(struct ata_ering_entry *ent, void *void_arg
 	u64 now = get_jiffies_64();
 	int *trials = void_arg;
 
-	if (ent->timestamp < now - min(now, interval))
+	if ((ent->eflags & ATA_EFLAG_OLD_ER) ||
+	    (ent->timestamp < now - min(now, interval)))
 		return -1;
 
 	(*trials)++;
-- 
1.7.9



