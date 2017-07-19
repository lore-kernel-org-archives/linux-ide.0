From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] libata: array underflow in ata_find_dev()
Date: Wed, 19 Jul 2017 13:06:41 +0300
Message-ID: <20170719100641.7ste3wo6ap2g2djv@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:25699 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753281AbdGSKGw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 19 Jul 2017 06:06:52 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org

My static checker complains that "devno" can be negative, meaning that
we read before the start of the loop.  I've looked at the code, and I
think the warning is right.  This come from /proc so it's root only or
it would be quite a quite a serious bug.  The call tree looks like this:

proc_scsi_write() <- gets id and channel from simple_strtoul()
-> scsi_add_single_device() <- calls shost->transportt->user_scan()
   -> ata_scsi_user_scan()
      -> ata_find_dev()

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d462c5a3a7ef..44ba292f2cd7 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3030,10 +3030,12 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 static struct ata_device *ata_find_dev(struct ata_port *ap, int devno)
 {
 	if (!sata_pmp_attached(ap)) {
-		if (likely(devno < ata_link_max_devices(&ap->link)))
+		if (likely(devno >= 0 &&
+			   devno < ata_link_max_devices(&ap->link)))
 			return &ap->link.device[devno];
 	} else {
-		if (likely(devno < ap->nr_pmp_links))
+		if (likely(devno >= 0 &&
+			   devno < ap->nr_pmp_links))
 			return &ap->pmp_link[devno].device[0];
 	}
 
