From: Tina Ruchandani <ruchandani.tina@gmail.com>
Subject: [PATCH v3] ata: Use 64-bit timekeeping
Date: Tue, 27 Jan 2015 15:49:48 +0530
Message-ID: <20150127101948.GA5656@tinar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:38745 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbbA0KTy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jan 2015 05:19:54 -0500
Received: by mail-pa0-f53.google.com with SMTP id kx10so17645663pab.12
        for <linux-ide@vger.kernel.org>; Tue, 27 Jan 2015 02:19:53 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: arnd@arndb.de, tj@kernel.org

Function pdc_detect_pll_input_clock uses 'struct timeval'
to measure start and end times, used to compute the pll_clock value.
'struct timeval' on 32-bit systems will have its tv_sec field
overflow in year 2038 and beyond. This patch uses 'ktime_t'
(which uses 64 bits for seconds) for start and end times instead.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tina Ruchandani <ruchandani.tina@gmail.com>
---
Changes in v3:
	- Switch back to usec_elapsed being a 'long'.
Changes in v2:
	- Switch from timespec64 to ktime_t - more efficient.
	- Use ktime_us_delta to get usec_elapsed, it is more
	  efficient than manual computation of usecs from timespec64.
---
 drivers/ata/pata_pdc2027x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 4d06a5c..dca8251 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -28,6 +28,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/ktime.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
@@ -605,7 +606,7 @@ static long pdc_detect_pll_input_clock(struct ata_host *host)
 	void __iomem *mmio_base = host->iomap[PDC_MMIO_BAR];
 	u32 scr;
 	long start_count, end_count;
-	struct timeval start_time, end_time;
+	ktime_t start_time, end_time;
 	long pll_clock, usec_elapsed;
 
 	/* Start the test mode */
@@ -616,14 +617,14 @@ static long pdc_detect_pll_input_clock(struct ata_host *host)
 
 	/* Read current counter value */
 	start_count = pdc_read_counter(host);
-	do_gettimeofday(&start_time);
+	start_time = ktime_get();
 
 	/* Let the counter run for 100 ms. */
 	mdelay(100);
 
 	/* Read the counter values again */
 	end_count = pdc_read_counter(host);
-	do_gettimeofday(&end_time);
+	end_time = ktime_get();
 
 	/* Stop the test mode */
 	scr = ioread32(mmio_base + PDC_SYS_CTL);
@@ -632,8 +633,7 @@ static long pdc_detect_pll_input_clock(struct ata_host *host)
 	ioread32(mmio_base + PDC_SYS_CTL); /* flush */
 
 	/* calculate the input clock in Hz */
-	usec_elapsed = (end_time.tv_sec - start_time.tv_sec) * 1000000 +
-		(end_time.tv_usec - start_time.tv_usec);
+	usec_elapsed = (long) ktime_us_delta(end_time, start_time);
 
 	pll_clock = ((start_count - end_count) & 0x3fffffff) / 100 *
 		(100000000 / usec_elapsed);
-- 
2.2.0.rc0.207.ga3a616c

