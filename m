From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/13] libata-hp: prepare ata_bus_probe() for hotplug
Date: Tue, 11 Apr 2006 23:06:22 +0900
Message-ID: <1144764382509-git-send-email-htejun@gmail.com>
References: <11447643813451-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:29188 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750824AbWDKOG2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:06:28 -0400
Received: by zproxy.gmail.com with SMTP id o37so1100680nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:06:28 -0700 (PDT)
In-Reply-To: <11447643813451-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update ata_bus_probe() such that it probes only for ATA_DEV_UNKNOWN
devices, ignore errors from already existing devices and return 1 in
such cases.  This is in preparation for hotplug.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   37 +++++++++++++++++++++++++++++--------
 1 files changed, 29 insertions(+), 8 deletions(-)

57aed4a29833e54263afce342e44361642a6b8a0
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index e68a64d..a6c984f 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1469,18 +1469,24 @@ static void ata_dev_init(struct ata_port
  *	PCI/etc. bus probe sem.
  *
  *	RETURNS:
- *	Zero on success, negative errno otherwise.
+ *	Zero on success, one if any existing device failed, -ENODEV if
+ *	the port has no enabled device after probing, or any negative
+ *	errno from ->probe_reset.
  */
 static int ata_bus_probe(struct ata_port *ap)
 {
+	int existing_dev_failed = 0;
 	unsigned int classes[ATA_MAX_DEVICES];
 	int tries[ATA_MAX_DEVICES];
 	int i, rc, down_xfermask;
 	struct ata_device *dev;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		tries[i] = ATA_PROBE_MAX_TRIES;
-		ata_dev_init(ap, &ap->device[i]);
+		if (ap->device[i].class == ATA_DEV_UNKNOWN) {
+			tries[i] = ATA_PROBE_MAX_TRIES;
+			ata_dev_init(ap, &ap->device[i]);
+		} else
+			tries[i] = -1;
 	}
 
  retry:
@@ -1514,6 +1520,16 @@ static int ata_bus_probe(struct ata_port
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		dev = &ap->device[i];
 
+		/* Existing devices are EH's responsitbilities.  Just
+		 * revalidate them.
+		 */
+		if (tries[i] < 0) {
+			if (ata_dev_enabled(dev))
+				if (ata_dev_revalidate(ap, dev, 1))
+					existing_dev_failed = 1;
+			continue;
+		}
+
 		if (tries[i])
 			dev->class = classes[i];
 
@@ -1547,14 +1563,19 @@ static int ata_bus_probe(struct ata_port
 		rc = ata_set_mode(ap, &dev);
 
 	if (rc) {
-		down_xfermask = 1;
-		goto fail;
+		if (tries[dev->devno] < 0) {
+			existing_dev_failed = 1;
+		} else {
+			down_xfermask = 1;
+			goto fail;
+		}
 	}
 
+	rc = -ENODEV;
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
 		if (ata_dev_enabled(&ap->device[i]))
-			return 0;
-	return -ENODEV;
+			rc = 0;
+	return existing_dev_failed ? 1 : rc;
 
  fail:
 	switch (rc) {
@@ -5041,7 +5062,7 @@ int ata_device_add(const struct ata_prob
 		rc = ata_bus_probe(ap);
 		DPRINTK("ata%u: bus probe end\n", ap->id);
 
-		if (rc && !ap->ops->error_handler) {
+		if (rc < 0 && !ap->ops->error_handler) {
 			/* no device attached and no hotplug support */
 			ata_port_disable(ap);
 			ap->ops->port_disable(ap);
-- 
1.2.4


