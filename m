From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] ata: pata_pdc2027x: Replace mdelay with msleep
Date: Thu, 25 Jan 2018 18:45:05 +0800
Message-ID: <1516877105-13081-1-git-send-email-baijiaju1990@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:38689 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbeAYKkj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2018 05:40:39 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: b.zolnierkie@samsung.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>

After checking all possible call chains to pdc_adjust_pll and
pdc_detect_pll_input_clock,
my tool finds that these functions are never called in atomic context,
namely never in an interrupt handler or holding a spinlock.
And their caller functions pdc2027x_init_one and pdc2027x_reinit_one 
calls pci_enable_device which can sleep, and no spinlock is held when
calling pdc_adjust_pll and pdc_detect_pll_input_clock,
so it proves that pdc_adjust_pll and pdc_detect_pll_input_clock 
can call functions which can sleep.
Thus mdelay can be replaced with msleep to avoid busy wait.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/ata/pata_pdc2027x.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index ffd8d33..4e8584d 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -580,7 +580,7 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
 	ioread16(mmio_base + PDC_PLL_CTL); /* flush */
 
 	/* Wait the PLL circuit to be stable */
-	mdelay(30);
+	msleep(30);
 
 #ifdef PDC_DEBUG
 	/*
@@ -620,7 +620,7 @@ static long pdc_detect_pll_input_clock(struct ata_host *host)
 	start_time = ktime_get();
 
 	/* Let the counter run for 100 ms. */
-	mdelay(100);
+	msleep(100);
 
 	/* Read the counter values again */
 	end_count = pdc_read_counter(host);
-- 
1.7.9.5

