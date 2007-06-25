From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2.6.22-rc5] libata: fix infinite EH waiting bug
Date: Mon, 25 Jun 2007 21:47:11 +0900
Message-ID: <467FB94F.1040000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:40464 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbXFYMrQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 08:47:16 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1340008nzf
        for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 05:47:15 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

When EH gives up after repeated exceptions, it doesn't't clear the
PENDING bit on exit which leaves PENDING bit set without EH actually
scheduled.  This makes ata_port_wait_eh() to wait forever makes rmmod
hang on such port.  Fix it by clearing the flag.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index d807098..fbdfefb 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -336,6 +336,7 @@ void ata_scsi_error(struct Scsi_Host *host)
 			}
 			ata_port_printk(ap, KERN_ERR, "EH pending after %d "
 					"tries, giving up\n", ATA_EH_MAX_REPEAT);
+			ap->pflags &= ~ATA_PFLAG_EH_PENDING;
 		}
 
 		/* this run is complete, make sure EH info is clear */
