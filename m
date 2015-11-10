From: Vishnu Pratap Singh <vishnu.ps@samsung.com>
Subject: [PATCH v2] block/floppy.c: handle blk_register_region() return value
Date: Tue, 10 Nov 2015 08:55:50 +0530
Message-ID: <1447125950-4279-1-git-send-email-vishnu.ps@samsung.com>
References: <1446812535-10567-3-git-send-email-vishnu.ps@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1446812535-10567-3-git-send-email-vishnu.ps@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, jmoyer@redhat.com, minchan@kernel.org, ngupta@vflare.org, sergey.senozhatsky.work@gmail.com, davem@davemloft.net, neilb@suse.com, ulf.hansson@linaro.org, tiwai@suse.de, hare@suse.de, ming.lei@canonical.com, jarod@redhat.com, viro@zeniv.linux.org.uk, tj@kernel.org, adrian.hunter@intel.com, jonathanh@nvidia.com, grundler@chromium.org, linux-ide@vger.kernel.org
Cc: cpgs@samsung.com, vishu13285@gmail.com, pintu.k@samsung.com, rohit.kr@samsung.com, Vishnu Pratap Singh <vishnu.ps@samsung.com>
List-Id: linux-ide@vger.kernel.org

This patch handles blk_register_region() return value.
Earlier blk_register_region() function doesn't handle error
cases, now it is added, so the callers of this function
should also handle it.

Signed-off-by: Vishnu Pratap Singh <vishnu.ps@samsung.com>
---
 - Verfied on X86 based ubuntu machine.
 - This patch depends on [PATCH 1/8] block/genhd.c: Add error handling
 - Changes v1 -> v2:
	- updated as per the Grant's review comment

 drivers/block/floppy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 331363e..459807c 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4219,8 +4219,10 @@ static int __init do_floppy_init(void)
 	if (err)
 		goto out_unreg_blkdev;
 
-	blk_register_region(MKDEV(FLOPPY_MAJOR, 0), 256, THIS_MODULE,
+	err = blk_register_region(MKDEV(FLOPPY_MAJOR, 0), 256, THIS_MODULE,
 			    floppy_find, NULL, NULL);
+	if (err)
+		goto out_driver_unregister;
 
 	for (i = 0; i < 256; i++)
 		if (ITYPE(i))
@@ -4359,6 +4361,7 @@ out_release_dma:
 		floppy_release_irq_and_dma();
 out_unreg_region:
 	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
+out_driver_unregister:
 	platform_driver_unregister(&floppy_driver);
 out_unreg_blkdev:
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
-- 
1.9.1
