From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] libata: remove unused definitions from <asm/libata-portmap.h>
Date: Thu, 22 Sep 2016 07:49:49 -0700
Message-ID: <1474555790-8716-2-git-send-email-hch@lst.de>
References: <1474555790-8716-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:33075 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757251AbcIVOtw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 22 Sep 2016 10:49:52 -0400
In-Reply-To: <1474555790-8716-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/include/asm/libata-portmap.h    | 4 ----
 arch/powerpc/include/asm/libata-portmap.h | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/ia64/include/asm/libata-portmap.h b/arch/ia64/include/asm/libata-portmap.h
index 0e00c9a..7a1f831 100644
--- a/arch/ia64/include/asm/libata-portmap.h
+++ b/arch/ia64/include/asm/libata-portmap.h
@@ -1,12 +1,8 @@
 #ifndef __ASM_IA64_LIBATA_PORTMAP_H
 #define __ASM_IA64_LIBATA_PORTMAP_H
 
-#define ATA_PRIMARY_CMD		0x1F0
-#define ATA_PRIMARY_CTL		0x3F6
 #define ATA_PRIMARY_IRQ(dev)	isa_irq_to_vector(14)
 
-#define ATA_SECONDARY_CMD	0x170
-#define ATA_SECONDARY_CTL	0x376
 #define ATA_SECONDARY_IRQ(dev)	isa_irq_to_vector(15)
 
 #endif
diff --git a/arch/powerpc/include/asm/libata-portmap.h b/arch/powerpc/include/asm/libata-portmap.h
index 4d85180..4396db5 100644
--- a/arch/powerpc/include/asm/libata-portmap.h
+++ b/arch/powerpc/include/asm/libata-portmap.h
@@ -1,12 +1,8 @@
 #ifndef __ASM_POWERPC_LIBATA_PORTMAP_H
 #define __ASM_POWERPC_LIBATA_PORTMAP_H
 
-#define ATA_PRIMARY_CMD	0x1F0
-#define ATA_PRIMARY_CTL	0x3F6
 #define ATA_PRIMARY_IRQ(dev)	pci_get_legacy_ide_irq(dev, 0)
 
-#define ATA_SECONDARY_CMD	0x170
-#define ATA_SECONDARY_CTL	0x376
 #define ATA_SECONDARY_IRQ(dev)	pci_get_legacy_ide_irq(dev, 1)
 
 #endif
-- 
2.1.4

