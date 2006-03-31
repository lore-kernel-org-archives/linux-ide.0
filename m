From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/15] libata: improve ata_bus_probe()
Date: Sat, 1 Apr 2006 01:38:19 +0900
Message-ID: <1143823099974-git-send-email-htejun@gmail.com>
References: <1143823097579-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:11491 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751414AbWCaQic (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 11:38:32 -0500
Received: by zproxy.gmail.com with SMTP id o37so955009nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 08:38:32 -0800 (PST)
In-Reply-To: <1143823097579-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Improve ata_bus_probe() such that configuration failures are handled
better.  Each device is given ATA_PROBE_MAX_TRIES chances, but any
non-transient error (revalidation failure with -ENODEV, configuration
failure with -EINVAL...) disables the device directly.  Any IO error
results in SATA PHY speed down and ata_set_mode() failure lowers
transfer mode.  The last try always puts a device into PIO-0.

After each failure, the whole port is reset to make sure that the
controller and all the devices are in a known and stable state.  The
reset also applies SATA SPD configuration if necessary.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   65 +++++++++++++++++++++++++++++++++-----------
 include/linux/libata.h     |    3 ++
 2 files changed, 52 insertions(+), 16 deletions(-)

5e0700f0f67bd53ca50ad34b47d3fb39072a734c
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index bd9ca3b..ac2ca31 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1370,11 +1370,18 @@ err_out_nosup:
 static int ata_bus_probe(struct ata_port *ap)
 {
 	unsigned int classes[ATA_MAX_DEVICES];
-	int i, rc, found = 0;
+	int tries[ATA_MAX_DEVICES];
+	int i, rc, down_xfermask;
 	struct ata_device *dev;
 
 	ata_port_probe(ap);
 
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		tries[i] = ATA_PROBE_MAX_TRIES;
+
+ retry:
+	down_xfermask = 0;
+
 	/* reset and determine device classes */
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
 		classes[i] = ATA_DEV_UNKNOWN;
@@ -1404,21 +1411,23 @@ static int ata_bus_probe(struct ata_port
 		dev = &ap->device[i];
 		dev->class = classes[i];
 
-		if (!ata_dev_enabled(dev))
-			continue;
-
-		WARN_ON(dev->id != NULL);
-		if (ata_dev_read_id(ap, dev, &dev->class, 1, &dev->id)) {
-			dev->class = ATA_DEV_NONE;
-			continue;
+		if (!tries[i]) {
+			ata_down_xfermask_limit(ap, dev, 1);
+			ata_dev_disable(ap, dev);
 		}
 
-		if (ata_dev_configure(ap, dev, 1)) {
-			ata_dev_disable(ap, dev);
+		if (!ata_dev_enabled(dev))
 			continue;
-		}
 
-		found = 1;
+		kfree(dev->id);
+		dev->id = NULL;
+		rc = ata_dev_read_id(ap, dev, &dev->class, 1, &dev->id);
+		if (rc)
+			goto fail;
+
+		rc = ata_dev_configure(ap, dev, 1);
+		if (rc)
+			goto fail;
 	}
 
 	/* configure transfer mode */
@@ -1427,12 +1436,18 @@ static int ata_bus_probe(struct ata_port
 		 * return error code and failing device on failure as
 		 * ata_set_mode() does.
 		 */
-		if (found)
-			ap->ops->set_mode(ap);
+		for (i = 0; i < ATA_MAX_DEVICES; i++)
+			if (ata_dev_enabled(&ap->device[i])) {
+				ap->ops->set_mode(ap);
+				break;
+			}
 		rc = 0;
 	} else {
-		while (ata_set_mode(ap, &dev))
-			ata_dev_disable(ap, dev);
+		rc = ata_set_mode(ap, &dev);
+		if (rc) {
+			down_xfermask = 1;
+			goto fail;
+		}
 	}
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
@@ -1443,6 +1458,24 @@ static int ata_bus_probe(struct ata_port
 	ata_port_disable(ap);
 	ap->ops->port_disable(ap);
 	return -ENODEV;
+
+ fail:
+	switch (rc) {
+	case -EINVAL:
+	case -ENODEV:
+		tries[dev->devno] = 0;
+		break;
+	case -EIO:
+		ata_down_sata_spd_limit(ap, dev);
+		/* fall through */
+	default:
+		tries[dev->devno]--;
+		if (down_xfermask &&
+		    ata_down_xfermask_limit(ap, dev, tries[dev->devno] == 1))
+			tries[dev->devno] = 0;
+	}
+
+	goto retry;
 }
 
 /**
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d720f5b..c246a15 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -211,6 +211,9 @@ enum {
 	/* Masks for port functions */
 	ATA_PORT_PRIMARY	= (1 << 0),
 	ATA_PORT_SECONDARY	= (1 << 1),
+
+	/* how hard are we gonna try to probe/recover devices */
+	ATA_PROBE_MAX_TRIES	= 3,
 };
 
 enum hsm_task_states {
-- 
1.2.4


