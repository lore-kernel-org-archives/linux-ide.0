From: Robert Hancock <hancockr@shaw.ca>
Subject: [PATCH -mm] sata_nv: allow changing queue depth
Date: Thu, 28 Jun 2007 18:52:24 -0600
Message-ID: <468457C8.7060507@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:39812 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762503AbXF2Awn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jun 2007 20:52:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Roy Franz <roy.lists@gmail.com>

The sata_nv driver was missing the change_queue_depth hook in the SCSI host
template which the other NCQ-capable libata drivers had. This made it impossible
to change the queue depth by user request. Add this in.

Signed-off-by: Robert Hancock <hancockr@shaw.ca>

--- linux-2.6.22-rc6-mm1/drivers/ata/sata_nv.c	2007-06-28 17:30:28.000000000 -0600
+++ linux-2.6.22-rc6-mm1edit/drivers/ata/sata_nv.c	2007-06-28 17:39:30.000000000 -0600
@@ -398,6 +398,7 @@ static struct scsi_host_template nv_adma
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
+	.change_queue_depth	= ata_scsi_change_queue_depth,
 	.can_queue		= NV_ADMA_MAX_CPBS,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= NV_ADMA_SGTBL_TOTAL_LEN,
@@ -416,6 +417,7 @@ static struct scsi_host_template nv_swnc
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
+	.change_queue_depth	= ata_scsi_change_queue_depth,
 	.can_queue		= ATA_MAX_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,

