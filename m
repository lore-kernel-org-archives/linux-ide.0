From: "dongbo (E)" <dongbo4@huawei.com>
Subject: [PATCH] Fix compile warning with ATA_DEBUG enabled
Date: Fri, 26 Jan 2018 11:21:49 +0800
Message-ID: <5be87d13-f9a0-5b12-ced4-cec5d6394da1@huawei.com>
References: <1516936551-20986-1-git-send-email-zhangshaokun@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:4704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751174AbeAZDWK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 25 Jan 2018 22:22:10 -0500
In-Reply-To: <1516936551-20986-1-git-send-email-zhangshaokun@hisilicon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>

From: Dong Bo <dongbo4@huawei.com>

This fixs the following comile warnings with ATA_DEBUG enabled,
which detected by Linaro GCC 5.2-2015.11:

In file included from ./include/linux/printk.h:7:0,
                 from ./include/linux/kernel.h:14,
                 from ./include/asm-generic/bug.h:16,
                 from ./arch/arm64/include/asm/bug.h:37,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/mmdebug.h:5,
                 from ./include/linux/gfp.h:5,
                 from ./include/linux/slab.h:15,
                 from drivers/ata/libata-scsi.c:36:
drivers/ata/libata-scsi.c: In function 'ata_scsi_dump_cdb':
./include/linux/kern_levels.h:5:18: warning: format '%d' expects
argument of type 'int', but argument 6 has type 'u64 {aka long
 long unsigned int}' [-Wformat=]
 #define KERN_SOH "\001"  /* ASCII Start Of Header */
                  ^
./include/linux/kern_levels.h:11:18: note: in expansion of macro
'KERN_SOH'
 #define KERN_ERR KERN_SOH "3" /* error conditions */
                  ^
./include/linux/libata.h:65:38: note: in expansion of macro 'KERN_ERR'
 #define DPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt,
				__func__, ## args)
                                      ^
drivers/ata/libata-scsi.c:4284:2: note: in expansion of macro 'DPRINTK'
  DPRINTK("CDB (%u:%d,%d,%d) %9ph\n",
  ^

Signed-off-by: Dong Bo <dongbo4@huawei.com>
---
 drivers/ata/libata-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 66be961..214ecb6 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4282,7 +4282,7 @@ static inline void ata_scsi_dump_cdb(struct ata_port *ap,
 #ifdef ATA_DEBUG
 	struct scsi_device *scsidev = cmd->device;
 -	DPRINTK("CDB (%u:%d,%d,%d) %9ph\n",
+	DPRINTK("CDB (%u:%u,%u,%lld) %9ph\n",
 		ap->print_id,
 		scsidev->channel, scsidev->id, scsidev->lun,
 		cmd->cmnd);
-- 
1.9.1


.


