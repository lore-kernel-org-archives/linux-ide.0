Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB26FC433EF
	for <linux-ide@archiver.kernel.org>; Wed, 16 Feb 2022 11:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiBPLY4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Feb 2022 06:24:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiBPLY4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2022 06:24:56 -0500
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A23D97B8D
        for <linux-ide@vger.kernel.org>; Wed, 16 Feb 2022 03:24:42 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 710DC2327E3D
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: pata_hpt37x: merge mode setting methods
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <4e5e9ea0-f7ac-025a-f94f-a4f0ee009420@omp.ru>
Date:   Wed, 16 Feb 2022 14:24:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

After commit e0afcf140e6e ("ata: pata_hpt37x: disable fast interrupts in
prereset() method") HPT370's and HPT372+'s PIO/DMA mode setting functions
have become identical -- merge them.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
repo.

 drivers/ata/pata_hpt37x.c |   71 +++++++---------------------------------------
 1 file changed, 11 insertions(+), 60 deletions(-)

Index: libata/drivers/ata/pata_hpt37x.c
===================================================================
--- libata.orig/drivers/ata/pata_hpt37x.c
+++ libata/drivers/ata/pata_hpt37x.c
@@ -23,7 +23,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.24"
+#define DRV_VERSION	"0.6.25"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -420,7 +420,7 @@ static int hpt37x_pre_reset(struct ata_l
 	return ata_sff_prereset(link, deadline);
 }
 
-static void hpt370_set_mode(struct ata_port *ap, struct ata_device *adev,
+static void hpt37x_set_mode(struct ata_port *ap, struct ata_device *adev,
 			    u8 mode)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
@@ -449,9 +449,9 @@ static void hpt370_set_mode(struct ata_p
  *	Perform PIO mode setup.
  */
 
-static void hpt370_set_piomode(struct ata_port *ap, struct ata_device *adev)
+static void hpt37x_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
-	hpt370_set_mode(ap, adev, adev->pio_mode);
+	hpt37x_set_mode(ap, adev, adev->pio_mode);
 }
 
 /**
@@ -462,9 +462,9 @@ static void hpt370_set_piomode(struct at
  *	Set up the channel for MWDMA or UDMA modes.
  */
 
-static void hpt370_set_dmamode(struct ata_port *ap, struct ata_device *adev)
+static void hpt37x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
-	hpt370_set_mode(ap, adev, adev->dma_mode);
+	hpt37x_set_mode(ap, adev, adev->dma_mode);
 }
 
 /**
@@ -504,54 +504,6 @@ static void hpt370_bmdma_stop(struct ata
 	ata_bmdma_stop(qc);
 }
 
-static void hpt372_set_mode(struct ata_port *ap, struct ata_device *adev,
-			    u8 mode)
-{
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	int addr = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
-	u32 reg, timing, mask;
-
-	/* Determine timing mask and find matching mode entry */
-	if (mode < XFER_MW_DMA_0)
-		mask = 0xcfc3ffff;
-	else if (mode < XFER_UDMA_0)
-		mask = 0x31c001ff;
-	else
-		mask = 0x303c0000;
-
-	timing = hpt37x_find_mode(ap, mode);
-
-	pci_read_config_dword(pdev, addr, &reg);
-	reg = (reg & ~mask) | (timing & mask);
-	pci_write_config_dword(pdev, addr, reg);
-}
-
-/**
- *	hpt372_set_piomode		-	PIO setup
- *	@ap: ATA interface
- *	@adev: device on the interface
- *
- *	Perform PIO mode setup.
- */
-
-static void hpt372_set_piomode(struct ata_port *ap, struct ata_device *adev)
-{
-	hpt372_set_mode(ap, adev, adev->pio_mode);
-}
-
-/**
- *	hpt372_set_dmamode		-	DMA timing setup
- *	@ap: ATA interface
- *	@adev: Device being configured
- *
- *	Set up the channel for MWDMA or UDMA modes.
- */
-
-static void hpt372_set_dmamode(struct ata_port *ap, struct ata_device *adev)
-{
-	hpt372_set_mode(ap, adev, adev->dma_mode);
-}
-
 /**
  *	hpt37x_bmdma_stop		-	DMA engine stop
  *	@qc: ATA command
@@ -589,8 +541,8 @@ static struct ata_port_operations hpt370
 
 	.mode_filter	= hpt370_filter,
 	.cable_detect	= hpt37x_cable_detect,
-	.set_piomode	= hpt370_set_piomode,
-	.set_dmamode	= hpt370_set_dmamode,
+	.set_piomode	= hpt37x_set_piomode,
+	.set_dmamode	= hpt37x_set_dmamode,
 	.prereset	= hpt37x_pre_reset,
 };
 
@@ -604,8 +556,7 @@ static struct ata_port_operations hpt370
 };
 
 /*
- *	Configuration for HPT371 and HPT302. Slightly different PIO and DMA
- *	mode setting functionality.
+ *	Configuration for HPT371 and HPT302.
  */
 
 static struct ata_port_operations hpt302_port_ops = {
@@ -614,8 +565,8 @@ static struct ata_port_operations hpt302
 	.bmdma_stop	= hpt37x_bmdma_stop,
 
 	.cable_detect	= hpt37x_cable_detect,
-	.set_piomode	= hpt372_set_piomode,
-	.set_dmamode	= hpt372_set_dmamode,
+	.set_piomode	= hpt37x_set_piomode,
+	.set_dmamode	= hpt37x_set_dmamode,
 	.prereset	= hpt37x_pre_reset,
 };
 
