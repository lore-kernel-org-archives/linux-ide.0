From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: add 150ms between completion of hardreset and status checking
Date: Fri, 2 Feb 2007 15:29:27 +0900
Message-ID: <20070202062927.GA1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:54772 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423136AbXBBG3e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 01:29:34 -0500
Received: by nz-out-0506.google.com with SMTP id s1so778034nze
        for <linux-ide@vger.kernel.org>; Thu, 01 Feb 2007 22:29:32 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Follow the old SRST rule and delay 150ms between completion of
hardreset and status checking.  Debouncing delay should usually cover
this but debounce duration could be shorter than 150ms under certain
circumstances.

Usefulness depends on host controller implementation but it can't hurt
and serves as a reminder that 2s delay for GoVault should also be
added here.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f210dbd..582e44d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3014,6 +3014,9 @@ int sata_std_hardreset(struct ata_port *ap, unsigned int *class)
 		return 0;
 	}
 
+	/* wait a while before checking status, see SRST for more info */
+	msleep(150);
+
 	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
 		ata_port_printk(ap, KERN_ERR,
 				"COMRESET failed (device not ready)\n");
-- 
1.4.4.4

