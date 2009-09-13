From: Robert Hancock <hancockrwd@gmail.com>
Subject: [PATCH] pata_amd: do not filter out valid modes in nv_mode_filter
Date: Sat, 12 Sep 2009 23:54:47 -0600
Message-ID: <4AAC8927.4030401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.211.174]:64227 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbZIMFzG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Sep 2009 01:55:06 -0400
Received: by ywh4 with SMTP id 4so3057170ywh.5
        for <linux-ide@vger.kernel.org>; Sat, 12 Sep 2009 22:55:10 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <tj@kernel.org>, stable@kernel.org

On a Compaq Presario V3000 laptop (NVIDIA MCP51 chipset), pata_amd selects
PIO0 mode for the PATA DVD-RAM drive instead of MWDMA2 which it supports:

ata4.00: ATAPI: HL-DT-ST DVDRAM GSA-4084N, KQ09, max MWDMA2
ata4: nv_mode_filter: 0x39f&0x7001->0x1, BIOS=0x0 (0x0) ACPI=0x7001 (60:600:0x11)
ata4.00: configured for PIO0

For some reason, the BIOS-set UDMA configuration returns 0 and the ACPI _GTM
reports that UDMA2 and PIO0 are enabled. This causes nv_mode_filter to end up
allowing only PIO0 and UDMA0-2. Since the drive doesn't support UDMA we end up
using PIO0.

Since the controllers should always support PIO4, MWDMA2 and UDMA2 regardless
of what cable type is used, let's make sure we don't filter out these modes
regardless of what wacky settings the BIOS is using.

Signed-off-by: Robert Hancock <hancockrwd@gmail.com>
Cc: stable@kernel.org

diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 33a74f1..567f3f7 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -307,6 +307,9 @@ static unsigned long nv_mode_filter(struct ata_device *dev,
 		limit |= ATA_MASK_PIO;
 	if (!(limit & (ATA_MASK_MWDMA | ATA_MASK_UDMA)))
 		limit |= ATA_MASK_MWDMA | ATA_MASK_UDMA;
+	/* PIO4, MWDMA2, UDMA2 should always be supported regardless of
+	   cable detection result */
+	limit |= ata_pack_xfermask(ATA_PIO4, ATA_MWDMA2, ATA_UDMA2);
 
 	ata_port_printk(ap, KERN_DEBUG, "nv_mode_filter: 0x%lx&0x%lx->0x%lx, "
 			"BIOS=0x%lx (0x%x) ACPI=0x%lx%s\n",
