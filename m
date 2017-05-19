From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] libata: Fix devres handling
Date: Sat, 20 May 2017 01:03:14 +0200
Message-ID: <20170519230314.15718-1-linus.walleij@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34129 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbdESXD2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2017 19:03:28 -0400
Received: by mail-lf0-f42.google.com with SMTP id 99so7938456lfu.1
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2017 16:03:27 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, stable@vger.kernel.org

The ATA hosts are allocated using devres with:
host = devres_alloc(ata_host_release, sz, GFP_KERNEL);
However in the ata_host_release() function the host is retrieved
using dev_get_drvdata() which is not what other devres handlers
do, instead we should probably use the passed resource.

Before this my kernel crashes badly when I fail to start a host
in ata_host_start() and need to bail out, because dev_get_drvdata()
gets the wrong-but-almost-correct pointer (so on some systems it
may by chance be the right pointer what do I know).

On ARMv4 Gemini it is not:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at ../lib/refcount.c:184 refcount_sub_and_test+0x9c/0xac
refcount_t: underflow; use-after-free.
CPU: 0 PID: 1 Comm: swapper Not tainted 4.12.0-rc1+ #657
Hardware name: Gemini (Device Tree)
[<c0010f10>] (unwind_backtrace) from [<c000d8a4>] (show_stack+0x10/0x14)
[<c000d8a4>] (show_stack) from [<c0018720>] (__warn+0xcc/0xf4)
[<c0018720>] (__warn) from [<c0018780>] (warn_slowpath_fmt+0x38/0x48)
[<c0018780>] (warn_slowpath_fmt) from [<c01fffcc>] (refcount_sub_and_test+0x9c/0xac)
[<c01fffcc>] (refcount_sub_and_test) from [<c01e8a5c>] (kobject_put+0x28/0xe0)
[<c01e8a5c>] (kobject_put) from [<c029b294>] (ata_host_release+0xb0/0x144)
[<c029b294>] (ata_host_release) from [<c027326c>] (release_nodes+0x178/0x1fc)
[<c027326c>] (release_nodes) from [<c02707e4>] (driver_probe_device+0xd0/0x2dc)
[<c02707e4>] (driver_probe_device) from [<c0270aac>] (__driver_attach+0xbc/0xc0)
[<c0270aac>] (__driver_attach) from [<c026eeac>] (bus_for_each_dev+0x70/0xa0)
[<c026eeac>] (bus_for_each_dev) from [<c026f824>] (bus_add_driver+0x178/0x200)
[<c026f824>] (bus_add_driver) from [<c0271184>] (driver_register+0x78/0xf8)
[<c0271184>] (driver_register) from [<c05b2d90>] (do_one_initcall+0xac/0x174)
[<c05b2d90>] (do_one_initcall) from [<c05b2f6c>] (kernel_init_freeable+0x114/0x1cc)
[<c05b2f6c>] (kernel_init_freeable) from [<c04beeb4>] (kernel_init+0x8/0xf4)
[<c04beeb4>] (kernel_init) from [<c000a270>] (ret_from_fork+0x14/0x24)
---[ end trace 0a4570446a019085 ]---

Then there is a second (worse) crash when it tries to iterate
to the next port. But it is all because the host pointer is
wrong.

In this case, the host should be 0xc7a3f3d0 as it was when it got
allocated but instead what dev_get_drvdata() returns is 0xc7a3f370.
Using the passed resource gives the right pointer.

Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2d83b8c75965..5487c4a29bc3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5921,7 +5921,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 
 static void ata_host_release(struct device *gendev, void *res)
 {
-	struct ata_host *host = dev_get_drvdata(gendev);
+	struct ata_host *host = res;
 	int i;
 
 	for (i = 0; i < host->n_ports; i++) {
-- 
2.9.4

