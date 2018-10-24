From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 2/7] include: add setbits_leXX/clrbits_leXX/clrsetbits_leXX in linux/setbits.h
Date: Wed, 24 Oct 2018 07:35:48 +0000
Message-ID: <1540366553-18541-3-git-send-email-clabbe@baylibre.com>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
Sender: netdev-owner@vger.kernel.org
To: Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de, airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au, benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net, galak@kernel.crashing.org, joabreu@synopsys.com, khilman@baylibre.com, matthias.bgg@gmail.com, maxime.ripard@bootlin.com, michal.lkml@markovi.net, mpe@ellerman.id.au, mporter@kernel.crashing.org, narmstrong@baylibre.com, nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org, wens@csie.org
Cc: cocci@systeme.lip6.fr, dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
List-Id: linux-ide@vger.kernel.org

This patch adds setbits_le32/clrbits_le32/clrsetbits_le32 and
setbits_le64/clrbits_le64/clrsetbits_le64 in linux/setbits.h header.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/linux/setbits.h | 84 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 include/linux/setbits.h

diff --git a/include/linux/setbits.h b/include/linux/setbits.h
new file mode 100644
index 000000000000..c82faf8d7fe4
--- /dev/null
+++ b/include/linux/setbits.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_SETBITS_H
+#define __LINUX_SETBITS_H
+
+#include <linux/io.h>
+
+#define __setbits(rfn, wfn, addr, set) wfn((rfn(addr) | (set)), addr)
+#define __clrbits(rfn, wfn, addr, mask) wfn((rfn(addr) & ~(mask)), addr)
+#define __clrsetbits(rfn, wfn, addr, mask, set) wfn(((rfn(addr) & ~(mask)) | (set)), addr)
+#define __setclrbits(rfn, wfn, addr, mask, set) wfn(((rfn(addr) | (set)) & ~(mask)), addr)
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
2.18.1
