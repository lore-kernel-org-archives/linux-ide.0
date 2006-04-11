From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/13] libata-hp: call ata_dev_init() from ata_bus_probe()
Date: Tue, 11 Apr 2006 23:06:21 +0900
Message-ID: <11447643811206-git-send-email-htejun@gmail.com>
References: <11447643813451-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.230]:43444 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750826AbWDKOG2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:06:28 -0400
Received: by wproxy.gmail.com with SMTP id 69so1067515wri
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:06:28 -0700 (PDT)
In-Reply-To: <11447643813451-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Call ata_dev_init() before actual probing instead of during host
initialization.  This is in preparation of hotplug.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

bc205de9459b473c8fef86b3f4e6e356aa9186fd
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 3406f3d..09e82f9 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1466,7 +1466,6 @@ static void ata_dev_init(struct ata_port
  *	RETURNS:
  *	Zero on success, negative errno otherwise.
  */
-
 static int ata_bus_probe(struct ata_port *ap)
 {
 	unsigned int classes[ATA_MAX_DEVICES];
@@ -1476,8 +1475,10 @@ static int ata_bus_probe(struct ata_port
 
 	ata_port_probe(ap);
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		tries[i] = ATA_PROBE_MAX_TRIES;
+		ata_dev_init(ap, &ap->device[i]);
+	}
 
  retry:
 	down_xfermask = 0;
@@ -4882,11 +4883,8 @@ static void ata_host_init(struct ata_por
 	INIT_WORK(&ap->port_task, NULL, NULL);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
-		dev->devno = i;
-		ata_dev_init(ap, dev);
-	}
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		ap->device[i].devno = i;
 
 #ifdef ATA_IRQ_TRAP
 	ap->stats.unhandled_irq = 1;
-- 
1.2.4


