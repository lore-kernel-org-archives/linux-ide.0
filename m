From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/2] ide: ->quirkproc method cannot be marked __devinit
Date: Sat, 2 Aug 2008 19:04:17 +0200
Message-ID: <200808021904.17798.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:8606 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbYHBRJg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Aug 2008 13:09:36 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1266121fkq.5
        for <linux-ide@vger.kernel.org>; Sat, 02 Aug 2008 10:09:36 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Now that we have warm-plug support ->quirkproc method no longer
can be be marked __devinit.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/it821x.c  |    2 +-
 drivers/ide/pci/siimage.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -442,7 +442,7 @@ static u8 __devinit it821x_cable_detect(
  *	final tuning that is needed, or fixups to work around bugs.
  */
 
-static void __devinit it821x_quirkproc(ide_drive_t *drive)
+static void it821x_quirkproc(ide_drive_t *drive)
 {
 	struct it821x_dev *itdev = ide_get_hwifdata(drive->hwif);
 	u16 *id = drive->id;
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -640,7 +640,7 @@ static int is_dev_seagate_sata(ide_drive
  *	that can occur before we know what drives are present.
  */
 
-static void __devinit sil_quirkproc(ide_drive_t *drive)
+static void sil_quirkproc(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
 
