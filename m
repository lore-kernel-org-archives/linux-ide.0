From: Brett Russ <russb@emc.com>
Subject: [PATCH] libata-dev-2.6: verify cmd bug fixes/support
Date: Tue, 01 Feb 2005 19:34:43 -0500
Message-ID: <42002023.9060606@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from mailhub.lss.emc.com ([168.159.2.31]:26682 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261946AbVBBAep
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Feb 2005 19:34:45 -0500
Received: from [168.159.31.32] (lns1032.lss.emc.com [168.159.31.32])
	by mailhub.lss.emc.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id j120Yh3v012730
	for <linux-ide@vger.kernel.org>; Tue, 1 Feb 2005 19:34:43 -0500 (EST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Below find a patch which gets the read verify command working.  Note 
that in order to get this 100% working one also needs to apply Albert 
Lee's patch:
http://article.gmane.org/gmane.linux.ide/2798
to libata* before or after this.  I've stripped out his portion of the 
changes because I can't sign off on his work.

This work was verified using a SATA bus analyzer and the sg_verify 
utility which sends VERIFY_10.  Should libata support VERIFY_12?

Signed-off-by: Brett Russ <russb@emc.com>

===== drivers/scsi/libata-scsi.c 1.68 vs edited =====
--- 1.68/drivers/scsi/libata-scsi.c     2004-12-29 02:35:53 -05:00
+++ edited/drivers/scsi/libata-scsi.c   2005-02-01 19:26:55 -05:00
@@ -741,13 +741,18 @@
         }

         if (lba48) {
+               tf->command = ATA_CMD_VERIFY_EXT;
+
                 tf->hob_nsect = (n_sect >> 8) & 0xff;

                 tf->hob_lbah = (sect >> 40) & 0xff;
                 tf->hob_lbam = (sect >> 32) & 0xff;
                 tf->hob_lbal = (sect >> 24) & 0xff;
-       } else
+       } else {
+               tf->command = ATA_CMD_VERIFY;
+
                 tf->device |= (sect >> 24) & 0xf;
+       }

         tf->nsect = n_sect & 0xff;

===== include/linux/ata.h 1.20 vs edited =====
--- 1.20/include/linux/ata.h    2004-11-14 03:21:22 -05:00
+++ edited/include/linux/ata.h  2005-02-01 16:28:09 -05:00
@@ -123,6 +123,9 @@
         ATA_CMD_PIO_WRITE_EXT   = 0x34,
         ATA_CMD_SET_FEATURES    = 0xEF,
         ATA_CMD_PACKET          = 0xA0,
+       ATA_CMD_VERIFY          = 0x40,
+       ATA_CMD_VERIFY_EXT      = 0x42,
+

         /* SETFEATURES stuff */
         SETFEATURES_XFER        = 0x03,
