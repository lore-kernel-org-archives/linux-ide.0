From: Chuck Ebbert <cebbert@redhat.com>
Subject: [patch] libata: fix last_ctl caching in ata_tf_read()
Date: Mon, 16 Jul 2007 14:35:34 -0400
Message-ID: <469BBA76.5000901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:51390 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbXGPSfg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Jul 2007 14:35:36 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6GIZY73014333
	for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 14:35:34 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6GIZY1F009223
	for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 14:35:34 -0400
Received: from [172.16.83.145] (dhcp83-145.boston.redhat.com [172.16.83.145])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id l6GIZYIg025603
	for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 14:35:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

libata: fix last_ctl caching in ata_tf_read()

last_ctl was not cached properly. (Pointed out
by Tejun Heo.)

Signed-off-by: Chuck Ebbert <cebbert@redhat.com>

---
(Apply after Petr's patch to fix the sense data.)

 drivers/ata/libata-sff.c |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-2.6.22.noarch.orig/drivers/ata/libata-sff.c
+++ linux-2.6.22.noarch/drivers/ata/libata-sff.c
@@ -196,7 +196,9 @@ void ata_tf_read(struct ata_port *ap, st
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
+	ap->last_ctl = tf->ctl;
 	iowrite8(tf->ctl, ioaddr->ctl_addr);
+
 	tf->command = ata_check_status(ap);
 	tf->feature = ioread8(ioaddr->error_addr);
 	tf->nsect = ioread8(ioaddr->nsect_addr);
@@ -205,7 +208,9 @@ void ata_tf_read(struct ata_port *ap, st
 	tf->device = ioread8(ioaddr->device_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
+		ap->last_ctl = tf_ctl | ATA_HOB;
 		iowrite8(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
+
 		tf->hob_feature = ioread8(ioaddr->error_addr);
 		tf->hob_nsect = ioread8(ioaddr->nsect_addr);
 		tf->hob_lbal = ioread8(ioaddr->lbal_addr);
