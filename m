From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [RFC PATCH] ata: piix: wait for end of asynchronous probing before
Date: Mon, 17 Oct 2016 18:45:04 +0200
Message-ID: <1476722704-12839-1-git-send-email-clabbe.montjoie@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35710 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030203AbcJQQrR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 17 Oct 2016 12:47:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>

Enabling CONFIG_DEBUG_TEST_DRIVER_REMOVE under qemu give me a WARN() trace.
Waiting for the end of the ATA RESET seems to clean the issue.
But I am not sure if my solution and the way to solve it are correct.

Regards

---8<---
>From b2d097130a9d67529075f6e3c3d9552ac5415d18 Mon Sep 17 00:00:00 2001
From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Mon, 17 Oct 2016 17:50:02 +0200
Subject: [RFC PATCH] ata: piix: wait for end of asynchronous probing before
 removing

Under qemu I got the following trace with CONFIG_DEBUG_TEST_DRIVER_REMOVE
[    1.092021] ata_piix 0000:00:01.1: version 2.13
[    1.093277] scsi host0: ata_piix
[    1.093720] scsi host1: ata_piix
[    1.094152] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc080 irq 14
[    1.094902] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc088 irq 15
[    1.252998] ------------[ cut here ]------------
[    1.253799] WARNING: CPU: 0 PID: 1 at drivers/ata/libata-core.c:6482 ata_host_detach+0x148/0x150
[    1.255543] Modules linked in:
[    1.256088] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.0-rc1+ #58
[    1.257038] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.9.3-0-ge2fc41e-prebuilt.qemu-project.org 04/01/2014
[    1.258798]  ffffc9000000bcb0 ffffffff81282271 0000000000000000 0000000000000000
[    1.259852]  ffffc9000000bcf0 ffffffff810507a9 0000195200000000 0000000000000286
[    1.260859]  ffff88003db14000 0000000000000000 ffff88003e2ebb58 0000000000000000
[    1.261801] Call Trace:
[    1.262035]  [<ffffffff81282271>] dump_stack+0x63/0x82
[    1.262493]  [<ffffffff810507a9>] __warn+0xd9/0x100
[    1.274959]  [<ffffffff81050838>] warn_slowpath_null+0x18/0x20
[    1.289409]  [<ffffffff81433b58>] ata_host_detach+0x148/0x150
[    1.303461]  [<ffffffff81433b70>] ata_pci_remove_one+0x10/0x20
[    1.316370]  [<ffffffff8144c52f>] piix_remove_one+0x2f/0x40
[    1.332374]  [<ffffffff812be43f>] pci_device_remove+0x3f/0xc0
[    1.345815]  [<ffffffff813e80bf>] driver_probe_device+0xaf/0x370
[    1.362132]  [<ffffffff813e8420>] __driver_attach+0xa0/0xb0
[    1.376482]  [<ffffffff813e8380>] ? driver_probe_device+0x370/0x370
[    1.393559]  [<ffffffff813e63df>] bus_for_each_dev+0x5f/0x90
[    1.409771]  [<ffffffff813e8689>] driver_attach+0x19/0x20
[    1.427594]  [<ffffffff813e6efd>] bus_add_driver+0x1bd/0x230
[    1.443882]  [<ffffffff818e7028>] ? ahci_driver_init+0x14/0x14
[    1.463052]  [<ffffffff813e8d1b>] driver_register+0x5b/0xe0
[    1.481706]  [<ffffffff812bd2b7>] __pci_register_driver+0x47/0x50
[    1.500596]  [<ffffffff818e7041>] piix_init+0x19/0x29
[    1.520256]  [<ffffffff81000454>] do_one_initcall+0x54/0x190
[    1.538756]  [<ffffffff818baf56>] kernel_init_freeable+0x118/0x1a0
[    1.558925]  [<ffffffff815f0840>] ? rest_init+0x70/0x70
[    1.576918]  [<ffffffff815f0849>] kernel_init+0x9/0x100
[    1.598419]  [<ffffffff815f5f55>] ret_from_fork+0x25/0x30
[    1.618140] ---[ end trace 28d4107ce1a01744 ]---
[    1.638275] tsc: Refined TSC clocksource calibration: 3210.724 MHz
[    1.659721] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e47dce67da, max_idle_ns: 440795284100 ns
[    1.680890] ata2.01: NODEV after polling detection
[    1.681296] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    1.704554] ata2.00: configured for MWDMA2
[    1.727469] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    1.760553] ata2.00: disabled
[    1.784211] sr 1:0:0:0: [sr0] scsi3-mmc drive: 0x/0x caddy
[    1.805587] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.828165] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    1.828260] sr 1:0:0:0: [sr0] scsi3-mmc drive: 0x/0x caddy
[    1.849084] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    1.849146] sr 1:0:0:0: Attached scsi generic sg0 type 5
[    1.875199] scsi host0: ata_piix
[    1.899537] scsi host1: ata_piix
[    1.921869] ata3: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc080 irq 14
[    1.942924] ata4: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc088 irq 15

It seems that piix is still under asynchronous scanning
(ata_do_dev_read_id) when remove is called.

This patch add a loop for waiting to the end of ATA RESET before
processing remove.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/ata/ata_piix.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index ffbe625..10633c3d 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1764,6 +1764,16 @@ static void piix_remove_one(struct pci_dev *pdev)
 {
 	struct ata_host *host = pci_get_drvdata(pdev);
 	struct piix_host_priv *hpriv = host->private_data;
+	int i, timeout = 0;
+
+	/* wait for async probe end */
+	for (i = 0; i < host->n_ports; i++) {
+		while ((host->ports[i]->pflags & ATA_PFLAG_RESETTING) &&
+		       timeout < 100) {
+			msleep(20);
+			timeout++;
+		}
+	}
 
 	pci_write_config_dword(pdev, PIIX_IOCFG, hpriv->saved_iocfg);
 
-- 
2.7.3

