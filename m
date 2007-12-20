From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 39/63] ide-cd: merge cdrom_read_subchannel() into ide_cdrom_get_mcn()
Date: Thu, 20 Dec 2007 02:22:51 +0100
Message-ID: <200712200222.51336.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:12147 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756318AbXLTBeo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:44 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389253ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:43 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
-19 bytes
 drivers/ide/ide-cd.c |   53 ++++++++++++++++++++-------------------------------
 1 file changed, 21 insertions(+), 32 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1996,25 +1996,6 @@ static int ide_cd_read_tochdr(ide_drive_
 	return 0;
 }
 
-static int cdrom_read_subchannel(ide_drive_t *drive, int format, char *buf,
-				 int buflen, struct request_sense *sense)
-{
-	struct request req;
-
-	cdrom_prepare_request(drive, &req);
-
-	req.sense = sense;
-	req.data = buf;
-	req.data_len = buflen;
-	req.cmd[0] = GPCMD_READ_SUBCHANNEL;
-	req.cmd[1] = 2;     /* MSF addressing */
-	req.cmd[2] = 0x40;  /* request subQ data */
-	req.cmd[3] = format;
-	req.cmd[7] = (buflen >> 8);
-	req.cmd[8] = (buflen & 0xff);
-	return cdrom_queue_packet_command(drive, &req);
-}
-
 /* ATAPI cdrom drives are free to select the speed you request or any slower
    rate :-( Requesting too fast a speed will _not_ produce an error. */
 static int cdrom_select_speed(ide_drive_t *drive, int speed,
@@ -2356,28 +2337,36 @@ int ide_cdrom_get_last_session (struct c
 	return 0;
 }
 
-static
-int ide_cdrom_get_mcn (struct cdrom_device_info *cdi,
-		       struct cdrom_mcn *mcn_info)
+static int ide_cdrom_get_mcn(struct cdrom_device_info *cdi,
+			     struct cdrom_mcn *mcn_info)
 {
-	int stat;
-	char mcnbuf[24];
 	ide_drive_t *drive = cdi->handle;
+	int stat, mcnlen;
+	struct request rq;
+	char buf[24];
+
+	cdrom_prepare_request(drive, &rq);
+
+	rq.data = buf;
+	rq.data_len = sizeof(buf);
 
-/* get MCN */
-	if ((stat = cdrom_read_subchannel(drive, 2, mcnbuf, sizeof (mcnbuf), NULL)))
+	rq.cmd[0] = GPCMD_READ_SUBCHANNEL;
+	rq.cmd[1] = 2;		/* MSF addressing */
+	rq.cmd[2] = 0x40;	/* request subQ data */
+	rq.cmd[3] = 2;		/* format */
+	rq.cmd[8] = sizeof(buf);
+
+	stat = cdrom_queue_packet_command(drive, &rq);
+	if (stat)
 		return stat;
 
-	memcpy (mcn_info->medium_catalog_number, mcnbuf+9,
-		sizeof (mcn_info->medium_catalog_number)-1);
-	mcn_info->medium_catalog_number[sizeof (mcn_info->medium_catalog_number)-1]
-		= '\0';
+	mcnlen = sizeof(mcn_info->medium_catalog_number) - 1;
+	memcpy(mcn_info->medium_catalog_number, buf + 9, mcnlen);
+	mcn_info->medium_catalog_number[mcnlen] = '\0';
 
 	return 0;
 }
 
-
-
 /****************************************************************************
  * Other driver requests (open, close, check media change).
  */
