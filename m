From: Daniel Walker <danielwa@cisco.com>
Subject: [PATCH 2/2] drivers: libata-core: Use usleep_range() instead of msleep() for short sleeps (<20 ms)
Date: Thu,  7 Jan 2016 21:18:52 -0800
Message-ID: <1452230332-14926-2-git-send-email-danielwa@cisco.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Anil Veliyankara Madam <aveliyan@cisco.com>, xe-kernel@external.cisco.com, Shikha Jain <shikjain@cisco.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Anil Veliyankara Madam <aveliyan@cisco.com>

Since msleep() may sleep longer than intended time for values less
than 20ms, this patch allows the use of usleep_range for waits less
that 20ms. usleep_range is a finer precision implementation of
msleep and is designed to be a drop-in replacement for udelay
where a precise sleep/busy-wait is unnecessary.

More details can be found at http://lkml.org/lkml/2007/8/3/250
and in Documentation/timers/timers-howto.txt.

This change has been done to improve the performace in PIO6 mode
which is used by viking flash.

Cc: xe-kernel@external.cisco.com
Signed-off-by: Anil Veliyankara Madam <aveliyan@cisco.com>
Signed-off-by: Shikha Jain <shikjain@cisco.com>
---
 drivers/ata/libata-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b79cb10..3abf0ea 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -50,6 +50,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/timer.h>
+#include <linux/time.h>
 #include <linux/interrupt.h>
 #include <linux/completion.h>
 #include <linux/suspend.h>
@@ -6697,7 +6698,12 @@ void ata_msleep(struct ata_port *ap, unsigned int msecs)
 	if (owns_eh)
 		ata_eh_release(ap);
 
-	msleep(msecs);
+	if (msecs < 20) {
+		unsigned long usecs = msecs * USEC_PER_MSEC;
+		usleep_range(usecs, usecs + 50);
+	} else {
+		msleep(msecs);
+	}
 
 	if (owns_eh)
 		ata_eh_acquire(ap);
-- 
2.1.4
