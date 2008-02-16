From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 05/12] cmd640: init hwif->{io_ports,irq} explicitly
Date: Sat, 16 Feb 2008 17:39:25 +0100
Message-ID: <20080216163925.10174.64230.sendpatchset@localhost.localdomain>
References: <20080216163856.10174.72546.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:5864 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757934AbYBPQYw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 11:24:52 -0500
Received: by an-out-0708.google.com with SMTP id d31so238245and.103
        for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 08:24:51 -0800 (PST)
In-Reply-To: <20080216163856.10174.72546.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Do explicit port setup instead of depending on init_ide_data().

This way hwif->io_ports[] and hwif->irq are always correctly set
regardless of CONFIG_PCI / CONFIG_BLK_DEV_IDEPCI.

[ Remember to not break "idex=noprobe" parameter. ]

While at it fix printk().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cmd640.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

Index: b/drivers/ide/pci/cmd640.c
===================================================================
--- a/drivers/ide/pci/cmd640.c
+++ b/drivers/ide/pci/cmd640.c
@@ -712,8 +712,9 @@ static int __init cmd640x_init(void)
 	int second_port_cmd640 = 0;
 	const char *bus_type, *port2;
 	unsigned int index;
-	u8 b, cfr;
+	u8 b, cfr, oldnoprobe;
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
+	hw_regs_t hw[2];
 
 	if (cmd640_vlb && probe_for_cmd640_vlb()) {
 		bus_type = "VLB";
@@ -752,12 +753,25 @@ static int __init cmd640x_init(void)
 		return 0;
 	}
 
+	memset(&hw, 0, sizeof(hw));
+
+	ide_std_init_ports(&hw[0], 0x1f0, 0x3f6);
+	hw[0].irq = 14;
+
+	ide_std_init_ports(&hw[1], 0x170, 0x376);
+	hw[1].irq = 15;
+
+	printk(KERN_INFO "cmd640: buggy cmd640%c interface on %s, config=0x%02x"
+			 "\n", 'a' + cmd640_chip_version - 1, bus_type, cfr);
+
 	/*
 	 * Initialize data for primary port
 	 */
 	setup_device_ptrs ();
-	printk("%s: buggy cmd640%c interface on %s, config=0x%02x\n",
-	       cmd_hwif0->name, 'a' + cmd640_chip_version - 1, bus_type, cfr);
+
+	oldnoprobe = cmd_hwif0->noprobe;
+	ide_init_port_hw(cmd_hwif0, &hw[0]);
+	cmd_hwif0->noprobe = oldnoprobe;
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 	cmd_hwif0->set_pio_mode = &cmd640_set_pio_mode;
 #endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
@@ -809,6 +823,9 @@ static int __init cmd640x_init(void)
 	 * Initialize data for secondary cmd640 port, if enabled
 	 */
 	if (second_port_cmd640) {
+		oldnoprobe = cmd_hwif1->noprobe;
+		ide_init_port_hw(cmd_hwif1, &hw[1]);
+		cmd_hwif1->noprobe = oldnoprobe;
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 		cmd_hwif1->set_pio_mode = &cmd640_set_pio_mode;
 #endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
