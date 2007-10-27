From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/15] ide: add missing rq.ref_count initialization to ide_diag_taskfile()
Date: Sat, 27 Oct 2007 19:45:56 +0200
Message-ID: <200710271945.56204.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:48608 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463AbXJ0Rqk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 13:46:40 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1026731nfb
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2007 10:46:38 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>


Noticed by Tejun Heo.

Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -495,6 +495,7 @@ static int ide_diag_taskfile(ide_drive_t
 	struct request rq;
 
 	memset(&rq, 0, sizeof(rq));
+	rq.ref_count = 1;
 	rq.cmd_type = REQ_TYPE_ATA_TASKFILE;
 	rq.buffer = buf;
 
