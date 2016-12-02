From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] ahci-remap.h: add ahci remapping definitions
Date: Fri,  2 Dec 2016 19:31:02 +0100
Message-ID: <1480703463-17489-3-git-send-email-hch@lst.de>
References: <1480703463-17489-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:35177 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755170AbcLBSbS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 2 Dec 2016 13:31:18 -0500
In-Reply-To: <1480703463-17489-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: dan.j.williams@intel.com, linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org

From: Dan Williams <dan.j.williams@intel.com>

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[hch: split into a separate header and commit]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/ahci-remap.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 include/linux/ahci-remap.h

diff --git a/include/linux/ahci-remap.h b/include/linux/ahci-remap.h
new file mode 100644
index 0000000..883d366
--- /dev/null
+++ b/include/linux/ahci-remap.h
@@ -0,0 +1,29 @@
+#ifndef _LINUX_AHCI_REMAP_H
+#define _LINUX_AHCI_REMAP_H
+
+#include <linux/sizes.h>
+
+#define AHCI_VSCAP		0xa4
+#define AHCI_REMAP_CAP		0x800
+#define AHCI_VSCAP		0xa4
+
+/* device class code */
+#define AHCI_REMAP_N_DCC	0x880
+
+/* remap-device base relative to ahci-bar */
+#define AHCI_REMAP_N_OFFSET	SZ_16K
+#define AHCI_REMAP_N_SIZE	SZ_16K
+
+#define AHCI_MAX_REMAP		3
+
+static inline unsigned int ahci_remap_dcc(int i)
+{
+	return AHCI_REMAP_N_DCC + i * 0x80;
+}
+
+static inline unsigned int ahci_remap_base(int i)
+{
+	return AHCI_REMAP_N_OFFSET + i * AHCI_REMAP_N_SIZE;
+}
+
+#endif /* _LINUX_AHCI_REMAP_H */
-- 
2.1.4

