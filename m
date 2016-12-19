From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 1/1] libata: Fix ATA request sense
Date: Mon, 19 Dec 2016 10:17:40 +0900
Message-ID: <1482110260-14551-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26115 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbcLSBSI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 18 Dec 2016 20:18:08 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>, Damien Le Moal <damien.lemoal@wdc.com>

For an ATA device supporting the sense data reporting feature set,
a failed command will trigger the execution of ata_eh_request_sense if
the result task file of the failed command has the ATA_SENSE bit set
(sense data available bit). ata_eh_request_sense executes the
REQUEST SENSE DATA EXT command to retrieve the sense data of the failed
command. On success of REQUEST SENSE DATA EXT, the ATA_SENSE bit will
NOT be set (the command succeeded) but ata_eh_request_sense
nevertheless tests the availability of sense data by testing that bit
presence in the result tf of the REQUEST SENSE DATA EXT command.
This leads to a falsy assume that request sense data failed and to the
warning message:

atax.xx: request sense failed stat 50 emask 0

Upon success of REQUEST SENSE DATA EXT, set the ATA_SENSE bit in the
result task file command so that sense data can be returned by
ata_eh_request_sense.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/ata/libata-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9cd0a2d..366a380 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1702,6 +1702,8 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 
 		if (qc->err_mask & ~AC_ERR_OTHER)
 			qc->err_mask &= ~AC_ERR_OTHER;
+	} else if (qc->tf.command == ATA_CMD_REQ_SENSE_DATA) {
+		qc->result_tf.command |= ATA_SENSE;
 	}
 
 	/* finish up */
-- 
2.7.4

