From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/11] ide: remove drive->init_speed zeroing
Date: Sat, 4 Aug 2007 22:08:31 +0200
Message-ID: <200708042208.32014.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:12431 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760381AbXHDUQJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Aug 2007 16:16:09 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1508336mue
        for <linux-ide@vger.kernel.org>; Sat, 04 Aug 2007 13:16:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Several host drivers used to reset drive->init_speed in their ->ide_dma_check
implementations which resulted in incorrect init speed being reported to the
user, fix it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/alim15x3.c     |    2 --
 drivers/ide/pci/atiixp.c       |    2 --
 drivers/ide/pci/cs5535.c       |    2 --
 drivers/ide/pci/hpt34x.c       |    2 --
 drivers/ide/pci/hpt366.c       |    2 --
 drivers/ide/pci/pdc202xx_new.c |    2 --
 drivers/ide/pci/pdc202xx_old.c |    2 --
 drivers/ide/pci/piix.c         |    2 --
 drivers/ide/pci/serverworks.c  |    2 --
 drivers/ide/pci/sis5513.c      |    2 --
 drivers/ide/pci/slc90e66.c     |    2 --
 11 files changed, 22 deletions(-)

Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -446,8 +446,6 @@ static void ali_set_dma_mode(ide_drive_t
 
 static int ali15x3_config_drive_for_dma(ide_drive_t *drive)
 {
-	drive->init_speed = 0;
-
 	if (ide_tune_dma(drive))
 		return 0;
 
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -168,8 +168,6 @@ static void atiixp_set_dma_mode(ide_driv
 
 static int atiixp_dma_check(ide_drive_t *drive)
 {
-	drive->init_speed = 0;
-
 	if (ide_tune_dma(drive))
 		return 0;
 
Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -159,8 +159,6 @@ static void cs5535_set_pio_mode(ide_driv
 
 static int cs5535_dma_check(ide_drive_t *drive)
 {
-	drive->init_speed = 0;
-
 	if (ide_tune_dma(drive))
 		return 0;
 
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -82,8 +82,6 @@ static void hpt34x_set_pio_mode(ide_driv
 
 static int hpt34x_config_drive_xfer_rate (ide_drive_t *drive)
 {
-	drive->init_speed = 0;
-
 	if (ide_tune_dma(drive))
 		return -1;
 
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -693,8 +693,6 @@ static void hpt3xx_maskproc(ide_drive_t 
 
 static int hpt366_config_drive_xfer_rate(ide_drive_t *drive)
 {
-	drive->init_speed = 0;
-
 	if (ide_tune_dma(drive))
 		return 0;
 
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -225,8 +225,6 @@ static u8 pdcnew_cable_detect(ide_hwif_t
 
 static int pdcnew_config_drive_xfer_rate(ide_drive_t *drive)
 {
-	drive->init_speed = 0;
-
 	if (ide_tune_dma(drive))
 		return 0;
 
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -181,8 +181,6 @@ static void pdc_old_disable_66MHz_clock(
 
 static int pdc202xx_config_drive_xfer_rate (ide_drive_t *drive)
 {
-	drive->init_speed = 0;
-
 	if (ide_tune_dma(drive))
 		return 0;
 
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -264,8 +264,6 @@ static void piix_set_dma_mode(ide_drive_
  
 static int piix_config_drive_xfer_rate (ide_drive_t *drive)
 {
-	drive->init_speed = 0;
-
 	if (ide_tune_dma(drive))
 		return 0;
 
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -197,8 +197,6 @@ static void svwks_set_dma_mode(ide_drive
 
 static int svwks_config_drive_xfer_rate (ide_drive_t *drive)
 {
-	drive->init_speed = 0;
-
 	if (ide_tune_dma(drive))
 		return 0;
 
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -603,8 +603,6 @@ static void sis_set_dma_mode(ide_drive_t
 
 static int sis5513_config_xfer_rate(ide_drive_t *drive)
 {
-	drive->init_speed = 0;
-
 	if (ide_tune_dma(drive))
 		return 0;
 
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -132,8 +132,6 @@ static void slc90e66_set_dma_mode(ide_dr
 
 static int slc90e66_config_drive_xfer_rate (ide_drive_t *drive)
 {
-	drive->init_speed = 0;
-
 	if (ide_tune_dma(drive))
 		return 0;
 
