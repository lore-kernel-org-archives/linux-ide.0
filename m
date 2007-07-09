From: akpm@linux-foundation.org
Subject: [patch 08/11] sata_nv: allow changing queue depth
Date: Mon, 09 Jul 2007 11:46:21 -0700
Message-ID: <200707091846.l69IkLRg001387@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40524 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754184AbXGISyz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 14:54:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, hancockr@shaw.ca

From: Robert Hancock <hancockr@shaw.ca>

The sata_nv driver was missing the change_queue_depth hook in the SCSI host
template which the other NCQ-capable libata drivers had.  This made it
impossible to change the queue depth by user request.  Add this in.

Signed-off-by: Robert Hancock <hancockr@shaw.ca>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/sata_nv.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/ata/sata_nv.c~sata_nv-allow-changing-queue-depth drivers/ata/sata_nv.c
--- a/drivers/ata/sata_nv.c~sata_nv-allow-changing-queue-depth
+++ a/drivers/ata/sata_nv.c
@@ -420,6 +420,7 @@ static struct scsi_host_template nv_swnc
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
+	.change_queue_depth	= ata_scsi_change_queue_depth,
 	.can_queue		= ATA_MAX_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
_
