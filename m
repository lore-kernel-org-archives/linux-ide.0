From: Chuck Ebbert <cebbert@redhat.com>
Subject: pata_ali patch not merged?
Date: Mon, 25 Jun 2007 19:13:32 -0400
Message-ID: <46804C1C.9010900@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:35100 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbXFYXNf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Jun 2007 19:13:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>

This patch was found to fix some of the problems with the
pata_ali driver. Is it going to be merged in 2.6.22?

[https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=156482]

--- linux-2.6.22-rc4/drivers/ata/pata_ali.c	2007-06-04 23:05:17.000000000 -0700
+++ devel/drivers/ata/pata_ali.c	2007-06-06 20:49:03.000000000 -0700
@@ -544,34 +628,34 @@ static int ali_init_one(struct pci_dev *
 	/* Revision 0xC2 adds UDMA66 */
 	static const struct ata_port_info info_c2 = {
 		.sht = &ali_sht,
		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x1f,
 		.port_ops = &ali_c2_port_ops
 	};
-	/* Revision 0xC3 is UDMA100 */
+	/* Revision 0xC3 is UDMA66 for now */
 	static const struct ata_port_info info_c3 = {
 		.sht = &ali_sht,
		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
-		.udma_mask = 0x3f,
+		.udma_mask = 0x1f,
 		.port_ops = &ali_c2_port_ops
 	};
-	/* Revision 0xC4 is UDMA133 */
+	/* Revision 0xC4 is UDMA100 */
 	static const struct ata_port_info info_c4 = {
 		.sht = &ali_sht,
		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
-		.udma_mask = 0x7f,
+		.udma_mask = 0x3f,
 		.port_ops = &ali_c2_port_ops
 	};
 	/* Revision 0xC5 is UDMA133 with LBA48 DMA */
 	static const struct ata_port_info info_c5 = {
 		.sht = &ali_sht,
		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7f,
