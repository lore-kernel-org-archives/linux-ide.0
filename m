From: Mark Nelson <mdnelson8@gmail.com>
Subject: [PATCH 0/1] ahci: Enable SB600 64bit DMA on MSI K9AGM2 (MS-7327)
Date: Tue, 26 Jun 2012 12:45:38 +1000
Message-ID: <4FE92252.3010209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60960 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755420Ab2FZCpw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2012 22:45:52 -0400
Received: by dady13 with SMTP id y13so6157514dad.19
        for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2012 19:45:51 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, tj@kernel.org

I've come across another motherboard that uses an SB600 southbridge so I
figured I'd run some tests to see if it worked correctly with 64bit DMA
enabled in the AHCI driver. And it does indeed work properly, so this patch
enables 64bit DMA on the MSI K9AGM2 (MS-7327).

Similar to my earlier patches that enabled 64bit DMA on the MSI K9A2
Platinum (e65cc194f7628ecaa02462f22f42fb09b50dcd49) and the Asus M3A
(3c4aa91f21f65b7b40bdfb015eacbcb8453ccae2) this patch matches on a Board
Product Name DMI field of "MS-7327" which stays constant across all BIOS
versions.

Testing was done in exactly the same way as it was for the other patches
(http://patchwork.ozlabs.org/patch/36881) - with 4GB RAM installed in the
machine (which had ~1GB remapped above the 4GB boundary) a large (~8GB)
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
all the BIOS releases going all the way back to 1.0. I ended up testing
7 BIOS releases from 1.0 to 1.6 (all those that MSI publicly released)
to make sure that there weren't any regressions lurking in there.

And all worked flawlessly. Thus this patch :)

Thanks!
Mark
