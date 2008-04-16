From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] au1xxx-ide: add ->{in,out}put_data methods (take 2)
Date: Thu, 17 Apr 2008 00:14:26 +0200
Message-ID: <200804170014.26848.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:54895 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568AbYDPW1w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2008 18:27:52 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2584449fgb.17
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2008 15:27:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


v2:

* Update ->{in,out}_data methods to take 'struct request *rq' argument.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
replacement patch for the one in the IDE tree

 drivers/ide/mips/au1xxx-ide.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -88,6 +88,17 @@ void auide_outsw(unsigned long port, voi
 	ctp->cur_ptr = au1xxx_ddma_get_nextptr_virt(dp);
 }
 
+static void au1xxx_input_data(ide_drive_t *drive, struct request *rq,
+			      void *buf, unsigned int len)
+{
+	auide_insw(drive->hwif->io_ports.data_addr, buf, (len + 1) / 2);
+}
+
+static void au1xxx_output_data(ide_drive_t *drive, struct request *rq,
+			       void *buf, unsigned int len)
+{
+	auide_outsw(drive->hwif->io_ports.data_addr, buf, (len + 1) / 2);
+}
 #endif
 
 static void au1xxx_set_pio_mode(ide_drive_t *drive, const u8 pio)
@@ -598,6 +609,9 @@ static int au_ide_probe(struct device *d
 	*/
 
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA	
+	hwif->input_data  = au1xxx_input_data;
+	hwif->output_data = au1xxx_output_data;
+
 	hwif->INSW                      = auide_insw;
 	hwif->OUTSW                     = auide_outsw;
 #endif
