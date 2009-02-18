From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-cd: document capacity hack
Date: Wed, 18 Feb 2009 20:18:51 +0100
Message-ID: <200902182018.52195.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:40666 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbZBRTVb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Feb 2009 14:21:31 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-cd: document capacity hack

Just copy the comment from drivers/scsi/sr.c::sr_done()
(from which the capacity hack has been originated).

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -189,6 +189,14 @@ static void cdrom_analyze_sense_data(ide
 			bio_sectors = max(bio_sectors(failed_command->bio), 4U);
 			sector &= ~(bio_sectors - 1);
 
+			/*
+			 * The SCSI specification allows for the value
+			 * returned by READ CAPACITY to be up to 75 2K
+			 * sectors past the last readable block.
+			 * Therefore, if we hit a medium error within the
+			 * last 75 2K sectors, we decrease the saved size
+			 * value.
+			 */
 			if (sector < get_capacity(info->disk) &&
 			    drive->probed_capacity - sector < 4 * 75)
 				set_capacity(info->disk, sector);
