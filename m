Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA05C433EF
	for <linux-ide@archiver.kernel.org>; Sat,  9 Apr 2022 20:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiDIUbn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 9 Apr 2022 16:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiDIUbm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 9 Apr 2022 16:31:42 -0400
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB062D732B
        for <linux-ide@vger.kernel.org>; Sat,  9 Apr 2022 13:29:29 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 5616A20D5200
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: pata_sil680: fix result type of sil680_sel{dev|reg}()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <9fceaba7-22e0-8cb2-fc69-04c0b8ece7db@omp.ru>
Date:   Sat, 9 Apr 2022 23:29:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

sil680_sel{dev|reg}() return a PCI config space address but needlessly
use the *unsigned long* type for that,  whereas the PCI config space
accessors take *int* for the address parameter.  Switch these functions
to returning *int*, updating the local variables at their call sites.
Add the empty lines after some declarations, while at it...

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
repo.

 drivers/ata/pata_sil680.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

Index: libata/drivers/ata/pata_sil680.c
===================================================================
--- libata.orig/drivers/ata/pata_sil680.c
+++ libata/drivers/ata/pata_sil680.c
@@ -47,9 +47,10 @@
  *	criticial.
  */
 
-static unsigned long sil680_selreg(struct ata_port *ap, int r)
+static int sil680_selreg(struct ata_port *ap, int r)
 {
-	unsigned long base = 0xA0 + r;
+	int base = 0xA0 + r;
+
 	base += (ap->port_no << 4);
 	return base;
 }
@@ -65,9 +66,10 @@ static unsigned long sil680_selreg(struc
  *	the unit shift.
  */
 
-static unsigned long sil680_seldev(struct ata_port *ap, struct ata_device *adev, int r)
+static int sil680_seldev(struct ata_port *ap, struct ata_device *adev, int r)
 {
-	unsigned long base = 0xA0 + r;
+	int base = 0xA0 + r;
+
 	base += (ap->port_no << 4);
 	base |= adev->devno ? 2 : 0;
 	return base;
@@ -85,8 +87,9 @@ static unsigned long sil680_seldev(struc
 static int sil680_cable_detect(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	unsigned long addr = sil680_selreg(ap, 0);
+	int addr = sil680_selreg(ap, 0);
 	u8 ata66;
+
 	pci_read_config_byte(pdev, addr, &ata66);
 	if (ata66 & 1)
 		return ATA_CBL_PATA80;
@@ -113,9 +116,9 @@ static void sil680_set_piomode(struct at
 		0x328A, 0x2283, 0x1281, 0x10C3, 0x10C1
 	};
 
-	unsigned long tfaddr = sil680_selreg(ap, 0x02);
-	unsigned long addr = sil680_seldev(ap, adev, 0x04);
-	unsigned long addr_mask = 0x80 + 4 * ap->port_no;
+	int tfaddr = sil680_selreg(ap, 0x02);
+	int addr = sil680_seldev(ap, adev, 0x04);
+	int addr_mask = 0x80 + 4 * ap->port_no;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int pio = adev->pio_mode - XFER_PIO_0;
 	int lowest_pio = pio;
@@ -165,9 +168,9 @@ static void sil680_set_dmamode(struct at
 	static const u16 dma_table[3] = { 0x2208, 0x10C2, 0x10C1 };
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	unsigned long ma = sil680_seldev(ap, adev, 0x08);
-	unsigned long ua = sil680_seldev(ap, adev, 0x0C);
-	unsigned long addr_mask = 0x80 + 4 * ap->port_no;
+	int ma = sil680_seldev(ap, adev, 0x08);
+	int ua = sil680_seldev(ap, adev, 0x0C);
+	int addr_mask = 0x80 + 4 * ap->port_no;
 	int port_shift = adev->devno * 4;
 	u8 scsc, mode;
 	u16 multi, ultra;
@@ -219,7 +222,7 @@ static void sil680_sff_exec_command(stru
 static bool sil680_sff_irq_check(struct ata_port *ap)
 {
 	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
-	unsigned long addr	= sil680_selreg(ap, 1);
+	int addr		= sil680_selreg(ap, 1);
 	u8 val;
 
 	pci_read_config_byte(pdev, addr, &val);
