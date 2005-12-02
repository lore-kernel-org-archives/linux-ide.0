From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: ignore all zero PCS value on ICH5's
Date: Fri, 2 Dec 2005 12:26:05 +0900
Message-ID: <20051202032605.GA15528@htj.dyndns.org>
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com> <438DA3FA.2010809@eq.cz> <a762e240511301405s433109b7n93e7fdcc7409bef5@mail.gmail.com> <438EC502.1090103@keytradebank.com> <20051201112015.GA10462@htj.dyndns.org> <438EF3B6.7020007@keytradebank.com> <438EFAA5.3070901@gmail.com> <438FA924.1090005@pobox.com> <438FB8B5.8070505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:53589 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964827AbVLBD0K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Dec 2005 22:26:10 -0500
Received: by zproxy.gmail.com with SMTP id 14so146533nzn
        for <linux-ide@vger.kernel.org>; Thu, 01 Dec 2005 19:26:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <438FB8B5.8070505@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jean-Fran?ois Stenuit <jfs@keytradebank.com>, Keith Mannthey <kmannth@gmail.com>, "0602@eq.cz" <0602@eq.cz>, Linux-ide <linux-ide@vger.kernel.org>

Some ICH5's report 0 for PCS even when they have active working ports.
This patch makes piix_sata_probe() ignore 0 PCS value on ICH5's and
probe all ports in such cases.  And while at it, remove bogus
assignment to mask.

Signed-off-by: Tejun Heo <htejun@gmail.com>

--

Hi, Jean-Francois (sorry, cannot type that character) and 0602.

Can you guys please verify that this patch works?  This patch is
supposed to do the same thing as my previous patch with
override_PCS=1.


diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 887b2b9..482995b 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -58,6 +58,7 @@ enum {
 	ICH5_PCS		= 0x92,	/* port control and status */
 	PIIX_SCC		= 0x0A, /* sub-class code register */
 
+	PIIX_FLAG_UNRELIABLE_PCS= (1 << 27), /* PCS bits are unreliable */
 	PIIX_FLAG_AHCI		= (1 << 28), /* AHCI possible */
 	PIIX_FLAG_CHECKINTR	= (1 << 29), /* make sure PCI INTx enabled */
 	PIIX_FLAG_COMBINED	= (1 << 30), /* combined mode possible */
@@ -223,7 +224,8 @@ static struct ata_port_info piix_port_in
 	{
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
-				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR,
+				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR |
+				  PIIX_FLAG_UNRELIABLE_PCS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -362,12 +364,15 @@ static int piix_sata_probe (struct ata_p
 	int orig_mask, mask, i;
 	u8 pcs;
 
-	mask = (PIIX_PORT_PRESENT << ap->hard_port_no) |
-	       (PIIX_PORT_ENABLED << ap->hard_port_no);
-
 	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
 	orig_mask = (int) pcs & 0xff;
 
+	if (orig_mask == 0 && ap->flags & PIIX_FLAG_UNRELIABLE_PCS) {
+		printk(KERN_INFO "ata%u: PIIX PCS reports 0x00, ignoring PCS\n",
+		       ap->id);
+		return 1;
+	}
+
 	/* TODO: this is vaguely wrong for ICH6 combined mode,
 	 * where only two of the four SATA ports are mapped
 	 * onto a single ATA channel.  It is also vaguely inaccurate
