From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/3] ide: check only for CACHE FLUSH command support in ide_id_has_flush_cache()
Date: Wed, 30 Jul 2008 23:24:34 +0200
Message-ID: <200807302324.34258.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:25441 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbYG3WXG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 18:23:06 -0400
Received: by fk-out-0910.google.com with SMTP id 18so179789fkq.5
        for <linux-ide@vger.kernel.org>; Wed, 30 Jul 2008 15:23:03 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

All devices supporting CACHE FLUSH EXT command should also support
CACHE FLUSH command so it is sufficient to check only for CACHE FLUSH
in ide_id_has_flush_cache().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ide.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1451,8 +1451,8 @@ extern struct mutex ide_cfg_mtx;
 extern struct bus_type ide_bus_type;
 extern struct class *ide_port_class;
 
-/* check if CACHE FLUSH (EXT) command is supported (bits defined in ATA-6) */
-#define ide_id_has_flush_cache(id)	((id)[ATA_ID_CFS_ENABLE_2] & 0x3000)
+/* check if CACHE FLUSH command is supported (as defined in ATA-6) */
+#define ide_id_has_flush_cache(id)	((id)[ATA_ID_CFS_ENABLE_2] & 0x1000)
 
 /* some Maxtor disks have bit 13 defined incorrectly so check bit 10 too */
 #define ide_id_has_flush_cache_ext(id)	\
