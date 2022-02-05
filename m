Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B451C433EF
	for <linux-ide@archiver.kernel.org>; Sat,  5 Feb 2022 18:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381492AbiBES74 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 5 Feb 2022 13:59:56 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:58926 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381933AbiBES57 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 5 Feb 2022 13:57:59 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru B602720621CE
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2] pata_hpt366: check channel enable bits
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <887eaaab-8cab-64c7-f932-4d5e7df579b5@omp.ru>
Date:   Sat, 5 Feb 2022 21:57:55 +0300
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

HighPoint HPT36x chips did turn out to have the channel enable bits --
however, badly implemented. Make use of them, despite that is probably
only going to burden the driver's code -- assuming both channels are
always enabled by the HighPoint BIOS anyway...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'master' branch of Damien Le Moal's 'libata.git'
repo.

Changes in version 2:
- fixed the chip family in the 'kernel-doc' comment to hpt366_prereset;
- reworded and reformatted the patch description.

 drivers/ata/pata_hpt366.c |   42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

Index: libata/drivers/ata/pata_hpt366.c
===================================================================
--- libata.orig/drivers/ata/pata_hpt366.c
+++ libata/drivers/ata/pata_hpt366.c
@@ -23,7 +23,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt366"
-#define DRV_VERSION	"0.6.11"
+#define DRV_VERSION	"0.6.12"
 
 struct hpt_clock {
 	u8	xfer_mode;
@@ -278,6 +278,35 @@ static void hpt366_set_dmamode(struct at
 	hpt366_set_mode(ap, adev, adev->dma_mode);
 }
 
+/**
+ *	hpt366_prereset		-	reset the hpt36x bus
+ *	@link: ATA link to reset
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	Perform the initial reset handling for the 36x series controllers.
+ *	Reset the hardware and state machine,
+ */
+
+static int hpt366_prereset(struct ata_link *link, unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	/*
+	 * HPT36x chips have one channel per function and have
+	 * both channel enable bits located differently and visible
+	 * to both functions -- really stupid design decision... :-(
+	 * Bit 4 is for the primary channel, bit 5 for the secondary.
+	 */
+	static const struct pci_bits hpt366_enable_bits = {
+		0x50, 1, 0x30, 0x30
+	};
+
+	if (!pci_test_config_bits(pdev, &hpt366_enable_bits))
+		return -ENOENT;
+
+	return ata_sff_prereset(link, deadline);
+}
+
 static struct scsi_host_template hpt36x_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
@@ -288,6 +317,7 @@ static struct scsi_host_template hpt36x_
 
 static struct ata_port_operations hpt366_port_ops = {
 	.inherits	= &ata_bmdma_port_ops,
+	.prereset	= hpt366_prereset,
 	.cable_detect	= hpt36x_cable_detect,
 	.mode_filter	= hpt366_filter,
 	.set_piomode	= hpt366_set_piomode,
@@ -304,7 +334,7 @@ static struct ata_port_operations hpt366
 
 static void hpt36x_init_chipset(struct pci_dev *dev)
 {
-	u8 drive_fast;
+	u8 drive_fast, mcr1;
 
 	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, (L1_CACHE_BYTES / 4));
 	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x78);
@@ -314,6 +344,14 @@ static void hpt36x_init_chipset(struct p
 	pci_read_config_byte(dev, 0x51, &drive_fast);
 	if (drive_fast & 0x80)
 		pci_write_config_byte(dev, 0x51, drive_fast & ~0x80);
+
+	/*
+	 * Now we'll have to force both channels enabled if at least one
+	 * of them has been enabled by BIOS...
+	 */
+	pci_read_config_byte(dev, 0x50, &mcr1);
+	if (mcr1 & 0x30)
+		pci_write_config_byte(dev, 0x50, mcr1 | 0x30);
 }
 
 /**
