From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 05/16] ide: remove pc->callback member from ide_atapi_pc
Date: Sun, 29 Jun 2008 12:59:08 +0200
Message-ID: <1214737159-1078-6-git-send-email-petkovbb@gmail.com>
References: <1214737159-1078-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:55331 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756161AbYF2K7Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jun 2008 06:59:16 -0400
Received: by fg-out-1718.google.com with SMTP id 19so564676fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 29 Jun 2008 03:59:15 -0700 (PDT)
In-Reply-To: <1214737159-1078-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 include/linux/ide.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/linux/ide.h b/include/linux/ide.h
index be1e5c9..57e99e9 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -632,8 +632,6 @@ struct ide_atapi_pc {
 	 */
 	u8 pc_buf[256];
 
-	void (*callback)(ide_drive_t *);
-
 	/* idetape only */
 	struct idetape_bh *bh;
 	char *b_data;
-- 
1.5.5.4

