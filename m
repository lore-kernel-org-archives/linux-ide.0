From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCH] 2.6.x libata fix
Date: Wed, 22 Dec 2004 21:17:09 -0500
Message-ID: <20041223021709.GA25086@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([63.115.148.101]:37264 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261156AbULWCRK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Dec 2004 21:17:10 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: achew@nvidia.com, linux-ide@vger.kernel.org


Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/sata_nv.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/12/22 1.2216)
   [libata sata_nv] fix dev detect by removing sata-reset flag
   
   Remove ATA_FLAG_SATA_RESET.  See comment in code and
   http://bugme.osdl.org/show_bug.cgi?id=3352 for more details.
   
   This problem needs more investigation.  Removing the flag
   appears to fix the problems in the field, so it's the best
   temporary solution.

diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2004-12-22 21:16:18 -05:00
+++ b/drivers/scsi/sata_nv.c	2004-12-22 21:16:18 -05:00
@@ -218,10 +218,18 @@
 	.host_stop		= nv_host_stop,
 };
 
+/* FIXME: The hardware provides the necessary SATA PHY controls
+ * to support ATA_FLAG_SATA_RESET.  However, it is currently
+ * necessary to disable that flag, to solve misdetection problems.
+ * See http://bugme.osdl.org/show_bug.cgi?id=3352 for more info.
+ *
+ * This problem really needs to be investigated further.  But in the
+ * meantime, we avoid ATA_FLAG_SATA_RESET to get people working.
+ */
 static struct ata_port_info nv_port_info = {
 	.sht		= &nv_sht,
 	.host_flags	= ATA_FLAG_SATA |
-			  ATA_FLAG_SATA_RESET |
+			  /* ATA_FLAG_SATA_RESET | */
 			  ATA_FLAG_SRST |
 			  ATA_FLAG_NO_LEGACY,
 	.pio_mask	= NV_PIO_MASK,
