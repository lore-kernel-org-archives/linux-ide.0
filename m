From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/9] libata: update ata_host_init() and rename it to ata_port_init_shost()
Date: Thu, 10 Aug 2006 17:16:29 +0900
Message-ID: <1155197789963-git-send-email-htejun@gmail.com>
References: <11551977882917-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:11311 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751186AbWHJIQe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 04:16:34 -0400
Received: by py-out-1112.google.com with SMTP id z74so730388pyg
        for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 01:16:33 -0700 (PDT)
In-Reply-To: <11551977882917-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update ata_host_init() such that it only initializes SCSI host related
stuff and doesn't call into ata_port_init(), and rename it to
ata_port_init_shost().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   33 +++++++++++++--------------------
 1 files changed, 13 insertions(+), 20 deletions(-)

4608c1608501cf2b0dc4478c9b6c3902db58408a
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 83d93fc..eb9de07 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5288,32 +5288,24 @@ #endif
 }
 
 /**
- *	ata_host_init - Initialize an ata_port structure
- *	@ap: Structure to initialize
- *	@host: associated SCSI mid-layer structure
- *	@host_set: Collection of hosts to which @ap belongs
- *	@ent: Probe information provided by low-level driver
- *	@port_no: Port number associated with this ata_port
+ *	ata_port_init_shost - Initialize SCSI host associated with ATA port
+ *	@ap: ATA port to initialize SCSI host for
+ *	@shost: SCSI host associated with @ap
  *
- *	Initialize a new ata_port structure, and its associated
- *	scsi_host.
+ *	Initialize SCSI host @shost associated with ATA port @ap.
  *
  *	LOCKING:
  *	Inherited from caller.
  */
-
-static void ata_host_init(struct ata_port *ap, struct Scsi_Host *host,
-			  struct ata_host_set *host_set,
-			  const struct ata_probe_ent *ent, unsigned int port_no)
+static void ata_port_init_shost(struct ata_port *ap, struct Scsi_Host *shost)
 {
-	ata_port_init(ap, host_set, ent, port_no);
-	ap->host = host;
+	ap->host = shost;
 
-	host->unique_id = ap->id;
-	host->max_id = 16;
-	host->max_lun = 1;
-	host->max_channel = 1;
-	host->max_cmd_len = 12;
+	shost->unique_id = ap->id;
+	shost->max_id = 16;
+	shost->max_lun = 1;
+	shost->max_channel = 1;
+	shost->max_cmd_len = 12;
 }
 
 /**
@@ -5356,7 +5348,8 @@ static struct ata_port * ata_host_add(co
 
 	ap = ata_shost_to_port(host);
 
-	ata_host_init(ap, host, host_set, ent, port_no);
+	ata_port_init(ap, host_set, ent, port_no);
+	ata_port_init_shost(ap, host);
 
 	rc = ap->ops->port_start(ap);
 	if (rc)
-- 
1.3.2


