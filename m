From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 12/15] ide: extend timeout for REQ_TYPE_ATA_{CMD,TASK} requests
Date: Sat, 27 Oct 2007 19:46:47 +0200
Message-ID: <200710271946.47938.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:48608 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755972AbXJ0Rqw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 13:46:52 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1026731nfb
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2007 10:46:51 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Extend timeout for REQ_TYPE_ATA_{CMD,TASK} requests from WAIT_CMD (10sec)
to WAIT_WORSTCASE (30sec, already used for REQ_TYPE_ATA_TASKFILE).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -902,7 +902,7 @@ static ide_startstop_t execute_drive_cmd
  	}
 	tf->command = args[0];
 	ide_tf_load(drive, &ltask);
-	ide_execute_command(drive, args[0], &drive_cmd_intr, WAIT_CMD, NULL);
+	ide_execute_command(drive, args[0], &drive_cmd_intr, WAIT_WORSTCASE, NULL);
 	return ide_started;
 
 done:
