From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-h8300: add ->{in,out}put_data methods (take 2)
Date: Thu, 17 Apr 2008 00:17:48 +0200
Message-ID: <200804170017.48201.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:58378 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963AbYDPW1x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2008 18:27:53 -0400
Received: by nf-out-0910.google.com with SMTP id g13so830983nfb.21
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2008 15:27:52 -0700 (PDT)
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

 drivers/ide/h8300/ide-h8300.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Index: b/drivers/ide/h8300/ide-h8300.c
===================================================================
--- a/drivers/ide/h8300/ide-h8300.c
+++ b/drivers/ide/h8300/ide-h8300.c
@@ -56,6 +56,18 @@ static void mm_insw(unsigned long addr, 
 		*bp = bswap(*(volatile u16 *)addr);
 }
 
+static void h8300_input_data(ide_drive_t *drive, struct request *rq,
+			     void *buf, unsigned int len)
+{
+	mm_insw(drive->hwif->io_ports.data_addr, buf, (len + 1) / 2);
+}
+
+static void h8300_output_data(ide_drive_t *drive, struct request *rq,
+			      void *buf, unsigned int len)
+{
+	mm_outsw(drive->hwif->io_ports.data_addr, buf, (len + 1) / 2);
+}
+
 #define H8300_IDE_GAP (2)
 
 static inline void hw_setup(hw_regs_t *hw)
@@ -74,6 +86,9 @@ static inline void hwif_setup(ide_hwif_t
 {
 	default_hwif_iops(hwif);
 
+	hwif->input_data  = h8300_input_data;
+	hwif->output_data = h8300_output_data;
+
 	hwif->OUTW  = mm_outw;
 	hwif->OUTSW = mm_outsw;
 	hwif->INW   = mm_inw;
