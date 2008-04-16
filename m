From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] scc_pata: add ->{in,out}put_data methods (take 2)
Date: Thu, 17 Apr 2008 00:09:39 +0200
Message-ID: <200804170009.39454.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:8526 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385AbYDPW1x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2008 18:27:53 -0400
Received: by mu-out-0910.google.com with SMTP id w9so1112404mue.5
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2008 15:27:48 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Kou Ishizaki <kou.ishizaki@toshiba.co.jp>, Akira Iguchi <akira2.iguchi@toshiba.co.jp>, Sergei Shtylyov <sshtylyov@ru.mvista.com>


v2:

* Update ->{in,out}_data methods to take 'struct request *rq' argument
  (thanks to Stephen Rothwell for catching it).

There should be no functional changes caused by this patch.

Cc: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Cc: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
replacement patch for the one in the IDE tree

 drivers/ide/pci/scc_pata.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -612,6 +612,38 @@ static int __devinit init_setup_scc(stru
 	return rc;
 }
 
+static void scc_input_data(ide_drive_t *drive, struct request *rq,
+			   void *buf, unsigned int len)
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
+static void scc_output_data(ide_drive_t *drive,  struct request *rq,
+			    void *buf, unsigned int len)
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
@@ -626,6 +658,9 @@ static void __devinit init_mmio_iops_scc
 
 	ide_set_hwifdata(hwif, ports);
 
+	hwif->input_data  = scc_input_data;
+	hwif->output_data = scc_output_data;
+
 	hwif->INB = scc_ide_inb;
 	hwif->INW = scc_ide_inw;
 	hwif->INSW = scc_ide_insw;
