From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 2/7] include: add setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in linux/setbits.h
Date: Mon, 24 Sep 2018 19:04:11 +0000
Message-ID: <1537815856-31728-3-git-send-email-clabbe@baylibre.com>
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de, airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au, benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net, galak@kernel.crashing.org, joabreu@synopsys.com, khilman@baylibre.com, maxime.ripard@bootlin.com, michal.lkml@markovi.net, mpe@ellerman.id.au, mporter@kernel.crashing.org, narmstrong@baylibre.com, nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org, wens@csie.org
Cc: cocci@systeme.lip6.fr, dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
List-Id: linux-ide@vger.kernel.org

This patch adds setbits32/clrbits32/clrsetbits32 and
setbits64/clrbits64/clrsetbits64 in linux/setbits.h header.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/linux/setbits.h | 88 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 include/linux/setbits.h

diff --git a/include/linux/setbits.h b/include/linux/setbits.h
new file mode 100644
index 000000000000..6e7e257134ae
--- /dev/null
+++ b/include/linux/setbits.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_SETBITS_H
+#define __LINUX_SETBITS_H
+
+#include <linux/io.h>
+
+#define __setbits(readfunction, writefunction, addr, set) \
+	writefunction((readfunction(addr) | (set)), addr)
+#define __clrbits(readfunction, writefunction, addr, mask) \
+	writefunction((readfunction(addr) & ~(mask)), addr)
+#define __clrsetbits(readfunction, writefunction, addr, mask, set) \
+	writefunction(((readfunction(addr) & ~(mask)) | (set)), addr)
+#define __setclrbits(readfunction, writefunction, addr, mask, set) \
+	writefunction(((readfunction(addr) | (set)) & ~(mask)), addr)
+
+#ifndef setbits_le32
+#define setbits_le32(addr, set) __setbits(readl, writel, addr, set)
+#endif
+#ifndef setbits_le32_relaxed
+#define setbits_le32_relaxed(addr, set) __setbits(readl_relaxed, writel_relaxed, \
+					       addr, set)
+#endif
+
+#ifndef clrbits_le32
+#define clrbits_le32(addr, mask) __clrbits(readl, writel, addr, mask)
+#endif
+#ifndef clrbits_le32_relaxed
+#define clrbits_le32_relaxed(addr, mask) __clrbits(readl_relaxed, writel_relaxed, \
+						addr, mask)
+#endif
+
+#ifndef clrsetbits_le32
+#define clrsetbits_le32(addr, mask, set) __clrsetbits(readl, writel, addr, mask, set)
+#endif
+#ifndef clrsetbits_le32_relaxed
+#define clrsetbits_le32_relaxed(addr, mask, set) __clrsetbits(readl_relaxed, \
+							   writel_relaxed, \
+							   addr, mask, set)
+#endif
+
+#ifndef setclrbits_le32
+#define setclrbits_le32(addr, mask, set) __setclrbits(readl, writel, addr, mask, set)
+#endif
+#ifndef setclrbits_le32_relaxed
+#define setclrbits_le32_relaxed(addr, mask, set) __setclrbits(readl_relaxed, \
+							   writel_relaxed, \
+							   addr, mask, set)
+#endif
+
+/* We cannot use CONFIG_64BIT as some x86 drivers use non-atomicwriteq() */
+#if defined(writeq) && defined(readq)
+#ifndef setbits_le64
+#define setbits_le64(addr, set) __setbits(readq, writeq, addr, set)
+#endif
+#ifndef setbits_le64_relaxed
+#define setbits_le64_relaxed(addr, set) __setbits(readq_relaxed, writeq_relaxed, \
+					       addr, set)
+#endif
+
+#ifndef clrbits_le64
+#define clrbits_le64(addr, mask) __clrbits(readq, writeq, addr, mask)
+#endif
+#ifndef clrbits_le64_relaxed
+#define clrbits_le64_relaxed(addr, mask) __clrbits(readq_relaxed, writeq_relaxed, \
+						addr, mask)
+#endif
+
+#ifndef clrsetbits_le64
+#define clrsetbits_le64(addr, mask, set) __clrsetbits(readq, writeq, addr, mask, set)
+#endif
+#ifndef clrsetbits_le64_relaxed
+#define clrsetbits_le64_relaxed(addr, mask, set) __clrsetbits(readq_relaxed, \
+							   writeq_relaxed, \
+							   addr, mask, set)
+#endif
+
+#ifndef setclrbits_le64
+#define setclrbits_le64(addr, mask, set) __setclrbits(readq, writeq, addr, mask, set)
+#endif
+#ifndef setclrbits_le64_relaxed
+#define setclrbits_le64_relaxed(addr, mask, set) __setclrbits(readq_relaxed, \
+							   writeq_relaxed, \
+							   addr, mask, set)
+#endif
+
+#endif /* writeq/readq */
+
+#endif /* __LINUX_SETBITS_H */
-- 
2.16.4
