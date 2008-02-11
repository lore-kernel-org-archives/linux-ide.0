From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 1/4] ide: add generic packet command representation ide_atapi_pc
Date: Mon, 11 Feb 2008 09:34:37 +0100
Message-ID: <1202718880-1793-2-git-send-email-petkovbb@gmail.com>
References: <1202718880-1793-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.240]:53522 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbYBKIfF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 03:35:05 -0500
Received: by an-out-0708.google.com with SMTP id d31so1125520and.103
        for <linux-ide@vger.kernel.org>; Mon, 11 Feb 2008 00:35:03 -0800 (PST)
In-Reply-To: <1202718880-1793-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

This new struct unifies ide{-floppy,-tape,-scsi}'s view of a packet command. For now,
it represents the common denominator between the three drivers while adding driver-
specific members at the end of the struct which will be merged/simplified into the
generic ATAPI handling code in later steps, or removed completely.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 include/linux/ide.h |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/include/linux/ide.h b/include/linux/ide.h
index e4eddd4..aae98d7 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -629,6 +629,53 @@ typedef struct ide_settings_s {
 
 int ide_add_setting(ide_drive_t *, const char *, int, int, int, int, int, int, void *, ide_procset_t *set);
 
+struct ide_atapi_pc {
+	/* actual packet bytes */
+	u8 c[12];
+	/* incremented on each retry */
+	int retries;
+	int error;
+
+	/* bytes to transfer */
+	int req_xfer;
+	/* bytes actually transferred */
+	int xferred;
+
+	/* data buffer */
+	u8 *buf;
+	/* current buffer position */
+	u8 *cur_pos;
+	int buf_size;
+	/* missing/available data on the current buffer */
+	int b_count;
+
+	/* the corresponding request */
+	struct request *rq;
+
+	unsigned long flags;
+
+	/*
+	 * those are more or less driver-specific and some of them are subject
+	 * to change/removal later.
+	 */
+	u8 pc_buf[256];
+	void (*idefloppy_callback) (ide_drive_t *);
+	ide_startstop_t (*idetape_callback) (ide_drive_t *);
+
+	/* idetape only */
+	struct idetape_bh *bh;
+	char *b_data;
+
+	/* idescsi only for now */
+	struct scatterlist *sg;
+	unsigned int sg_cnt;
+
+	struct scsi_cmnd *scsi_cmd;
+	void (*done) (struct scsi_cmnd *);
+
+	unsigned long timeout;
+};
+
 /*
  * /proc/ide interface
  */
-- 
1.5.3.7

