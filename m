From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] libata: remove <asm-generic/libata-portmap.h>
Date: Thu, 22 Sep 2016 07:49:50 -0700
Message-ID: <1474555790-8716-3-git-send-email-hch@lst.de>
References: <1474555790-8716-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:33088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757251AbcIVOtx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 22 Sep 2016 10:49:53 -0400
In-Reply-To: <1474555790-8716-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

asm-generic is only intended for architecture defaults, and we can simply
kill it off by moving the two defintions directly to <linux/libata.h>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/libata-portmap.h | 7 -------
 include/linux/libata.h               | 3 ++-
 2 files changed, 2 insertions(+), 8 deletions(-)
 delete mode 100644 include/asm-generic/libata-portmap.h

diff --git a/include/asm-generic/libata-portmap.h b/include/asm-generic/libata-portmap.h
deleted file mode 100644
index cf14f2f..0000000
--- a/include/asm-generic/libata-portmap.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __ASM_GENERIC_LIBATA_PORTMAP_H
-#define __ASM_GENERIC_LIBATA_PORTMAP_H
-
-#define ATA_PRIMARY_IRQ(dev)	14
-#define ATA_SECONDARY_IRQ(dev)	15
-
-#endif
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e37d4f9..616eef4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -46,7 +46,8 @@
 #ifdef CONFIG_ATA_NONSTANDARD
 #include <asm/libata-portmap.h>
 #else
-#include <asm-generic/libata-portmap.h>
+#define ATA_PRIMARY_IRQ(dev)	14
+#define ATA_SECONDARY_IRQ(dev)	15
 #endif
 
 /*
-- 
2.1.4

