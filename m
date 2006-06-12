From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: add host_set->next for legacy two host_sets case, take #2
Date: Mon, 12 Jun 2006 19:14:19 +0900
Message-ID: <20060612101419.GB5751@htj.dyndns.org>
References: <20060612051727.GD9166@htj.dyndns.org> <448D0FF9.1080605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:60876 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751714AbWFLKOZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 06:14:25 -0400
Received: by py-out-1112.google.com with SMTP id x31so1635971pye
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 03:14:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <448D0FF9.1080605@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>

For a legacy ATA controller, libata registers two separate host sets.
There was no connection between the two hosts making it impossible to
traverse all ports related to the controller.  This patch adds
host_set->next which points to the second host_set and makes
ata_host_set_remove() remove all associated host_sets and ports.

* On device removal, all ports hanging off the device are properly
  detached.  Prior to this patch, ports on the first host_set weren't
  detached casuing oops on driver unloading.

* On device removal, both host_sets are properly freed

This will also be used by new power management code to suspend and
resume all ports of a controller.  host_set/port representation will
be improved to handle legacy controllers better and this host_set
linking will go away with it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-bmdma.c |   15 +++++++++++++--
 drivers/scsi/libata-core.c  |   44 +++++++++++++++++++++++--------------------
 include/linux/libata.h      |    3 ++-
 3 files changed, 39 insertions(+), 23 deletions(-)

b53ff57b968b2b6f07ae091d0d7d29f1e422fb3a
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 4bc0537..13fab97 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -1076,10 +1076,21 @@ int ata_pci_init_one (struct pci_dev *pd
 
 	/* FIXME: check ata_device_add return */
 	if (legacy_mode) {
-		if (legacy_mode & (1 << 0))
+		struct device *dev = &pdev->dev;
+		struct ata_host_set *host_set = NULL;
+
+		if (legacy_mode & (1 << 0)) {
 			ata_device_add(probe_ent);
-		if (legacy_mode & (1 << 1))
+			host_set = dev_get_drvdata(dev);
+		}
+
+		if (legacy_mode & (1 << 1)) {
 			ata_device_add(probe_ent2);
+			if (host_set) {
+				host_set->next = dev_get_drvdata(dev);
+				dev_set_drvdata(dev, host_set);
+			}
+		}
 	} else
 		ata_device_add(probe_ent);
 
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 014855e..43f88ef 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5507,37 +5507,41 @@ void ata_port_detach(struct ata_port *ap
  *	LOCKING:
  *	Inherited from calling layer (may sleep).
  */
-
 void ata_host_set_remove(struct ata_host_set *host_set)
 {
-	unsigned int i;
+	while (host_set) {
+		struct ata_host_set *next;
+		unsigned int i;
 
-	for (i = 0; i < host_set->n_ports; i++)
-		ata_port_detach(host_set->ports[i]);
+		for (i = 0; i < host_set->n_ports; i++)
+			ata_port_detach(host_set->ports[i]);
 
-	free_irq(host_set->irq, host_set);
+		free_irq(host_set->irq, host_set);
 
-	for (i = 0; i < host_set->n_ports; i++) {
-		struct ata_port *ap = host_set->ports[i];
+		for (i = 0; i < host_set->n_ports; i++) {
+			struct ata_port *ap = host_set->ports[i];
 
-		ata_scsi_release(ap->host);
+			ata_scsi_release(ap->host);
 
-		if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
-			struct ata_ioports *ioaddr = &ap->ioaddr;
+			if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
+				struct ata_ioports *ioaddr = &ap->ioaddr;
 
-			if (ioaddr->cmd_addr == 0x1f0)
-				release_region(0x1f0, 8);
-			else if (ioaddr->cmd_addr == 0x170)
-				release_region(0x170, 8);
-		}
+				if (ioaddr->cmd_addr == 0x1f0)
+					release_region(0x1f0, 8);
+				else if (ioaddr->cmd_addr == 0x170)
+					release_region(0x170, 8);
+			}
 
-		scsi_host_put(ap->host);
-	}
+			scsi_host_put(ap->host);
+		}
 
-	if (host_set->ops->host_stop)
-		host_set->ops->host_stop(host_set);
+		if (host_set->ops->host_stop)
+			host_set->ops->host_stop(host_set);
 
-	kfree(host_set);
+		next = host_set->next;
+		kfree(host_set);
+		host_set = next;
+	}
 }
 
 /**
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 61eea57..f03b866 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -356,7 +356,8 @@ struct ata_host_set {
 	unsigned long		flags;
 	int			simplex_claimed;	/* Keep seperate in case we
 							   ever need to do this locked */
-	struct ata_port *	ports[0];
+	struct ata_host_set	*next;		/* for legacy mode */
+	struct ata_port		*ports[0];
 };
 
 struct ata_queued_cmd {
-- 
1.3.2

