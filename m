From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: relocate sdev->manage_start_stop
 configuration
Date: Tue, 15 Jan 2008 08:46:59 +0900
Message-ID: <478BF473.9050602@gmail.com>
References: <20080114210805.GH9847@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:57654 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbYANXrH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jan 2008 18:47:07 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1909326rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 14 Jan 2008 15:47:05 -0800 (PST)
In-Reply-To: <20080114210805.GH9847@does.not.exist>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Ondrej Zary <linux@rainbow-software.org>, Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

After 9b8e8de7, manage_start_stop configuration depends on valid ATA
device.  Move it into ata_scsi_dev_config().  This was detected by the
coverity checker.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Adrian Bunk <bunk@kernel.org>
---
 drivers/ata/libata-scsi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7c13663..a6575b7 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -841,6 +841,9 @@ static void ata_scsi_dev_config(struct scsi_device *sdev,
 		blk_queue_max_hw_segments(q, q->max_hw_segments - 1);
 	}
 
+	if (dev->class == ATA_DEV_ATA)
+		sdev->manage_start_stop = 1;
+
 	if (dev->flags & ATA_DFLAG_AN)
 		set_bit(SDEV_EVT_MEDIA_CHANGE, sdev->supported_events);
 
@@ -872,9 +875,6 @@ int ata_scsi_slave_config(struct scsi_device *sdev)
 
 	ata_scsi_sdev_config(sdev);
 
-	if (dev->class == ATA_DEV_ATA)
-		sdev->manage_start_stop = 1;
-
 	if (dev)
 		ata_scsi_dev_config(sdev, dev);
 
