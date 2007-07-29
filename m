From: Meelis Roos <mroos@linux.ee>
Subject: [PATCH] fix runtogether printk's in cmd64x IDE driver
Date: Sun, 29 Jul 2007 23:01:26 +0300 (EEST)
Message-ID: <Pine.SOC.4.64.0707292257150.10801@math.ut.ee>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935472AbXG2UC1@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Fix a couple of runtogether printks in cmd64x.c IDE driver by adding 
proper newlines.

Signed-off-by: Meelis Roos <mroos@linux.ee>

diff --git a/drivers/ide/pci/cmd64x.c b/drivers/ide/pci/cmd64x.c
index 19633c5..0e3b5de 100644
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -475,11 +475,11 @@ static unsigned int __devinit init_chipset_cmd64x(struct pci_dev *dev, const cha
 		switch (rev) {
 		case 0x07:
 		case 0x05:
-			printk("%s: UltraDMA capable", name);
+			printk("%s: UltraDMA capable\n", name);
 			break;
 		case 0x03:
 		default:
-			printk("%s: MultiWord DMA force limited", name);
+			printk("%s: MultiWord DMA force limited\n", name);
 			break;
 		case 0x01:
 			printk("%s: MultiWord DMA limited, "

-- 
Meelis Roos (mroos@linux.ee)
