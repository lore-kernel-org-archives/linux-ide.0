From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: replace ap->cbl tests with ATA_FLAG_SATA tests
Date: Mon, 21 May 2007 18:33:47 +0200
Message-ID: <4651C9EB.2040707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:34172 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773AbXEUQeA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 12:34:00 -0400
Received: by nz-out-0506.google.com with SMTP id z3so370473nzf
        for <linux-ide@vger.kernel.org>; Mon, 21 May 2007 09:33:59 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

ap->cbl == ATA_CBL_SATA indicates SATA cable while ap->flags &
ATA_FLAG_SATA indicates SATA host port.  Till now they always gave the
same result but SATA/PATA bridge handling will change that.  Switch to
ATA_FLAG_SATA test if we're testing for host port type.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 libata-core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d5939e6..da322d4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3364,7 +3364,7 @@ int ata_std_prereset(struct ata_port *ap
 		return 0;
 
 	/* if SATA, resume phy */
-	if (ap->cbl == ATA_CBL_SATA) {
+	if (ap->flags & ATA_FLAG_SATA) {
 		rc = sata_phy_resume(ap, timing, deadline);
 		/* whine about phy resume failure but proceed */
 		if (rc && rc != -EOPNOTSUPP)
@@ -5678,7 +5678,7 @@ irqreturn_t ata_interrupt (int irq, void
  */
 int sata_scr_valid(struct ata_port *ap)
 {
-	return ap->cbl == ATA_CBL_SATA && ap->ops->scr_read;
+	return (ap->flags & ATA_FLAG_SATA) && ap->ops->scr_read;
 }
 
 /**
@@ -6341,7 +6341,7 @@ int ata_host_register(struct ata_host *h
 		if (!ata_port_is_dummy(ap))
 			ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd 0x%p "
 					"ctl 0x%p bmdma 0x%p irq %d\n",
-					ap->cbl == ATA_CBL_SATA ? 'S' : 'P',
+					(ap->flags & ATA_FLAG_SATA) ? 'S' : 'P',
 					ata_mode_string(xfer_mask),
 					ap->ioaddr.cmd_addr,
 					ap->ioaddr.ctl_addr,
