From: Brian King <brking@us.ibm.com>
Subject: [PATCH 2/3] libata: ata_scsi_ioctl cleanup
Date: Thu, 23 Mar 2006 17:30:08 -0600
Message-ID: <200603232330.k2NNU9Wl008906@d03av02.boulder.ibm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:24718 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932561AbWCWXaL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Mar 2006 18:30:11 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2NNUAtc023373
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 18:30:10 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2NNXCh6174298
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 16:33:12 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2NNU9XT008916
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 16:30:10 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, brking@us.ibm.com


In preparation for SAS, kill some unnecessary code in ata_scsi_ioctl
to find the ATA port and device given the scsi_device. Neither local
is used in the function.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 libata-dev-bjking1/drivers/scsi/libata-scsi.c |   13 -------------
 1 files changed, 13 deletions(-)

diff -puN drivers/scsi/libata-scsi.c~libata_scsi_ioctl drivers/scsi/libata-scsi.c
--- libata-dev/drivers/scsi/libata-scsi.c~libata_scsi_ioctl	2006-03-23 11:00:32.000000000 -0600
+++ libata-dev-bjking1/drivers/scsi/libata-scsi.c	2006-03-23 11:00:32.000000000 -0600
@@ -267,20 +267,8 @@ int ata_task_ioctl(struct scsi_device *s
 
 int ata_scsi_ioctl(struct scsi_device *scsidev, int cmd, void __user *arg)
 {
-	struct ata_port *ap;
-	struct ata_device *dev;
 	int val = -EINVAL, rc = -EINVAL;
 
-	ap = (struct ata_port *) &scsidev->host->hostdata[0];
-	if (!ap)
-		goto out;
-
-	dev = ata_scsi_find_dev(ap, scsidev);
-	if (!dev) {
-		rc = -ENODEV;
-		goto out;
-	}
-
 	switch (cmd) {
 	case ATA_IOC_GET_IO32:
 		val = 0;
@@ -309,7 +297,6 @@ int ata_scsi_ioctl(struct scsi_device *s
 		break;
 	}
 
-out:
 	return rc;
 }
 
_
