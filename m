From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH 2/3] mips/ide: clean up / minimize dcache flushes
Date: Sun, 28 Feb 2010 16:35:40 +0100
Message-ID: <1267371341-16684-3-git-send-email-sebastian@breakpoint.cc>
References: <1267371341-16684-1-git-send-email-sebastian@breakpoint.cc>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:40463 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968709Ab0B1Pft (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Feb 2010 10:35:49 -0500
In-Reply-To: <1267371341-16684-1-git-send-email-sebastian@breakpoint.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>

This patch is based on Thiemo's work where he tried to minimize the
dcache flushes and clean up the API a bit. The patch was posted in
Debian #466977.
The patch in detail:
- instead of an active flush the relevant pages just get a dirty dcache
  bit set
- the dirty bit is only set if we have userspace mapping. So we don't
  set it for kernel internal requests which never see userland.
- since writes to the device are "read only" there is no need set the
  dirty bit.

Signed-off-by: Thiemo Seufer <ths@networkno.de>
Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/mips/include/asm/cacheflush.h       |    1 -
 arch/mips/include/asm/mach-generic/ide.h |   70 +++++++-----------------------
 arch/mips/mm/c-r3k.c                     |    5 --
 arch/mips/mm/c-r4k.c                     |    1 -
 arch/mips/mm/c-tx39.c                    |    7 ---
 arch/mips/mm/cache.c                     |    2 -
 6 files changed, 16 insertions(+), 70 deletions(-)

diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index 40bb9fd..d95a79c 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -92,7 +92,6 @@ extern void copy_from_user_page(struct vm_area_struct *vma,
 
 extern void (*flush_cache_sigtramp)(unsigned long addr);
 extern void (*flush_icache_all)(void);
-extern void (*local_flush_data_cache_page)(void * addr);
 extern void (*flush_data_cache_page)(unsigned long addr);
 
 /*
diff --git a/arch/mips/include/asm/mach-generic/ide.h b/arch/mips/include/asm/mach-generic/ide.h
index e80e47f..9360586 100644
--- a/arch/mips/include/asm/mach-generic/ide.h
+++ b/arch/mips/include/asm/mach-generic/ide.h
@@ -20,107 +20,69 @@
 #include <asm/processor.h>
 
 /* MIPS port and memory-mapped I/O string operations.  */
-static inline void __ide_flush_prologue(void)
+static inline void __ide_set_pages_dirty(const void *addr, unsigned long size)
 {
-#ifdef CONFIG_SMP
-	if (cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc)
-		preempt_disable();
-#endif
-}
+	unsigned long end = (unsigned long)addr + size;
 
-static inline void __ide_flush_epilogue(void)
-{
-#ifdef CONFIG_SMP
-	if (cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc)
-		preempt_enable();
-#endif
-}
+	if (!(cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc))
+		return;
 
-static inline void __ide_flush_dcache_range(unsigned long addr, unsigned long size)
-{
-	if (cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc) {
-		unsigned long end = addr + size;
+	while ((unsigned long)addr < end) {
+		struct page *p = virt_to_page(addr);
+		struct address_space *mapping = page_mapping(p);
 
-		while (addr < end) {
-			local_flush_data_cache_page((void *)addr);
-			addr += PAGE_SIZE;
-		}
+		if (mapping && mapping_mapped(mapping))
+			SetPageDcacheDirty(p);
+		addr += PAGE_SIZE;
 	}
 }
 
-/*
- * insw() and gang might be called with interrupts disabled, so we can't
- * send IPIs for flushing due to the potencial of deadlocks, see the comment
- * above smp_call_function() in arch/mips/kernel/smp.c.  We work around the
- * problem by disabling preemption so we know we actually perform the flush
- * on the processor that actually has the lines to be flushed which hopefully
- * is even better for performance anyway.
- */
 static inline void __ide_insw(unsigned long port, void *addr,
 	unsigned int count)
 {
-	__ide_flush_prologue();
 	insw(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 2);
-	__ide_flush_epilogue();
+	__ide_set_pages_dirty(addr, count * 2);
 }
 
-static inline void __ide_insl(unsigned long port, void *addr, unsigned int count)
+static inline void __ide_insl(unsigned long port, void *addr,
+	unsigned int count)
 {
-	__ide_flush_prologue();
 	insl(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 4);
-	__ide_flush_epilogue();
+	__ide_set_pages_dirty(addr, count * 4);
 }
 
 static inline void __ide_outsw(unsigned long port, const void *addr,
 	unsigned long count)
 {
-	__ide_flush_prologue();
 	outsw(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 2);
-	__ide_flush_epilogue();
 }
 
 static inline void __ide_outsl(unsigned long port, const void *addr,
 	unsigned long count)
 {
-	__ide_flush_prologue();
 	outsl(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 4);
-	__ide_flush_epilogue();
 }
 
 static inline void __ide_mm_insw(void __iomem *port, void *addr, u32 count)
 {
-	__ide_flush_prologue();
 	readsw(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 2);
-	__ide_flush_epilogue();
+	__ide_set_pages_dirty(addr, count * 2);
 }
 
 static inline void __ide_mm_insl(void __iomem *port, void *addr, u32 count)
 {
-	__ide_flush_prologue();
 	readsl(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 4);
-	__ide_flush_epilogue();
+	__ide_set_pages_dirty(addr, count * 4);
 }
 
 static inline void __ide_mm_outsw(void __iomem *port, void *addr, u32 count)
 {
-	__ide_flush_prologue();
 	writesw(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 2);
-	__ide_flush_epilogue();
 }
 
 static inline void __ide_mm_outsl(void __iomem * port, void *addr, u32 count)
 {
-	__ide_flush_prologue();
 	writesl(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 4);
-	__ide_flush_epilogue();
 }
 
 /* ide_insw calls insw, not __ide_insw.  Why? */
diff --git a/arch/mips/mm/c-r3k.c b/arch/mips/mm/c-r3k.c
index 54e5f7b..d841170 100644
--- a/arch/mips/mm/c-r3k.c
+++ b/arch/mips/mm/c-r3k.c
@@ -267,10 +267,6 @@ static void r3k_flush_cache_page(struct vm_area_struct *vma,
 		r3k_flush_icache_range(kaddr, kaddr + PAGE_SIZE);
 }
 
-static void local_r3k_flush_data_cache_page(void *addr)
-{
-}
-
 static void r3k_flush_data_cache_page(unsigned long addr)
 {
 }
@@ -324,7 +320,6 @@ void __cpuinit r3k_cache_init(void)
 	local_flush_icache_range = r3k_flush_icache_range;
 
 	flush_cache_sigtramp = r3k_flush_cache_sigtramp;
-	local_flush_data_cache_page = local_r3k_flush_data_cache_page;
 	flush_data_cache_page = r3k_flush_data_cache_page;
 
 	_dma_cache_wback_inv = r3k_dma_cache_wback_inv;
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 6721ee2..a103185 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1403,7 +1403,6 @@ void __cpuinit r4k_cache_init(void)
 
 	flush_cache_sigtramp	= r4k_flush_cache_sigtramp;
 	flush_icache_all	= r4k_flush_icache_all;
-	local_flush_data_cache_page	= local_r4k_flush_data_cache_page;
 	flush_data_cache_page	= r4k_flush_data_cache_page;
 	flush_icache_range	= r4k_flush_icache_range;
 	local_flush_icache_range	= local_r4k_flush_icache_range;
diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
index 6515b44..f98bfad 100644
--- a/arch/mips/mm/c-tx39.c
+++ b/arch/mips/mm/c-tx39.c
@@ -221,11 +221,6 @@ static void tx39_flush_cache_page(struct vm_area_struct *vma, unsigned long page
 		tx39_blast_icache_page_indexed(page);
 }
 
-static void local_tx39_flush_data_cache_page(void * addr)
-{
-	tx39_blast_dcache_page((unsigned long)addr);
-}
-
 static void tx39_flush_data_cache_page(unsigned long addr)
 {
 	tx39_blast_dcache_page(addr);
@@ -366,7 +361,6 @@ void __cpuinit tx39_cache_init(void)
 		local_flush_icache_range = (void *) tx39h_flush_icache_all;
 
 		flush_cache_sigtramp	= (void *) tx39h_flush_icache_all;
-		local_flush_data_cache_page	= (void *) tx39h_flush_icache_all;
 		flush_data_cache_page	= (void *) tx39h_flush_icache_all;
 
 		_dma_cache_wback_inv	= tx39h_dma_cache_wback_inv;
@@ -395,7 +389,6 @@ void __cpuinit tx39_cache_init(void)
 		local_flush_icache_range = tx39_flush_icache_range;
 
 		flush_cache_sigtramp = tx39_flush_cache_sigtramp;
-		local_flush_data_cache_page = local_tx39_flush_data_cache_page;
 		flush_data_cache_page = tx39_flush_data_cache_page;
 
 		_dma_cache_wback_inv = tx39_dma_cache_wback_inv;
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index e716caf..cb5bf1a 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -37,11 +37,9 @@ void (*__flush_cache_vunmap)(void);
 
 /* MIPS specific cache operations */
 void (*flush_cache_sigtramp)(unsigned long addr);
-void (*local_flush_data_cache_page)(void * addr);
 void (*flush_data_cache_page)(unsigned long addr);
 void (*flush_icache_all)(void);
 
-EXPORT_SYMBOL_GPL(local_flush_data_cache_page);
 EXPORT_SYMBOL(flush_data_cache_page);
 
 #ifdef CONFIG_DMA_NONCOHERENT
-- 
1.6.6

