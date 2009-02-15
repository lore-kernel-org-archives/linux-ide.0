From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 01/10] ide: add flags query macros
Date: Sun, 15 Feb 2009 13:08:03 +0100
Message-ID: <1234699692-9452-2-git-send-email-petkovbb@gmail.com>
References: <1234699692-9452-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:48397 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbZBOMIS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 07:08:18 -0500
In-Reply-To: <1234699692-9452-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 include/linux/ide.h |  166 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 166 insertions(+), 0 deletions(-)

diff --git a/include/linux/ide.h b/include/linux/ide.h
index c75631c..f133062 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -497,6 +497,82 @@ enum {
 	IDE_AFLAG_NO_AUTOCLOSE		= (1 << 24),
 };
 
+#define ide_drv_drq_int(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_DRQ_INTERRUPT)
+
+#define ide_drv_no_eject(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_NO_EJECT)
+
+#define ide_drv_pre_atapi12(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_PRE_ATAPI12)
+
+#define ide_drv_tocaddr_bcd(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_TOCADDR_AS_BCD)
+
+#define ide_drv_toctracks_bcd(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_TOCTRACKS_AS_BCD)
+
+#define ide_drv_limit_nframes(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_LIMIT_NFRAMES)
+
+#define ide_drv_toc_valid(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_TOC_VALID)
+
+#define ide_drv_door_locked(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_DOOR_LOCKED)
+
+#define ide_drv_no_speed_select(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_NO_SPEED_SELECT)
+
+#define ide_drv_vertos_300_ssd(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_VERTOS_300_SSD)
+
+#define ide_drv_vertos_600_esd(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_VERTOS_600_ESD)
+
+#define ide_drv_sanyo_3cd(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_SANYO_3CD)
+
+#define ide_drv_full_caps(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_FULL_CAPS_PAGE)
+
+#define ide_drv_can_play_audio(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_PLAY_AUDIO_OK)
+
+#define ide_drv_le_speed_fields(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_LE_SPEED_FIELDS)
+
+#define ide_drv_clik(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_CLIK_DRIVE)
+
+#define ide_drv_zip(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_ZIP_DRIVE)
+
+#define ide_drv_srfp(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_SRFP)
+
+#define ide_drv_ignore_dsc(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_IGNORE_DSC)
+
+#define ide_drv_address_valid(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_ADDRESS_VALID)
+
+#define ide_drv_busy(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_BUSY)
+
+#define ide_drv_detect_bs(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_DETECT_BS)
+
+#define ide_drv_filemark(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_FILEMARK)
+
+#define ide_drv_medium_present(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_MEDIUM_PRESENT)
+
+#define ide_drv_no_autoclose(drive) \
+	((drive)->atapi_flags & IDE_AFLAG_NO_AUTOCLOSE)
+
+
 /* device flags */
 enum {
 	/* restore settings after device reset */
@@ -553,6 +629,96 @@ enum {
 	IDE_DFLAG_FORMAT_IN_PROGRESS	= (1 << 30),
 };
 
+#define ide_drv_keep_settings(drive) \
+	((drive)->dev_flags & IDE_DFLAG_KEEP_SETTINGS)
+
+#define ide_drv_using_dma(drive) \
+	((drive)->dev_flags & IDE_DFLAG_USING_DMA)
+
+#define ide_drv_unmask_irqs(drive) \
+	((drive)->dev_flags & IDE_DFLAG_UNMASK)
+
+#define ide_drv_noflush(drive) \
+	((drive)->dev_flags & IDE_DFLAG_NOFLUSH)
+
+#define ide_drv_dsc_overlap(drive) \
+	((drive)->dev_flags & IDE_DFLAG_DSC_OVERLAP)
+
+#define ide_drv_nice1(drive) \
+	((drive)->dev_flags & IDE_DFLAG_NICE1)
+
+#define ide_drv_present(drive) \
+	((drive)->dev_flags & IDE_DFLAG_PRESENT)
+
+#define ide_drv_id_read(drive) \
+	((drive)->dev_flags & IDE_DFLAG_ID_READ)
+
+#define ide_drv_noprobe(drive) \
+	((drive)->dev_flags & IDE_DFLAG_NOPROBE)
+
+#define ide_drv_removable(drive) \
+	((drive)->dev_flags & IDE_DFLAG_REMOVABLE)
+
+#define ide_drv_attach(drive) \
+	((drive)->dev_flags & IDE_DFLAG_ATTACH)
+
+#define ide_drv_forced_geom(drive) \
+	((drive)->dev_flags & IDE_DFLAG_FORCED_GEOM)
+
+#define ide_drv_no_unmask(drive) \
+	((drive)->dev_flags & IDE_DFLAG_NO_UNMASK)
+
+#define ide_drv_no_32bit_io(drive) \
+	((drive)->dev_flags & IDE_DFLAG_NO_IO_32BIT)
+
+#define ide_drv_doorlocking(drive) \
+	((drive)->dev_flags & IDE_DFLAG_DOORLOCKING)
+
+#define ide_drv_nodma(drive) \
+	((drive)->dev_flags & IDE_DFLAG_NODMA)
+
+#define ide_drv_blocked(drive) \
+	((drive)->dev_flags & IDE_DFLAG_BLOCKED)
+
+#define ide_drv_sleeping(drive) \
+	((drive)->dev_flags & IDE_DFLAG_SLEEPING)
+
+#define ide_drv_post_reset(drive) \
+	((drive)->dev_flags & IDE_DFLAG_POST_RESET)
+
+#define ide_drv_udma33_warned(drive) \
+	((drive)->dev_flags & IDE_DFLAG_UDMA33_WARNED)
+
+#define ide_drv_lba48(drive) \
+	((drive)->dev_flags & IDE_DFLAG_LBA48)
+
+#define ide_drv_wcache_enabled(drive) \
+	((drive)->dev_flags & IDE_DFLAG_WCACHE)
+
+#define ide_drv_ignore_write_err(drive) \
+	((drive)->dev_flags & IDE_DFLAG_NOWERR)
+
+#define ide_drv_dma_retry_pio(drive) \
+	((drive)->dev_flags & IDE_DFLAG_DMA_PIO_RETRY)
+
+#define ide_drv_does_lba(drive) \
+	((drive)->dev_flags & IDE_DFLAG_LBA)
+
+#define ide_drv_no_unload_feature(drive) \
+	((drive)->dev_flags & IDE_DFLAG_NO_UNLOAD)
+
+#define ide_drv_heads_parked(drive) \
+	((drive)->dev_flags & IDE_DFLAG_PARKED)
+
+#define ide_drv_media_changed(drive) \
+	((drive)->dev_flags & IDE_DFLAG_MEDIA_CHANGED)
+
+#define ide_drv_write_protected(drive) \
+	((drive)->dev_flags & IDE_DFLAG_WP)
+
+#define ide_drv_format_in_progress(drive) \
+	((drive)->dev_flags & IDE_DFLAG_FORMAT_IN_PROGRESS)
+
 struct ide_drive_s {
 	char		name[4];	/* drive name, such as "hda" */
         char            driver_req[10];	/* requests specific driver */
-- 
1.6.0.4

