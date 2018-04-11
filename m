From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/2] ide: pdc202xx_new: Replace mdelay with msleep in init_chipset_pdcnew
Date: Wed, 11 Apr 2018 15:52:56 +0800
Message-ID: <1523433176-3954-1-git-send-email-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, frankt@promise.com, andre@linux-ide.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-ide@vger.kernel.org

init_chipset_pdcnew() is never called in atomic context.
This function is only set as ".init_chipset" in struct ide_port_info.

Despite never getting called from atomic context, init_chipset_pdcnew()
calls mdelay() to busily wait.
This is not necessary and can be replaced with msleep() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/ide/pdc202xx_new.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/pdc202xx_new.c b/drivers/ide/pdc202xx_new.c
index b33646b..a654491 100644
--- a/drivers/ide/pdc202xx_new.c
+++ b/drivers/ide/pdc202xx_new.c
@@ -403,7 +403,7 @@ static int init_chipset_pdcnew(struct pci_dev *dev)
 	outb(pll_ctl1, sec_dma_base + 0x03);
 
 	/* Wait the PLL circuit to be stable */
-	mdelay(30);
+	msleep(30);
 
 #ifdef DEBUG
 	/*
-- 
1.9.1
