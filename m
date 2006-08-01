From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/11] [libata] manually inline ata_host_remove()
Date: Wed, 2 Aug 2006 05:11:49 +0900
Message-ID: <1154463109539-git-send-email-htejun@gmail.com>
References: <11544631081793-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:40950 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932534AbWHAULy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Aug 2006 16:11:54 -0400
Received: by py-out-1112.google.com with SMTP id t32so1324111pyc
        for <linux-ide@vger.kernel.org>; Tue, 01 Aug 2006 13:11:54 -0700 (PDT)
In-Reply-To: <11544631081793-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.ukjgarzik@pobox.com, akpm@osdl.org, davej@redhat.com, linux-ide@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   31 ++++++-------------------------
 1 files changed, 6 insertions(+), 25 deletions(-)

2807702eafe33dd1783fd39c7137376082521736
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1cc12d4..4e06edc 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5185,28 +5185,6 @@ void ata_host_stop (struct ata_host_set 
 		iounmap(host_set->mmio_base);
 }
 
-
-/**
- *	ata_host_remove - Unregister SCSI host structure with upper layers
- *	@ap: Port to unregister
- *	@do_unregister: 1 if we fully unregister, 0 to just stop the port
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-static void ata_host_remove(struct ata_port *ap, unsigned int do_unregister)
-{
-	struct Scsi_Host *sh = ap->host;
-
-	DPRINTK("ENTER\n");
-
-	if (do_unregister)
-		scsi_remove_host(sh);
-
-	ap->ops->port_stop(ap);
-}
-
 /**
  *	ata_dev_init - Initialize an ata_device structure
  *	@dev: Device structure to initialize
@@ -5532,8 +5510,11 @@ int ata_device_add(const struct ata_prob
 
 err_out:
 	for (i = 0; i < count; i++) {
-		ata_host_remove(host_set->ports[i], 1);
-		scsi_host_put(host_set->ports[i]->host);
+		struct ata_port *ap = host_set->ports[i];
+
+		scsi_remove_host(ap->host);
+		ap->ops->port_stop(ap);
+		scsi_host_put(ap->host);
 	}
 err_free_ret:
 	kfree(host_set);
@@ -5662,7 +5643,7 @@ int ata_scsi_release(struct Scsi_Host *h
 	DPRINTK("ENTER\n");
 
 	ap->ops->port_disable(ap);
-	ata_host_remove(ap, 0);
+	ap->ops->port_stop(ap);
 
 	DPRINTK("EXIT\n");
 	return 1;
-- 
1.3.2


