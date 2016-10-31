From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH] libata-scsi: Fixup ata_gen_passthru_sense()
Date: Mon, 31 Oct 2016 21:06:58 +0100
Message-ID: <1477944418-110380-1-git-send-email-hare@suse.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S946230AbcJaUHD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 31 Oct 2016 16:07:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Charles Machalow <csm10495@gmail.com>, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>

There's a typo in ata_gen_passthru_sense(), where the first byte
would be overwritten incorrectly later on.

Reported-by: Charles Machalow <csm10495@gmail.com>
Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/ata/libata-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 9cceb4a..c4eb4ae 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1088,7 +1088,7 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 		desc[1] = tf->command; /* status */
 		desc[2] = tf->device;
 		desc[3] = tf->nsect;
-		desc[0] = 0;
+		desc[7] = 0;
 		if (tf->flags & ATA_TFLAG_LBA48)  {
 			desc[8] |= 0x80;
 			if (tf->hob_nsect)
-- 
2.6.6

