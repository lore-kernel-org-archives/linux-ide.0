From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ide_tape: convert jiffies with jiffies_to_msecs
Date: Tue,  3 Mar 2015 05:23:48 -0500
Message-ID: <1425378228-6095-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: linux-ide@vger.kernel.org

Use jiffies_to_msecs for converting jiffies as it handles all of the corner
cases reliably and also helps readability. The printk format is fixed up 
as jiffies_to_msecs returns unsigned int not unsigned long.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Note that this patch will give a checkpatch warning due to "quoted string 
split across lines" but thats not related to this change - not sure if this
should be fixed - looks intentional to me.

This was only compile tested with x86_64_defconfig + CONFIG_IDE=m,
CONFIG_BLK_DEV_IDETAPE=m

Patch is against 4.0-rc1 (localversion-next is -next-20150303)

 drivers/ide/ide-tape.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 1793aea..d9ce376 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1793,11 +1793,11 @@ static void idetape_setup(ide_drive_t *drive, idetape_tape_t *tape, int minor)
 	tape->best_dsc_rw_freq = clamp_t(unsigned long, t, IDETAPE_DSC_RW_MIN,
 					 IDETAPE_DSC_RW_MAX);
 	printk(KERN_INFO "ide-tape: %s <-> %s: %dKBps, %d*%dkB buffer, "
-		"%lums tDSC%s\n",
+		"%dms tDSC%s\n",
 		drive->name, tape->name, *(u16 *)&tape->caps[14],
 		(*(u16 *)&tape->caps[16] * 512) / tape->buffer_size,
 		tape->buffer_size / 1024,
-		tape->best_dsc_rw_freq * 1000 / HZ,
+		jiffies_to_msecs(tape->best_dsc_rw_freq),
 		(drive->dev_flags & IDE_DFLAG_USING_DMA) ? ", DMA" : "");
 
 	ide_proc_register_driver(drive, tape->driver);
-- 
1.7.10.4
