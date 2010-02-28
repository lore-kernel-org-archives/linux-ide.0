From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH 1/3] mips/ide: flush dcache also if icache does not snoop dcache
Date: Sun, 28 Feb 2010 16:35:39 +0100
Message-ID: <1267371341-16684-2-git-send-email-sebastian@breakpoint.cc>
References: <1267371341-16684-1-git-send-email-sebastian@breakpoint.cc>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:40464 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968713Ab0B1Pft (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Feb 2010 10:35:49 -0500
In-Reply-To: <1267371341-16684-1-git-send-email-sebastian@breakpoint.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>

If this is not done then the new just read data which remains in dcache
will not make it into icache on time. Thus the CPU loads invalid data
and executes crap. The result is that the user is not able to execute
anything from its IDE based media while reading plain data is still
working well.
This problem has been reported as Debian #404951.

Cc: stable@kernel.org
Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/mips/include/asm/mach-generic/ide.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-generic/ide.h b/arch/mips/include/asm/mach-generic/ide.h
index 9c93a5b..e80e47f 100644
--- a/arch/mips/include/asm/mach-generic/ide.h
+++ b/arch/mips/include/asm/mach-generic/ide.h
@@ -23,7 +23,7 @@
 static inline void __ide_flush_prologue(void)
 {
 #ifdef CONFIG_SMP
-	if (cpu_has_dc_aliases)
+	if (cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc)
 		preempt_disable();
 #endif
 }
@@ -31,14 +31,14 @@ static inline void __ide_flush_prologue(void)
 static inline void __ide_flush_epilogue(void)
 {
 #ifdef CONFIG_SMP
-	if (cpu_has_dc_aliases)
+	if (cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc)
 		preempt_enable();
 #endif
 }
 
 static inline void __ide_flush_dcache_range(unsigned long addr, unsigned long size)
 {
-	if (cpu_has_dc_aliases) {
+	if (cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc) {
 		unsigned long end = addr + size;
 
 		while (addr < end) {
-- 
1.6.6

