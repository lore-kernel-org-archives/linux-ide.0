From: Mark Nelson <mdnelson8@gmail.com>
Subject: [PATCH 0/1] ahci: Enable SB600 64bit DMA on Asus M3A
Date: Mon, 27 Jun 2011 16:31:47 +1000
Message-ID: <BANLkTimcLiba=7E4vp-_VyhNWM8_EGzTFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34039 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756535Ab1F0Gbt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jun 2011 02:31:49 -0400
Received: by vws1 with SMTP id 1so3091428vws.19
        for <linux-ide@vger.kernel.org>; Sun, 26 Jun 2011 23:31:48 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

I've come across another motherboard that uses an SB600 southbridge so I
figured I'd run some tests to see if it worked correctly with 64bit DMA
enabled in the AHCI driver. And it does indeed work properly, so this patch
enables 64bit DMA on the Asus M3A.

Similar to my earlier patch that enabled 64bit DMA on the MSI K9A2 Platinum
(e65cc194f7628ecaa02462f22f42fb09b50dcd49) this patch matches on a Board
Product Name DMI field of "M3A" which stays constant across all BIOS
versions.

Testing was done in exactly the same way as it was for the earlier patch
(http://patchwork.ozlabs.org/patch/36881) - with 4GB RAM installed in the
machine (which had ~1GB remapped above the 4GB boundary) a large (~7GB)
file was copied and the checksums of the copy and original were compared.
To make sure that we were actually DMAing to a high enough address for the
copy the following simple patch was used:

---
 drivers/ata/libahci.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6/drivers/ata/libahci.c
===================================================================
--- linux-2.6.orig/drivers/ata/libahci.c
+++ linux-2.6/drivers/ata/libahci.c
@@ -1395,6 +1395,11 @@ static unsigned int ahci_fill_sg(struct
 	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		dma_addr_t addr = sg_dma_address(sg);
 		u32 sg_len = sg_dma_len(sg);
+		static int cnt;
+
+		if (addr > 0xffffffffULL && !(cnt++ % 500))
+			printk("ahci: dma'ing to address 0x%llx\n",
+				(unsigned long long)addr);

 		ahci_sg[si].addr = cpu_to_le32(addr & 0xffffffff);
 		ahci_sg[si].addr_hi = cpu_to_le32((addr >> 16) >> 16);


For the testing I had an old enough CPU that I could flash to and test
all the BIOS releases going all the way back to 0301 (the initial release
that the earliest batch of boards shipped with). I ended up testing 12
BIOS releases from 0301 to 1206 (all those that Asus publicy released) to
make sure that there weren't any regressions lurking in there.

And all worked flawlessly. Thus this patch :)

Thanks!
Mark
