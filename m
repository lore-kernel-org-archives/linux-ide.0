From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/2 v2] ide: pdc202xx_new: Replace mdelay with usleep_range in detect_pll_input_clock
Date: Wed, 11 Apr 2018 16:41:27 +0800
Message-ID: <1523436087-4485-1-git-send-email-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, frankt@promise.com, andre@linux-ide.org, sergei.shtylyov@cogentembedded.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-ide@vger.kernel.org

detect_pll_input_clock() is never called in atomic context.

detect_pll_input_clock() is only called by init_chipset_pdcnew(), which 
is set as ".init_chipset" in struct ide_port_info.
This function is not called in atomic context.

Despite never getting called from atomic context, detect_pll_input_clock()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Correct wrong usage of usleep_range() in v1.
  Thank Sergei for pointing it out.
---
 drivers/ide/pdc202xx_new.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/pdc202xx_new.c b/drivers/ide/pdc202xx_new.c
index b33646b..6afa66d 100644
--- a/drivers/ide/pdc202xx_new.c
+++ b/drivers/ide/pdc202xx_new.c
@@ -258,7 +258,7 @@ static long detect_pll_input_clock(unsigned long dma_base)
 	outb(scr1 | 0x40, dma_base + 0x03);
 
 	/* Let the counter run for 10 ms. */
-	mdelay(10);
+	usleep_range(10000, 11000);
 
 	end_count = read_counter(dma_base);
 	end_time = ktime_get();
-- 
1.9.1
