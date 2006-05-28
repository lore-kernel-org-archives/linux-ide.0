From: Jeff Garzik <jeff@garzik.org>
Subject: [git patch] libata resume fix
Date: Sun, 28 May 2006 16:34:19 -0400
Message-ID: <20060528203419.GA15087@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:51586 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750907AbWE1UeV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 May 2006 16:34:21 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

Mark Lord:
      the latest consensus libata resume fix

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index fa476e7..b046ffa 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4297,6 +4297,7 @@ static int ata_start_drive(struct ata_po
 int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
 {
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
+		ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
 		ata_set_mode(ap);
 	}
