From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/9] [libata] some function renaming
Date: Sat, 5 Aug 2006 06:01:32 +0900
Message-ID: <11547252921979-git-send-email-htejun@gmail.com>
References: <11547252923301-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:59189 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161451AbWHDVBj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Aug 2006 17:01:39 -0400
Received: by py-out-1112.google.com with SMTP id z74so516815pyg
        for <linux-ide@vger.kernel.org>; Fri, 04 Aug 2006 14:01:38 -0700 (PDT)
In-Reply-To: <11547252923301-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, davej@redhat.com, linux-ide@vger.kernel.org
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

 drivers/scsi/libata-core.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

580fa7772f5d87a414dee32b1b0d37c5caf826c7
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 351544d..b5af446 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5218,7 +5218,7 @@ void ata_dev_init(struct ata_device *dev
 }
 
 /**
- *	ata_host_init - Initialize an ata_port structure
+ *	ata_port_init - Initialize an ata_port structure
  *	@ap: Structure to initialize
  *	@host: associated SCSI mid-layer structure
  *	@host_set: Collection of hosts to which @ap belongs
@@ -5231,7 +5231,7 @@ void ata_dev_init(struct ata_device *dev
  *	LOCKING:
  *	Inherited from caller.
  */
-static void ata_host_init(struct ata_port *ap, struct Scsi_Host *host,
+static void ata_port_init(struct ata_port *ap, struct Scsi_Host *host,
 			  struct ata_host_set *host_set,
 			  const struct ata_probe_ent *ent, unsigned int port_no)
 {
@@ -5298,7 +5298,7 @@ #endif
 }
 
 /**
- *	ata_host_add - Attach low-level ATA driver to system
+ *	ata_port_add - Attach low-level ATA driver to system
  *	@ent: Information provided by low-level driver
  *	@host_set: Collections of ports to which we add
  *	@port_no: Port number associated with this host
@@ -5312,7 +5312,7 @@ #endif
  *	New ata_port on success, for NULL on error.
  */
 
-static struct ata_port * ata_host_add(const struct ata_probe_ent *ent,
+static struct ata_port * ata_port_add(const struct ata_probe_ent *ent,
 				      struct ata_host_set *host_set,
 				      unsigned int port_no)
 {
@@ -5337,7 +5337,7 @@ static struct ata_port * ata_host_add(co
 
 	ap = ata_shost_to_port(host);
 
-	ata_host_init(ap, host, host_set, ent, port_no);
+	ata_port_init(ap, host, host_set, ent, port_no);
 
 	rc = ap->ops->port_start(ap);
 	if (rc)
@@ -5396,7 +5396,7 @@ int ata_device_add(const struct ata_prob
 		struct ata_port *ap;
 		unsigned long xfer_mode_mask;
 
-		ap = ata_host_add(ent, host_set, i);
+		ap = ata_port_add(ent, host_set, i);
 		if (!ap)
 			goto err_out;
 
-- 
1.3.2


