From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH] ide/amd74xx: fix section references
Date: Thu, 3 Mar 2005 19:48:21 -0800
Message-ID: <20050303194821.55fec933.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from fire.osdl.org ([65.172.181.4]:21647 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262664AbVCDEBj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Mar 2005 23:01:39 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl, akpm <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org, vojtech@suse.cz


ide/pci/amd74xx:  data structs point to __init text which should be
  __devinit;
unless (a) these are going away real soon,
or (b) this just can't happen, isn't a real problem,
or (c) other ?

Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000004d8 R_X86_64_64       .init.text+0x0000000000000106
Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000004e8 R_X86_64_64       .init.text
Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000538 R_X86_64_64       .init.text+0x0000000000000106
Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000548 R_X86_64_64       .init.text
Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000598 R_X86_64_64       .init.text+0x0000000000000106
Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000005a8 R_X86_64_64       .init.text
Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000005f8 R_X86_64_64       .init.text+0x0000000000000106
Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000608 R_X86_64_64       .init.text
Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000658 R_X86_64_64       .init.text+0x0000000000000106
Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000668 R_X86_64_64       .init.text
Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000006b8 R_X86_64_64       .init.text+0x0000000000000106
Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000006c8 R_X86_64_64       .init.text
Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000718 R_X86_64_64       .init.text+0x0000000000000106
Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000728 R_X86_64_64       .init.text
Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000778 R_X86_64_64       .init.text+0x0000000000000106
Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000788 R_X86_64_64       .init.text
Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000007d8 R_X86_64_64       .init.text+0x0000000000000106
Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000007e8 R_X86_64_64       .init.text
Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000838 R_X86_64_64       .init.text+0x0000000000000106
Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000848 R_X86_64_64       .init.text
Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000898 R_X86_64_64       .init.text+0x0000000000000106
Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000008a8 R_X86_64_64       .init.text
Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000008f8 R_X86_64_64       .init.text+0x0000000000000106
Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000908 R_X86_64_64       .init.text
Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000958 R_X86_64_64       .init.text+0x0000000000000106
Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000968 R_X86_64_64       .init.text
Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000009b8 R_X86_64_64       .init.text+0x0000000000000106
Error: ./drivers/ide/pci/amd74xx.o .data refers to 00000000000009c8 R_X86_64_64       .init.text
Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000a18 R_X86_64_64       .init.text+0x0000000000000106
Error: ./drivers/ide/pci/amd74xx.o .data refers to 0000000000000a28 R_X86_64_64       .init.text

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/ide/pci/amd74xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./drivers/ide/pci/amd74xx.c~ide_amd_sections ./drivers/ide/pci/amd74xx.c
--- ./drivers/ide/pci/amd74xx.c~ide_amd_sections	2005-03-01 23:38:33.000000000 -0800
+++ ./drivers/ide/pci/amd74xx.c	2005-03-03 15:39:21.000000000 -0800
@@ -308,7 +308,7 @@ static int amd74xx_ide_dma_check(ide_dri
  * and initialize its drive independent registers.
  */
 
-static unsigned int __init init_chipset_amd74xx(struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_amd74xx(struct pci_dev *dev, const char *name)
 {
 	unsigned char t;
 	unsigned int u;
@@ -412,7 +412,7 @@ static unsigned int __init init_chipset_
 	return dev->irq;
 }
 
-static void __init init_hwif_amd74xx(ide_hwif_t *hwif)
+static void __devinit init_hwif_amd74xx(ide_hwif_t *hwif)
 {
 	int i;
 


---
