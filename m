From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/6] scc_pata: add ->{in,out}put_data methods
Date: Sun, 30 Mar 2008 21:41:05 +0200
Message-ID: <200803302141.06106.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:29365 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbYC3Tau (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Mar 2008 15:30:50 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1476440fgb.17
        for <linux-ide@vger.kernel.org>; Sun, 30 Mar 2008 12:30:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/scc_pata.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -574,6 +574,36 @@ static int __devinit init_setup_scc(stru
 	return ide_setup_pci_device(dev, d);
 }
 
+static void scc_input_data(ide_drive_t *drive, void *buf, unsigned int len)
+{
+	unsigned long data_addr = drive->hwif->io_ports.data_addr;
+
+	len++;
+
+	if (drive->io_32bit) {
+		scc_ide_insl(data_addr, buf, len / 4);
+
+		if ((len & 3) >= 2)
+			scc_ide_insw(data_addr, (u8 *)buf + (len & ~3), 1);
+	} else
+		scc_ide_insw(data_addr, buf, len / 2);
+}
+
+static void scc_output_data(ide_drive_t *drive, void *buf, unsigned int len)
+{
+	unsigned long data_addr = drive->hwif->io_ports.data_addr;
+
+	len++;
+
+	if (drive->io_32bit) {
+		scc_ide_outsl(data_addr, buf, len / 4);
+
+		if ((len & 3) >= 2)
+			scc_ide_outsw(data_addr, (u8 *)buf + (len & ~3), 1);
+	} else
+		scc_ide_outsw(data_addr, buf, len / 2);
+}
+
 /**
  *	init_mmio_iops_scc	-	set up the iops for MMIO
  *	@hwif: interface to set up
@@ -589,6 +619,9 @@ static void __devinit init_mmio_iops_scc
 
 	ide_set_hwifdata(hwif, ports);
 
+	hwif->input_data  = scc_input_data;
+	hwif->output_data = scc_output_data;
+
 	hwif->INB = scc_ide_inb;
 	hwif->INW = scc_ide_inw;
 	hwif->INSW = scc_ide_insw;
