From: Jeff Garzik <jgarzik@pobox.com>
Subject: get-identity ioctl in libata?
Date: Mon, 07 Mar 2005 23:46:28 -0500
Message-ID: <422D2E24.3060208@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070502070401050401070909"
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3792 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261413AbVCHEqu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Mar 2005 23:46:50 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tobias Lorenz <tobias.lorenz@gmx.net>

This is a multi-part message in MIME format.
--------------070502070401050401070909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bart,

Did you say that there was some problem with the patch to add 
HDIO_GET_IDENTITY support to libata (attached)?

I forget what the issues were, and this has been sitting in 
libata-dev-2.6 for a while.

	Jeff



--------------070502070401050401070909
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2005-03-07 23:44:42 -05:00
+++ b/drivers/scsi/libata-scsi.c	2005-03-07 23:44:42 -05:00
@@ -72,6 +72,17 @@
 	struct ata_port *ap;
 	struct ata_device *dev;
 	int val = -EINVAL, rc = -EINVAL;
+	struct hd_driveid drv_id = {
+		.cyls		= 0,
+		.sectors	= 0,
+		.heads		= 0,
+		.fw_rev		= "",
+		.model		= "",
+		.cur_cyls	= 0,
+		.cur_heads	= 0,
+		.cur_sectors	= 0,
+	};
+	int geom[3];
 
 	ap = (struct ata_port *) &scsidev->host->hostdata[0];
 	if (!ap)
@@ -94,6 +105,17 @@
 		val = (unsigned long) arg;
 		if (val != 0)
 			return -EINVAL;
+		return 0;
+
+	case HDIO_GET_IDENTITY:
+		ata_std_bios_param(scsidev, NULL, dev->n_sectors, geom);
+		drv_id.cur_heads	= drv_id.heads		= geom[0];
+		drv_id.cur_sectors	= drv_id.sectors	= geom[1];
+		drv_id.cur_cyls		= drv_id.cyls		= geom[2];
+		strncpy((char *) &drv_id.model, scsidev->model, sizeof(drv_id.model));
+		strncpy((char *) &drv_id.fw_rev, scsidev->rev, sizeof(drv_id.fw_rev));
+		if(copy_to_user((char *) arg, (char *) &drv_id, sizeof(drv_id)))
+			return(-EFAULT);
 		return 0;
 
 	default:

--------------070502070401050401070909--
