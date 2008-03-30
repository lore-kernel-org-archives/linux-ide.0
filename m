From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/6] au1xxx-ide: add ->{in,out}put_data methods
Date: Sun, 30 Mar 2008 21:42:06 +0200
Message-ID: <200803302142.07004.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:31351 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbYC3Tau (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Mar 2008 15:30:50 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1476447fgb.17
        for <linux-ide@vger.kernel.org>; Sun, 30 Mar 2008 12:30:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/mips/au1xxx-ide.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -93,6 +93,15 @@ void auide_outsw(unsigned long port, voi
 	ctp->cur_ptr = au1xxx_ddma_get_nextptr_virt(dp);
 }
 
+static void au1xxx_input_data(ide_drive_t *drive, void *buf, unsigned int len)
+{
+	auide_insw(drive->hwif->io_ports.data_addr, buf, (len + 1) / 2);
+}
+
+static void au1xxx_output_data(ide_drive_t *drive, void *buf, unsigned int len)
+{
+	auide_outsw(drive->hwif->io_ports.data_addr, buf, (len + 1) / 2);
+}
 #endif
 
 static void au1xxx_set_pio_mode(ide_drive_t *drive, const u8 pio)
@@ -602,6 +611,9 @@ static int au_ide_probe(struct device *d
 	*/
 
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA	
+	hwif->input_data  = au1xxx_input_data;
+	hwif->output_data = au1xxx_output_data;
+
 	hwif->INSW                      = auide_insw;
 	hwif->OUTSW                     = auide_outsw;
 #endif
