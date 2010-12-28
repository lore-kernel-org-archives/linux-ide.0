From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pata_hpt3x2n: calculate average f_CNT
Date: Tue, 28 Dec 2010 22:54:54 +0300
Message-ID: <201012282254.54161.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:47181 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751136Ab0L1T4M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Dec 2010 14:56:12 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

Allow hpt3x2n_pci_clock() to calculate the average f_CNT register value iff
HighPoint BIOS hasn't saved one, just like the 'pata_hpt37x' driver (reading
the full 16-bit register, unlike what that driver does), so that this driver
would work correctly on e.g. non-x86 machine with 66 MHz PCI.

I'm not sure why Alan has only done this in one driver and not the other...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree plus the two patches I posted
before:

http://marc.info/?l=linux-ide&m=129356208121192
http://marc.info/?l=linux-ide&m=129330632207779

 drivers/ata/pata_hpt3x2n.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt3x2n.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt3x2n.c
+++ linux-2.6/drivers/ata/pata_hpt3x2n.c
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt3x2n"
-#define DRV_VERSION	"0.3.11"
+#define DRV_VERSION	"0.3.12"
 
 enum {
 	HPT_PCI_FAST	=	(1 << 31),
@@ -413,8 +413,19 @@ static int hpt3x2n_pci_clock(struct pci_
 
 	fcnt = inl(iobase + 0x90);	/* Not PCI readable for some chips */
 	if ((fcnt >> 12) != 0xABCDE) {
-		printk(KERN_WARNING "hpt3xn: BIOS clock data not set.\n");
-		return 33;	/* Not BIOS set */
+		int i;
+		u16 sr;
+		u32 total = 0;
+
+		printk(KERN_WARNING "pata_hpt3x2n: BIOS clock data not set.\n");
+
+		/* This is the process the HPT371 BIOS is reported to use */
+		for (i = 0; i < 128; i++) {
+			pci_read_config_word(pdev, 0x78, &sr);
+			total += sr & 0x1FF;
+			udelay(15);
+		}
+		fcnt = total / 128;
 	}
 	fcnt &= 0x1FF;
 
