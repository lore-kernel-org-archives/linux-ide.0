From: Tobias Lorenz <tobias.lorenz@gmx.net>
Subject: Re: [PATCH 2.6.9-libata1-dev1] libata-scsi: hdparm support
Date: Thu, 04 Nov 2004 17:55:34 +0100
Message-ID: <1099587334.26343.13.camel@server.lorenz.priv>
References: <1098487253.28916.12.camel@server.lorenz.priv>
	 <41838C6E.6050702@pobox.com> <1099148337.15964.4.camel@server.lorenz.priv>
	 <4183B2C6.7090500@pobox.com>  <58cb370e041102135138f50dac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:64149 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261202AbUKDQzh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Nov 2004 11:55:37 -0500
In-Reply-To: <58cb370e041102135138f50dac@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Hi,

Bartlomiej Zolnierkiewicz wrote:
> Speaking about correctness...
> 
> HDIO_GET_IDENTIFY returns ID block in CPU order (not LE).
> 
> If you decide to add it sooner or later you will need something ala
> ide_fix_driveid() from ide-iops.c (bloat).

Okay, I am wondering, who defined, that hd_driveid has to be little
endian and not cpu order. Does that really has to be platform
independent ? But anyway...

There are two possible solutions:

The quick way is attached and just adds the missing conversions by
copy&paste from ide-iops:ide_fix_driveid.

The better and less redundant way would be to use the original function:
- by setting a Kconfig dependency on CONFIG_IDE.
- or by moving ide_fix_driveid to a seperate file (header file ?).

What do you mean ?
  Toby


Signed-off-by: Tobias Lorenz <tobias.lorenz@gmx.net>

--- a/drivers/scsi/libata-scsi.c	2004-10-30 16:31:01.000000000 +0200
+++ b/drivers/scsi/libata-scsi.c	2004-11-04 17:39:58.000000000 +0100
@@ -31,6 +31,7 @@
 #include <linux/libata.h>
 #include <linux/hdreg.h>
 #include <asm/uaccess.h>
+#include <asm/byteorder.h>
 
 #include "libata.h"
 
@@ -215,6 +216,17 @@
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
@@ -249,6 +261,40 @@
 			return -EACCES;
 		return ata_task_ioctl(scsidev, arg);
 
+	case HDIO_GET_IDENTITY:
+		ata_std_bios_param(scsidev, NULL, dev->n_sectors, geom);
+		drv_id.cur_heads	= drv_id.heads		= geom[0];
+		drv_id.cur_sectors	= drv_id.sectors	= geom[1];
+		drv_id.cur_cyls		= drv_id.cyls		= geom[2];
+		strncpy((char *) &drv_id.model, scsidev->model, sizeof(drv_id.model));
+		strncpy((char *) &drv_id.fw_rev, scsidev->rev, sizeof(drv_id.fw_rev));
+#ifndef __LITTLE_ENDIAN
+# ifdef __BIG_ENDIAN
+		{
+			int i;
+			u16 *stringcast;
+
+			drv_id.cyls           = __le16_to_cpu(drv_id.cyls);
+			drv_id.heads          = __le16_to_cpu(drv_id.heads);
+			drv_id.sectors        = __le16_to_cpu(drv_id.sectors);
+			stringcast = (u16 *)&drv_id.fw_rev[0];
+			for (i = 0; i < (8/2); i++)
+				stringcast[i] = __le16_to_cpu(stringcast[i]);
+			stringcast = (u16 *)&drv_id.model[0];
+			for (i = 0; i < (40/2); i++)
+				stringcast[i] = __le16_to_cpu(stringcast[i]);
+			drv_id.cur_cyls       = __le16_to_cpu(drv_id.cur_cyls);
+			drv_id.cur_heads      = __le16_to_cpu(drv_id.cur_heads);
+			drv_id.cur_sectors    = __le16_to_cpu(drv_id.cur_sectors);
+		}
+# else
+#  error "Please fix <asm/byteorder.h>"
+# endif
+#endif
+		if(copy_to_user((char *) arg, (char *) &drv_id, sizeof(drv_id)))
+			return(-EFAULT);
+		return 0;
+
 	default:
 		rc = -EOPNOTSUPP;
 		break;


