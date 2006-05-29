From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: set PIO-0 after successful EH reset
Date: Mon, 29 May 2006 14:50:06 +0900
Message-ID: <20060529055006.GA30852@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:16 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751209AbWE2FuM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 01:50:12 -0400
Received: by py-out-1112.google.com with SMTP id e30so292740pya
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 22:50:11 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Set ata_device->pio_mode to XFER_PIO_0 after a successful reset.  This
is to keep EH resets consistent with probe resets as updated by the
commit b6079ca409bf88c248992e96510dd6f610f7ed89.  Note that, with
soon-to-follow hotplug update, EH resets will include probe resets.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

8bdb768ad75508fcc0e26ed15723700e40b9f619
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 71b45ad..b88f492 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1287,7 +1287,7 @@ static int ata_eh_reset(struct ata_port 
 	unsigned int classes[ATA_MAX_DEVICES];
 	int tries = ATA_EH_RESET_TRIES;
 	ata_reset_fn_t reset;
-	int rc;
+	int i, rc;
 
 	if (softreset && (!hardreset || (!sata_set_spd_needed(ap) &&
 					 !(ehc->i.action & ATA_EH_HARDRESET))))
@@ -1319,6 +1319,12 @@ static int ata_eh_reset(struct ata_port 
 	}
 
 	if (rc == 0) {
+		/* After the reset, the device state is PIO 0 and the
+		 * controller state is undefined.  Record the mode.
+		 */
+		for (i = 0; i < ATA_MAX_DEVICES; i++)
+			ap->device[i].pio_mode = XFER_PIO_0;
+
 		if (postreset)
 			postreset(ap, classes);
 
-- 
1.3.2
