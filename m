From: akpm@linux-foundation.org
Subject: [patch for 2.6.29? 3/4] pata_legacy: for VLB 32bit PIO don't try tricks with slop
Date: Wed, 11 Feb 2009 13:08:42 -0800
Message-ID: <200902112108.n1BL8go1005308@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56996 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755365AbZBKVJ3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Feb 2009 16:09:29 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

These devices are generally used with ATA anyway and it seems that some
ATAPI will need us to issue the right number of words.  Therefore as we
can't switch mid burst on VLB devices we should only use 32bit I/O for
suitable block sizes.


Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_legacy.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff -puN drivers/ata/pata_legacy.c~pata_legacy-for-vlb-32bit-pio-dont-try-tricks-with-slop drivers/ata/pata_legacy.c
--- a/drivers/ata/pata_legacy.c~pata_legacy-for-vlb-32bit-pio-dont-try-tricks-with-slop
+++ a/drivers/ata/pata_legacy.c
@@ -283,9 +283,10 @@ static void pdc20230_set_piomode(struct 
 static unsigned int pdc_data_xfer_vlb(struct ata_device *dev,
 			unsigned char *buf, unsigned int buflen, int rw)
 {
-	if (ata_id_has_dword_io(dev->id)) {
+	int slop = buflen & 3;
+	/* 32bit I/O capable *and* we need to write a whole number of dwords */
+	if (ata_id_has_dword_io(dev->id) && (slop == 0 || slop == 3)) {
 		struct ata_port *ap = dev->link->ap;
-		int slop = buflen & 3;
 		unsigned long flags;
 
 		local_irq_save(flags);
@@ -735,7 +736,7 @@ static unsigned int vlb32_data_xfer(stru
 	struct ata_port *ap = adev->link->ap;
 	int slop = buflen & 3;
 
-	if (ata_id_has_dword_io(adev->id)) {
+	if (ata_id_has_dword_io(adev->id) && (slop == 0 || slop == 3)) {
 		if (rw == WRITE)
 			iowrite32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
 		else
_
