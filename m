From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH] ahci_xgene: Fix the dma state machine lockup for the ATA_CMD_SMART PIO mode command.
Date: Tue, 27 Jan 2015 23:26:11 +0530
Message-ID: <1422381371-11361-2-git-send-email-stripathi@apm.com>
References: <1422381371-11361-1-git-send-email-stripathi@apm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from denmail01-v4020.amcc.com ([192.195.68.30]:53161 "EHLO
	denmail01.apm.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751532AbbA0R5A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jan 2015 12:57:00 -0500
In-Reply-To: <1422381371-11361-1-git-send-email-stripathi@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: olof@lixom.net, tj@kernel.org, arnd@arndb.de
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mlangsdo@redhat.com, jcm@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

This patch addresses the issue with ATA_CMD_SMART pio mode
command for enumeration and device detection with ATA devices.It is the
same issue as in patch

www.spinics.net/lists/linux-ide/msg49092.html

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
---
 drivers/ata/ahci_xgene.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 7f68875..506cf5f 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -211,7 +211,8 @@ static unsigned int xgene_ahci_qc_issue(struct ata_queued_cmd *qc)
 	}

 	if (unlikely((ctx->last_cmd[ap->port_no] == ATA_CMD_ID_ATA) ||
-	    (ctx->last_cmd[ap->port_no] == ATA_CMD_PACKET)))
+	    (ctx->last_cmd[ap->port_no] == ATA_CMD_PACKET) ||
+	    (ctx->last_cmd[ap->port_no] == ATA_CMD_SMART)))
 		xgene_ahci_restart_engine(ap);

 	rc = ahci_qc_issue(qc);
--
1.8.2.1

