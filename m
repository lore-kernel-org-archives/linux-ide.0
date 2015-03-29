From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 40/86] ide/generic: use uapi/linux/pci_ids.h directly
Date: Sun, 29 Mar 2015 15:40:45 +0200
Message-ID: <1427635734-24786-41-git-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427635734-24786-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Header moved from linux/pci_ids.h to uapi/linux/pci_ids.h,
use the new header directly so we can drop
the wrapper in include/linux/pci_ids.h.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/ide/ide-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
index 54d7c46..4edb39f 100644
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -11,7 +11,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/ide.h>
-#include <linux/pci_ids.h>
+#include <uapi/linux/pci_ids.h>
 
 /* FIXME: convert arm and m32r to use ide_platform host driver */
 #ifdef CONFIG_ARM
-- 
MST
