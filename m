From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/9] [libata] some function renaming
Date: Thu, 10 Aug 2006 17:16:29 +0900
Message-ID: <11551977892094-git-send-email-htejun@gmail.com>
References: <11551977882917-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:27438 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751454AbWHJIQe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 04:16:34 -0400
Received: by py-out-1112.google.com with SMTP id x66so716684pye
        for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 01:16:34 -0700 (PDT)
In-Reply-To: <11551977882917-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

s/ata_host_add/ata_port_add/
s/ata_host_init/ata_port_init/

libata naming got stuck in the middle of a Great Renaming:

	ata_host -> ata_port
	ata_host_set -> ata_host

To eliminate confusion, let's just give up for now, and simply ensure
that things are internally consistent.

Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

996139f1ce50c56c5e66f86b6aba17ff5ea00b86
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index eb9de07..3aa477a 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5309,7 +5309,7 @@ static void ata_port_init_shost(struct a
 }
 
 /**
- *	ata_host_add - Attach low-level ATA driver to system
+ *	ata_port_add - Attach low-level ATA driver to system
  *	@ent: Information provided by low-level driver
  *	@host_set: Collections of ports to which we add
  *	@port_no: Port number associated with this host
@@ -5322,12 +5322,11 @@ static void ata_port_init_shost(struct a
  *	RETURNS:
  *	New ata_port on success, for NULL on error.
  */
-
-static struct ata_port * ata_host_add(const struct ata_probe_ent *ent,
+static struct ata_port * ata_port_add(const struct ata_probe_ent *ent,
 				      struct ata_host_set *host_set,
 				      unsigned int port_no)
 {
-	struct Scsi_Host *host;
+	struct Scsi_Host *shost;
 	struct ata_port *ap;
 	int rc;
 
@@ -5340,16 +5339,16 @@ static struct ata_port * ata_host_add(co
 		return NULL;
 	}
 
-	host = scsi_host_alloc(ent->sht, sizeof(struct ata_port));
-	if (!host)
+	shost = scsi_host_alloc(ent->sht, sizeof(struct ata_port));
+	if (!shost)
 		return NULL;
 
-	host->transportt = &ata_scsi_transport_template;
+	shost->transportt = &ata_scsi_transport_template;
 
-	ap = ata_shost_to_port(host);
+	ap = ata_shost_to_port(shost);
 
 	ata_port_init(ap, host_set, ent, port_no);
-	ata_port_init_shost(ap, host);
+	ata_port_init_shost(ap, shost);
 
 	rc = ap->ops->port_start(ap);
 	if (rc)
@@ -5358,7 +5357,7 @@ static struct ata_port * ata_host_add(co
 	return ap;
 
 err_out:
-	scsi_host_put(host);
+	scsi_host_put(shost);
 	return NULL;
 }
 
@@ -5427,7 +5426,7 @@ int ata_device_add(const struct ata_prob
 		struct ata_port *ap;
 		unsigned long xfer_mode_mask;
 
-		ap = ata_host_add(ent, host_set, i);
+		ap = ata_port_add(ent, host_set, i);
 		if (!ap)
 			goto err_out;
 
-- 
1.3.2


