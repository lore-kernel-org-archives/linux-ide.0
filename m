From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/13] libata-hp: move device enable/disable out of ata_bus_probe()
Date: Tue, 11 Apr 2006 23:06:21 +0900
Message-ID: <11447643812867-git-send-email-htejun@gmail.com>
References: <11447643813451-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:52105 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751014AbWDKOG3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:06:29 -0400
Received: by zproxy.gmail.com with SMTP id o37so1100710nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:06:28 -0700 (PDT)
In-Reply-To: <11447643813451-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

For drivers support hot/warm plugging, the controller should stay
enabled whether devices are attached to it or not.  Move
ata_port_probe() and disable calls out of ata_bus_probe() and disable
only if the driver doesn't implement new style ->error_handler, which
is responsible for hotplug.

While at it, kill the FIXME about controllers with no device attached.
Hotplug is coming and all drivers should support it in not so distant
future.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   19 ++++++-------------
 1 files changed, 6 insertions(+), 13 deletions(-)

84a5e767247a9a0047e4b485fbd9de7582d9b283
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 45ef1e2..e68a64d 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1478,8 +1478,6 @@ static int ata_bus_probe(struct ata_port
 	int i, rc, down_xfermask;
 	struct ata_device *dev;
 
-	ata_port_probe(ap);
-
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		tries[i] = ATA_PROBE_MAX_TRIES;
 		ata_dev_init(ap, &ap->device[i]);
@@ -1556,10 +1554,6 @@ static int ata_bus_probe(struct ata_port
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
 		if (ata_dev_enabled(&ap->device[i]))
 			return 0;
-
-	/* no device present, disable port */
-	ata_port_disable(ap);
-	ap->ops->port_disable(ap);
 	return -ENODEV;
 
  fail:
@@ -5033,6 +5027,8 @@ int ata_device_add(const struct ata_prob
 
 		ap = host_set->ports[i];
 
+		ata_port_probe(ap);
+
 		/* init ap->orig_sata_spd_limit to boot value */
 		if ((ap->flags & ATA_FLAG_SATA) && ap->ops->scr_read) {
 			u32 spd;
@@ -5045,13 +5041,10 @@ int ata_device_add(const struct ata_prob
 		rc = ata_bus_probe(ap);
 		DPRINTK("ata%u: bus probe end\n", ap->id);
 
-		if (rc) {
-			/* FIXME: do something useful here?
-			 * Current libata behavior will
-			 * tear down everything when
-			 * the module is removed
-			 * or the h/w is unplugged.
-			 */
+		if (rc && !ap->ops->error_handler) {
+			/* no device attached and no hotplug support */
+			ata_port_disable(ap);
+			ap->ops->port_disable(ap);
 		}
 
 		rc = scsi_add_host(ap->host, dev);
-- 
1.2.4


