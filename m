From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: track spindown status and skip spindown_compat if
 possible
Date: Tue, 15 May 2007 12:29:22 +0200
Message-ID: <46498B82.1030802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:46161 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757107AbXEOK3n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2007 06:29:43 -0400
Received: by nz-out-0506.google.com with SMTP id r28so82789nza
        for <linux-ide@vger.kernel.org>; Tue, 15 May 2007 03:29:43 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Our assumption that most distros issue STANDBYNOW seems wrong.  The
upstream sysvinit and thus many distros including gentoo and opensuse
don't take any action for libata disks on spindown.  We can skip
compat handling for these distros so that they don't need to update
anything to take advantage of kernel-side shutdown.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

This patch is generated on top of fix-shutdown-warning-message-printing.

  http://article.gmane.org/gmane.linux.ide/18823

Jeff, I think we can avoid a lot of problems with this.  Those distros
which didn't do anything on shutdown would still cause emergency
unload on older kernels but at least it isn't a regression and things
should just work on newer kernels.

If you ack this, I'll update the shutdown.html page accordingly.
Thanks.

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 07b5a3d..b6a1de8 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -967,6 +967,7 @@ static unsigned int ata_scsi_start_stop_
 		 * for more info.
 		 */
 		if (ata_spindown_compat &&
+		    (qc->dev->flags & ATA_DFLAG_SPUNDOWN) &&
 		    (system_state == SYSTEM_HALT ||
 		     system_state == SYSTEM_POWER_OFF)) {
 			static unsigned long warned = 0;
@@ -1394,6 +1395,14 @@ static void ata_scsi_qc_complete(struct
 		}
 	}
 
+	/* XXX: track spindown state for spindown_compat */
+	if (unlikely(qc->tf.command == ATA_CMD_STANDBY ||
+		     qc->tf.command == ATA_CMD_STANDBYNOW1))
+		qc->dev->flags |= ATA_DFLAG_SPUNDOWN;
+	else if (likely(system_state != SYSTEM_HALT &&
+			system_state != SYSTEM_POWER_OFF))
+		qc->dev->flags &= ~ATA_DFLAG_SPUNDOWN;
+
 	if (need_sense && !ap->ops->error_handler)
 		ata_dump_status(ap->print_id, &qc->result_tf);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 27d9362..a52734b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -140,6 +140,7 @@ enum {
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device limited to PIO mode */
 	ATA_DFLAG_NCQ_OFF	= (1 << 9), /* device limited to non-NCQ mode */
+	ATA_DFLAG_SPUNDOWN	= (1 << 10), /* XXX: for spindown_compat */
 	ATA_DFLAG_INIT_MASK	= (1 << 16) - 1,
 
 	ATA_DFLAG_DETACH	= (1 << 16),
