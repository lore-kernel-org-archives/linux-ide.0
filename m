From: Tobias Lorenz <tobias.lorenz@gmx.net>
Subject: Re: [PATCH 2.6.9-libata1-dev1] libata-scsi: hdparm support
Date: Sat, 30 Oct 2004 16:58:58 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1099148337.15964.4.camel@server.lorenz.priv>
References: <1098487253.28916.12.camel@server.lorenz.priv>
	 <41838C6E.6050702@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:14230 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261213AbUJ3O7C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Oct 2004 10:59:02 -0400
In-Reply-To: <41838C6E.6050702@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi,

> This patch doesn't apply, since it is prefixed with "> " ...
You are right... here is a corrected version.

This patch adds support for transfering drive informations via the
hd_driveid structure to the hdparm utility. At the moment, only
cylinders, sectors, heads, model and firmware version are transfered.

Signed-off-by: Tobias Lorenz <tobias.lorenz@gmx.net>

--- a/drivers/scsi/libata-scsi.c	2004-10-30 16:31:01.000000000 +0200
+++ b/drivers/scsi/libata-scsi.c	2004-10-30 16:35:58.000000000 +0200
@@ -215,6 +215,17 @@
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
@@ -249,6 +260,17 @@
 			return -EACCES;
 		return ata_task_ioctl(scsidev, arg);
 
+	case HDIO_GET_IDENTITY:
+		ata_std_bios_param(scsidev, NULL, dev->n_sectors, geom);
+		drv_id.cur_heads	= drv_id.heads		= geom[0];
+		drv_id.cur_sectors	= drv_id.sectors	= geom[1];
+		drv_id.cur_cyls		= drv_id.cyls		= geom[2];
+		strncpy((char *) &drv_id.model, scsidev->model, sizeof(drv_id.model));
+		strncpy((char *) &drv_id.fw_rev, scsidev->rev, sizeof(drv_id.fw_rev));
+		if(copy_to_user((char *) arg, (char *) &drv_id, sizeof(drv_id)))
+			return(-EFAULT);
+		return 0;
+
 	default:
 		rc = -EOPNOTSUPP;
 		break;


