From: Chuck Ebbert <cebbert@redhat.com>
Subject: [patch] libata: fix last_ctl caching in ata_tf_read()
Date: Tue, 17 Jul 2007 09:53:39 -0400
Message-ID: <469CC9E3.4030907@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:48326 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753470AbXGQNxn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Jul 2007 09:53:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

libata: fix last_ctl caching in ata_tf_read()

last_ctl was not cached properly. (Pointed out
by Tejun Heo.)

Signed-off-by: Chuck Ebbert <cebbert@redhat.com>

---
(Apply after Petr's patch to fix SMART bugs.)

 drivers/ata/libata-sff.c |    4 ++++
 1 file changed, 4 insertions(+)

--- 2.6.22-d390.orig/drivers/ata/libata-sff.c
+++ 2.6.22-d390/drivers/ata/libata-sff.c
@@ -196,7 +196,9 @@ void ata_tf_read(struct ata_port *ap, st
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
+	ap->last_ctl = tf->ctl;
 	iowrite8(tf->ctl, ioaddr->ctl_addr);
+
 	tf->command = ata_check_status(ap);
 	tf->feature = ioread8(ioaddr->error_addr);
 	tf->nsect = ioread8(ioaddr->nsect_addr);
@@ -206,7 +208,9 @@ void ata_tf_read(struct ata_port *ap, st
 	tf->device = ioread8(ioaddr->device_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
+		ap->last_ctl = tf->ctl | ATA_HOB;
 		iowrite8(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
+
 		tf->hob_feature = ioread8(ioaddr->error_addr);
 		tf->hob_nsect = ioread8(ioaddr->nsect_addr);
 		tf->hob_lbal = ioread8(ioaddr->lbal_addr);
