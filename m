From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/5] libata: implement ata_wait_register()
Date: Tue, 11 Apr 2006 22:22:29 +0900
Message-ID: <11447617492974-git-send-email-htejun@gmail.com>
References: <11447617493149-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.226]:23934 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750822AbWDKNWc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:22:32 -0400
Received: by wproxy.gmail.com with SMTP id i11so921434wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:22:31 -0700 (PDT)
In-Reply-To: <11447617493149-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

As waiting for some register bits to change seems to be a common
operation shared by some controllers, implement helper function
ata_wait_register().  This function also takes care of register write
flushing.

Note that the condition is inverted, the wait is over when the masked
value does NOT match @val.  As we're waiting for bits to change, this
test is more powerful and allows the function to be used in more
places.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   47 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    3 +++
 2 files changed, 50 insertions(+), 0 deletions(-)

f91be25a88af45c5dc9c7162ebe84f0a08ca191a
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index ed089a0..56e1cc6 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5029,6 +5029,52 @@ int ata_ratelimit(void)
 	return rc;
 }
 
+/**
+ *	ata_wait_register - wait until register value changes
+ *	@reg: IO-mapped register
+ *	@mask: Mask to apply to read register value
+ *	@val: Wait condition
+ *	@interval_msec: polling interval in milliseconds
+ *	@timeout_msec: timeout in milliseconds
+ *
+ *	Waiting for some bits of register to change is a common
+ *	operation for ATA controllers.  This function reads 32bit LE
+ *	IO-mapped register @reg and tests for the following condition.
+ *
+ *	(*@reg & mask) != val
+ *
+ *	If the condition is met, it returns; otherwise, the process is
+ *	repeated after @interval_msec until timeout.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	The final register value.
+ */
+u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
+		      unsigned long interval_msec,
+		      unsigned long timeout_msec)
+{
+	unsigned long timeout;
+	u32 tmp;
+
+	tmp = ioread32(reg);
+
+	/* Calculate timeout _after_ the first read to make sure
+	 * preceding writes reach the controller before starting to
+	 * eat away the timeout.
+	 */
+	timeout = jiffies + (timeout_msec * HZ) / 1000;
+
+	while ((tmp & mask) == val && time_before(jiffies, timeout)) {
+		msleep(interval_msec);
+		tmp = ioread32(reg);
+	}
+
+	return tmp;
+}
+
 /*
  * libata is essentially a library of internal helper functions for
  * low-level ATA host controller drivers.  As such, the API/ABI is
@@ -5079,6 +5125,7 @@ EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_pair);
 EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_ratelimit);
+EXPORT_SYMBOL_GPL(ata_wait_register);
 EXPORT_SYMBOL_GPL(ata_busy_sleep);
 EXPORT_SYMBOL_GPL(ata_port_queue_task);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6954852..bf2f334 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -540,6 +540,9 @@ extern unsigned int ata_busy_sleep(struc
 				   unsigned long timeout);
 extern void ata_port_queue_task(struct ata_port *ap, void (*fn)(void *),
 				void *data, unsigned long delay);
+extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
+			     unsigned long interval_msec,
+			     unsigned long timeout_msec);
 
 /*
  * Default driver ops implementations
-- 
1.2.4


