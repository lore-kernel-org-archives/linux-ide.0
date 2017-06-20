From: Minwoo Im <dn3108@gmail.com>
Subject: [PATCH] libata: make function name in comment be matched with its own.
Date: Tue, 20 Jun 2017 19:21:30 +0900
Message-ID: <1497954090-8130-1-git-send-email-dn3108@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33717 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbdFTKVi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jun 2017 06:21:38 -0400
Received: by mail-pf0-f196.google.com with SMTP id w12so21807145pfk.0
        for <linux-ide@vger.kernel.org>; Tue, 20 Jun 2017 03:21:38 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Minwoo Im <dn3108@gmail.com>

the function name in comment used to be ata_scsiop_mode_select() for
ata_scsi_mode_select_xlat(). function comment has been updated.

Signed-off-by: Minwoo Im <dn3108@gmail.com>
---
 drivers/ata/libata-scsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 49ba983..f80e415 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3909,7 +3909,7 @@ static int ata_mselect_control(struct ata_queued_cmd *qc,
 }
 
 /**
- *	ata_scsiop_mode_select - Simulate MODE SELECT 6, 10 commands
+ *	ata_scsi_mode_select_xlat - Simulate MODE SELECT 6, 10 commands
  *	@qc: Storage for translated ATA taskfile
  *
  *	Converts a MODE SELECT command to an ATA SET FEATURES taskfile.
-- 
1.7.9.5

