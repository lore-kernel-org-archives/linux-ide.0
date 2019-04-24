From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 1/3] drivers: nvme: target: core: fix build break
Date: Wed, 24 Apr 2019 12:34:39 +0200
Message-ID: <1556102081-11820-2-git-send-email-info@metux.net>
References: <1556102081-11820-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556102081-11820-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Build breaks:

    drivers/nvme/target/core.c: In function 'nvmet_req_alloc_sgl':
    drivers/nvme/target/core.c:939:12: error: implicit declaration of \
function 'sgl_alloc'; did you mean 'bio_alloc'? \
[-Werror=implicit-function-declaration]
      req->sg = sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt);
                ^~~~~~~~~
                bio_alloc
    drivers/nvme/target/core.c:939:10: warning: assignment makes pointer \
from integer without a cast [-Wint-conversion]
      req->sg = sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt);
              ^
    drivers/nvme/target/core.c: In function 'nvmet_req_free_sgl':
    drivers/nvme/target/core.c:952:3: error: implicit declaration of \
function 'sgl_free'; did you mean 'ida_free'? [-Werror=implicit-function-declaration]
       sgl_free(req->sg);
       ^~~~~~~~
       ida_free

Cause:

    1. missing include to <linux/scatterlist.h>
    2. SGL_ALLOC needs to be enabled

Therefore adding the missing include, as well as Kconfig dependency.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/nvme/target/Kconfig | 1 +
 drivers/nvme/target/core.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index d94f25c..3ef0a4e 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -3,6 +3,7 @@ config NVME_TARGET
 	tristate "NVMe Target support"
 	depends on BLOCK
 	depends on CONFIGFS_FS
+	select SGL_ALLOC
 	help
 	  This enabled target side support for the NVMe protocol, that is
 	  it allows the Linux kernel to implement NVMe subsystems and
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b3e765a..08851f5 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -8,6 +8,7 @@
 #include <linux/random.h>
 #include <linux/rculist.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/scatterlist.h>
 
 #include "nvmet.h"
 
-- 
1.9.1
