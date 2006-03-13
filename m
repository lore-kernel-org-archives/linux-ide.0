From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/2] libata: move IDENTIFY info printing from ata_dev_read_id() to ata_dev_configure()
Date: Mon, 13 Mar 2006 19:51:19 +0900
Message-ID: <20060313105119.GB29996@htj.dyndns.org>
References: <44144172.9040304@garzik.org> <20060312165701.GA9051@htj.dyndns.org> <44146758.6090006@garzik.org> <20060313053350.GD29870@htj.dyndns.org> <20060313054807.GA24419@htj.dyndns.org> <44150897.1060602@garzik.org> <20060313064016.GA26732@htj.dyndns.org> <44152261.2080203@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.180]:22370 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932130AbWCMKvY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 05:51:24 -0500
Received: by pproxy.gmail.com with SMTP id d42so855255pyd
        for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 02:51:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <44152261.2080203@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Move IDENTIFY info printing from ata_dev_read_id() to
ata_dev_configure() and print only if @print_info is non-zero.  This
kills duplicate IDENTIFY info printing during probing.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Jeff, I think ap->msg_enable conversion should happen as bombing
raids.  Such that we have either ATA_DEBUG or msg_enable.  I'll leave
ata_dump_id() alone for the time being.

 libata-core.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 6fe41fb..714b42b 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1120,12 +1120,6 @@ static int ata_dev_read_id(struct ata_po
 
 	swap_buf_le16(id, ATA_ID_WORDS);
 
-	/* print device capabilities */
-	printk(KERN_DEBUG "ata%u: dev %u cfg "
-	       "49:%04x 82:%04x 83:%04x 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
-	       ap->id, dev->devno,
-	       id[49], id[82], id[83], id[84], id[85], id[86], id[87], id[88]);
-
 	/* sanity check */
 	if ((class == ATA_DEV_ATA) != ata_id_is_ata(id)) {
 		rc = -EINVAL;
@@ -1205,6 +1199,13 @@ static int ata_dev_configure(struct ata_
 
 	DPRINTK("ENTER, host %u, dev %u\n", ap->id, dev->devno);
 
+	/* print device capabilities */
+	if (print_info)
+		printk(KERN_DEBUG "ata%u: dev %u cfg 49:%04x 82:%04x 83:%04x "
+		       "84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
+		       ap->id, dev->devno, id[49], id[82], id[83],
+		       id[84], id[85], id[86], id[87], id[88]);
+
 	/* initialize to-be-configured parameters */
 	dev->flags = 0;
 	dev->max_sectors = 0;
