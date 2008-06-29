From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 11/16] ide: add per-device flags
Date: Sun, 29 Jun 2008 12:59:14 +0200
Message-ID: <1214737159-1078-12-git-send-email-petkovbb@gmail.com>
References: <1214737159-1078-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:56961 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755384AbYF2K7P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jun 2008 06:59:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so564626fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 29 Jun 2008 03:59:14 -0700 (PDT)
In-Reply-To: <1214737159-1078-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Push device flags up into ide_drive_t.

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 include/linux/ide.h |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/include/linux/ide.h b/include/linux/ide.h
index 57e99e9..0e52c3c 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -286,6 +286,64 @@ struct ide_acpi_drive_link;
 struct ide_acpi_hwif_link;
 #endif
 
+/* device flags */
+enum {
+	IDE_FLAG_DRQ_INTERRUPT		= (1 << 0),
+	IDE_FLAG_MEDIA_CHANGED		= (1 << 1),
+
+	/* ide-cd */
+	/* Drive cannot lock the door. */
+	IDE_FLAG_NO_DOORLOCK		= (1 << 2),
+	/* Drive cannot eject the disc. */
+	IDE_FLAG_NO_EJECT		= (1 << 3),
+	/* Drive is a pre ATAPI 1.2 drive. */
+	IDE_FLAG_PRE_ATAPI12		= (1 << 4),
+	/* TOC addresses are in BCD. */
+	IDE_FLAG_TOCADDR_AS_BCD		= (1 << 5),
+	/* TOC track numbers are in BCD. */
+	IDE_FLAG_TOCTRACKS_AS_BCD	= (1 << 6),
+	/*
+	 * Drive does not provide data in multiples of SECTOR_SIZE
+	 * when more than one interrupt is needed.
+	 */
+	IDE_FLAG_LIMIT_NFRAMES		= (1 << 7),
+	/* Seeking in progress. */
+	IDE_FLAG_SEEKING		= (1 << 8),
+	/* Saved TOC information is current. */
+	IDE_FLAG_TOC_VALID		= (1 << 9),
+	/* We think that the drive door is locked. */
+	IDE_FLAG_DOOR_LOCKED		= (1 << 10),
+	/* SET_CD_SPEED command is unsupported. */
+	IDE_FLAG_NO_SPEED_SELECT	= (1 << 11),
+	IDE_FLAG_VERTOS_300_SSD		= (1 << 12),
+	IDE_FLAG_VERTOS_600_ESD		= (1 << 13),
+	IDE_FLAG_SANYO_3CD		= (1 << 14),
+	IDE_FLAG_FULL_CAPS_PAGE		= (1 << 15),
+	IDE_FLAG_PLAY_AUDIO_OK		= (1 << 16),
+	IDE_FLAG_LE_SPEED_FIELDS	= (1 << 17),
+
+	/* ide-floppy */
+	/* Format in progress */
+	IDE_FLAG_FORMAT_IN_PROGRESS	= (1 << 18),
+	/* Avoid commands not supported in Clik drive */
+	IDE_FLAG_CLIK_DRIVE		= (1 << 19),
+	/* Requires BH algorithm for packets */
+	IDE_FLAG_ZIP_DRIVE		= (1 << 20),
+
+	/* ide-tape */
+	IDE_FLAG_IGNORE_DSC		= (1 << 21),
+	/* 0 When the tape position is unknown */
+	IDE_FLAG_ADDRESS_VALID		= (1 <<	22),
+	/* Device already opened */
+	IDE_FLAG_BUSY			= (1 << 23),
+	/* Attempt to auto-detect the current user block size */
+	IDE_FLAG_DETECT_BS		= (1 << 24),
+	/* Currently on a filemark */
+	IDE_FLAG_FILEMARK		= (1 << 25),
+	/* 0 = no tape is loaded, so we don't rewind after ejecting */
+	IDE_FLAG_MEDIUM_PRESENT		= (1 << 26)
+};
+
 struct ide_drive_s {
 	char		name[4];	/* drive name, such as "hda" */
         char            driver_req[10];	/* requests specific driver */
@@ -382,6 +440,8 @@ struct ide_drive_s {
 
 	/* callback for packet commands */
 	void (*pc_callback)(struct ide_drive_s *);
+
+	unsigned long dev_flags;
 };
 
 typedef struct ide_drive_s ide_drive_t;
-- 
1.5.5.4

