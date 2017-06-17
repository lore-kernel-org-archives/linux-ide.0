From: Minwoo Im <dn3108@gmail.com>
Subject: [PATCH] libata: code indent should use tabs where possible ERROR fix
Date: Sat, 17 Jun 2017 15:31:18 +0900
Message-ID: <1497681078-5019-1-git-send-email-dn3108@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33676 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdFQGbk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 17 Jun 2017 02:31:40 -0400
Received: by mail-pg0-f65.google.com with SMTP id u62so3464090pgb.0
        for <linux-ide@vger.kernel.org>; Fri, 16 Jun 2017 23:31:40 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Minwoo Im <dn3108@gmail.com>

libata-core.c, libata-transport.c, and libata.h files
have been fixed for this error.

Signed-off-by: Minwoo Im <dn3108@gmail.com>
---
 drivers/ata/libata-core.c      |    2 +-
 drivers/ata/libata-transport.c |    6 +++---
 drivers/ata/libata.h           |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e157a0e..2191d23 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4719,7 +4719,7 @@ static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
 	if (ata_pio_need_iordy(dev))
 		tf.nsect = dev->xfer_mode;
 	/* If the device has IORDY and the controller does not - turn it off */
- 	else if (ata_id_has_iordy(dev->id))
+	else if (ata_id_has_iordy(dev->id))
 		tf.nsect = 0x01;
 	else /* In the ancient relic department - skip all of this */
 		return 0;
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 19e6e53..ce92f2a 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -412,7 +412,7 @@ int ata_tlink_add(struct ata_link *link)
 	dev->release = ata_tlink_release;
 	if (ata_is_host_link(link))
 		dev_set_name(dev, "link%d", ap->print_id);
-        else
+	else
 		dev_set_name(dev, "link%d.%d", ap->print_id, link->pmp);
 
 	transport_setup_device(dev);
@@ -498,7 +498,7 @@ static int ata_show_ering(struct ata_ering_entry *ent, void *void_arg)
 
 	seconds = div_u64_rem(ent->timestamp, HZ, &rem);
 	arg->written += sprintf(arg->buf + arg->written,
-			        "[%5llu.%09lu]", seconds,
+				"[%5llu.%09lu]", seconds,
 				rem * NSEC_PER_SEC / HZ);
 	arg->written += get_ata_err_names(ent->err_mask,
 					  arg->buf + arg->written);
@@ -663,7 +663,7 @@ static int ata_tdev_add(struct ata_device *ata_dev)
 	dev->release = ata_tdev_release;
 	if (ata_is_host_link(link))
 		dev_set_name(dev, "dev%d.%d", ap->print_id,ata_dev->devno);
-        else
+	else
 		dev_set_name(dev, "dev%d.%d.0", ap->print_id, link->pmp);
 
 	transport_setup_device(dev);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 120fce0..91f51b6 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -176,7 +176,7 @@ extern int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 extern void ata_eh_finish(struct ata_port *ap);
 extern int ata_ering_map(struct ata_ering *ering,
 			 int (*map_fn)(struct ata_ering_entry *, void *),
-		  	 void *arg);
+			 void *arg);
 extern unsigned int atapi_eh_tur(struct ata_device *dev, u8 *r_sense_key);
 extern unsigned int atapi_eh_request_sense(struct ata_device *dev,
 					   u8 *sense_buf, u8 dfl_sense_key);
-- 
1.7.9.5

