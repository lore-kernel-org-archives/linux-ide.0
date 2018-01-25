From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] ata: pata_it821x: Replace mdelay with usleep_range in it821x_firmware_command
Date: Thu, 25 Jan 2018 18:32:59 +0800
Message-ID: <1516876379-12834-1-git-send-email-baijiaju1990@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:38673 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbeAYK23 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2018 05:28:29 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: b.zolnierkie@samsung.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>

After checking all possible call chains to it821x_firmware_command here,
my tool finds that it821x_firmware_command 
is never called in atomic context,
namely never in an interrupt handler or holding a spinlock.
And it821x_firmware_command calls kmalloc(GFP_KERNEL), 
so it proves again that it821x_firmware_command 
can call functions which can sleep.
Thus mdelay can be replaced with usleep_range to avoid busy wait.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/ata/pata_it821x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 7a21edf..8468b30 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -683,7 +683,7 @@ static u8 *it821x_firmware_command(struct ata_port *ap, u8 cmd, int len)
 			ioread16_rep(ap->ioaddr.data_addr, buf, len/2);
 			return (u8 *)buf;
 		}
-		mdelay(1);
+		usleep_range(500, 1000);
 	}
 	kfree(buf);
 	printk(KERN_ERR "it821x_firmware_command: timeout\n");
-- 
1.7.9.5

