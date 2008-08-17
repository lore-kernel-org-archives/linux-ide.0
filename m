From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 2/5] ide: add drive->debug_mask switch
Date: Sun, 17 Aug 2008 19:23:43 +0200
Message-ID: <1218993826-4571-3-git-send-email-petkovbb@gmail.com>
References: <1218993826-4571-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:33166 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbYHQRXr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Aug 2008 13:23:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1456292fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 17 Aug 2008 10:23:45 -0700 (PDT)
In-Reply-To: <1218993826-4571-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej@gollum.tnic, Zolnierkiewicz@gollum.tnic, bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Add a debugging on/off switch for controlling driver debugging
messages dynamically.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 include/linux/ide.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/ide.h b/include/linux/ide.h
index 6b5d425..c161840 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -543,6 +543,9 @@ struct ide_drive_s {
 
 	int		lun;		/* logical unit */
 	int		crc_count;	/* crc counter to reduce drive speed */
+
+	unsigned long	debug_mask;	/* debugging levels switch */
+
 #ifdef CONFIG_BLK_DEV_IDEACPI
 	struct ide_acpi_drive_link *acpidata;
 #endif
-- 
1.5.5.4

