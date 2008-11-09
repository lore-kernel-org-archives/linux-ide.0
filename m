From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 05/11] ide: remove inline tags from ide-probe.c
Date: Sun, 09 Nov 2008 17:22:47 +0100
Message-ID: <20081109162247.18999.87287.sendpatchset@localhost.localdomain>
References: <20081109162219.18999.74912.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:40170 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756116AbYKIQYr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 11:24:47 -0500
In-Reply-To: <20081109162219.18999.74912.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove inline tags from ide-probe.c

Let the compiler handle it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -110,8 +110,8 @@ static void ide_disk_init_mult_count(ide
  *	read and parse the results. This function is run with
  *	interrupts disabled. 
  */
- 
-static inline void do_identify (ide_drive_t *drive, u8 cmd)
+
+static void do_identify(ide_drive_t *drive, u8 cmd)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	u16 *id = drive->id;
@@ -553,8 +553,8 @@ static void enable_nest (ide_drive_t *dr
  *			1  device was found
  *			   (note: IDE_DFLAG_PRESENT might still be not set)
  */
- 
-static inline u8 probe_for_drive (ide_drive_t *drive)
+
+static u8 probe_for_drive(ide_drive_t *drive)
 {
 	char *m;
 
