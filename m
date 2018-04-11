From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] ide: hpt366: Replace mdelay with usleep_range in init_chipset_hpt366
Date: Wed, 11 Apr 2018 15:50:43 +0800
Message-ID: <1523433043-3811-1-git-send-email-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, source@mvista.com, alan@lxorguk.ukuu.org.uk
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-ide@vger.kernel.org

init_chipset_hpt366() is never called in atomic context.

init_chipset_hpt366() is set as ".init_chipset" in struct ide_port_info.
This function is not called in atomic context.

Despite never getting called from atomic context, init_chipset_hpt366()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/ide/hpt366.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
index 4b5dc01..4045559 100644
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -984,7 +984,7 @@ static int init_chipset_hpt366(struct pci_dev *dev)
 			for (temp = i = 0; i < 128; i++) {
 				pci_read_config_word(dev, 0x78, &f_cnt);
 				temp += f_cnt & 0x1ff;
-				mdelay(1);
+				usleep_range(1000, 2000);
 			}
 			f_cnt = temp / 128;
 		} else
-- 
1.9.1
