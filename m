From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/12] ide: check drive->using_dma in flagged_taskfile()
Date: Mon, 8 Oct 2007 23:07:54 +0200
Message-ID: <200710082307.54882.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:39803 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbXJHVjs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Oct 2007 17:39:48 -0400
Received: by ug-out-1314.google.com with SMTP id z38so7524ugc
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 14:39:47 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |    3 +++
 1 file changed, 3 insertions(+)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -827,6 +827,9 @@ ide_startstop_t flagged_taskfile (ide_dr
 		case TASKFILE_OUT_DMA:
 		case TASKFILE_IN_DMAQ:
 		case TASKFILE_IN_DMA:
+			if (!drive->using_dma)
+				break;
+
 			if (!hwif->dma_setup(drive)) {
 				hwif->dma_exec_cmd(drive, taskfile->command);
 				hwif->dma_start(drive);
