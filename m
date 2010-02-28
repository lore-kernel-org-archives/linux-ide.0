From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH 3/3] ide: move dcache flushing to generic ide code
Date: Sun, 28 Feb 2010 16:35:41 +0100
Message-ID: <1267371341-16684-4-git-send-email-sebastian@breakpoint.cc>
References: <1267371341-16684-1-git-send-email-sebastian@breakpoint.cc>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:40462 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968708Ab0B1Pft (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Feb 2010 10:35:49 -0500
In-Reply-To: <1267371341-16684-1-git-send-email-sebastian@breakpoint.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>

the pio callbacks are called with different kind of buffers. It could be
a straight kernel addr, kernel stack or a kmaped highmem page.
Some of this break the virt_to_page() assumptions.
This patch moves the dcache flush from architecture code into generic
ide code. ide_pio_bytes() is the only place where user pages might be
written as far as I can see.
The dcache flush is avoided in two cases:
- data which is written to the device (i.e. they are comming from the
  userland)
- pages without a mapping. Those requests should be issued by
  vfs and not go to the userland.

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/mips/include/asm/mach-generic/ide.h |   21 ---------------------
 arch/sparc/include/asm/ide.h             |   14 --------------
 drivers/ide/ide-taskfile.c               |    7 +++++++
 3 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/arch/mips/include/asm/mach-generic/ide.h b/arch/mips/include/asm/mach-generic/ide.h
index 9360586..7370845 100644
--- a/arch/mips/include/asm/mach-generic/ide.h
+++ b/arch/mips/include/asm/mach-generic/ide.h
@@ -20,35 +20,16 @@
 #include <asm/processor.h>
 
 /* MIPS port and memory-mapped I/O string operations.  */
-static inline void __ide_set_pages_dirty(const void *addr, unsigned long size)
-{
-	unsigned long end = (unsigned long)addr + size;
-
-	if (!(cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc))
-		return;
-
-	while ((unsigned long)addr < end) {
-		struct page *p = virt_to_page(addr);
-		struct address_space *mapping = page_mapping(p);
-
-		if (mapping && mapping_mapped(mapping))
-			SetPageDcacheDirty(p);
-		addr += PAGE_SIZE;
-	}
-}
-
 static inline void __ide_insw(unsigned long port, void *addr,
 	unsigned int count)
 {
 	insw(port, addr, count);
-	__ide_set_pages_dirty(addr, count * 2);
 }
 
 static inline void __ide_insl(unsigned long port, void *addr,
 	unsigned int count)
 {
 	insl(port, addr, count);
-	__ide_set_pages_dirty(addr, count * 4);
 }
 
 static inline void __ide_outsw(unsigned long port, const void *addr,
@@ -66,13 +47,11 @@ static inline void __ide_outsl(unsigned long port, const void *addr,
 static inline void __ide_mm_insw(void __iomem *port, void *addr, u32 count)
 {
 	readsw(port, addr, count);
-	__ide_set_pages_dirty(addr, count * 2);
 }
 
 static inline void __ide_mm_insl(void __iomem *port, void *addr, u32 count)
 {
 	readsl(port, addr, count);
-	__ide_set_pages_dirty(addr, count * 4);
 }
 
 static inline void __ide_mm_outsw(void __iomem *port, void *addr, u32 count)
diff --git a/arch/sparc/include/asm/ide.h b/arch/sparc/include/asm/ide.h
index b7af3d6..c1037ca 100644
--- a/arch/sparc/include/asm/ide.h
+++ b/arch/sparc/include/asm/ide.h
@@ -34,9 +34,6 @@
 
 static inline void __ide_insw(void __iomem *port, void *dst, u32 count)
 {
-#if defined(CONFIG_SPARC64) && defined(DCACHE_ALIASING_POSSIBLE)
-	unsigned long end = (unsigned long)dst + (count << 1);
-#endif
 	u16 *ps = dst;
 	u32 *pi;
 
@@ -56,17 +53,10 @@ static inline void __ide_insw(void __iomem *port, void *dst, u32 count)
 	ps = (u16 *)pi;
 	if(count)
 		*ps++ = __raw_readw(port);
-
-#if defined(CONFIG_SPARC64) && defined(DCACHE_ALIASING_POSSIBLE)
-	__flush_dcache_range((unsigned long)dst, end);
-#endif
 }
 
 static inline void __ide_outsw(void __iomem *port, const void *src, u32 count)
 {
-#if defined(CONFIG_SPARC64) && defined(DCACHE_ALIASING_POSSIBLE)
-	unsigned long end = (unsigned long)src + (count << 1);
-#endif
 	const u16 *ps = src;
 	const u32 *pi;
 
@@ -86,10 +76,6 @@ static inline void __ide_outsw(void __iomem *port, const void *src, u32 count)
 	ps = (const u16 *)pi;
 	if(count)
 		__raw_writew(*ps, port);
-
-#if defined(CONFIG_SPARC64) && defined(DCACHE_ALIASING_POSSIBLE)
-	__flush_dcache_range((unsigned long)src, end);
-#endif
 }
 
 #endif /* __KERNEL__ */
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index cc8633c..95a9922 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -273,6 +273,13 @@ void ide_pio_bytes(ide_drive_t *drive, struct ide_cmd *cmd,
 		if (page_is_high)
 			local_irq_restore(flags);
 
+		if (!write) {
+			struct address_space *mapping = page_mapping(page);
+
+			if (mapping && mapping_mapped(mapping))
+				flush_dcache_page(page);
+		}
+
 		len -= nr_bytes;
 	}
 }
-- 
1.6.6

