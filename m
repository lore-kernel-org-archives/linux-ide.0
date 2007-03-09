From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/12] libata: allocate ap separately from shost
Date: Fri, 9 Mar 2007 20:15:35 +0900
Message-ID: <11734389351381-git-send-email-htejun@gmail.com>
References: <1173438935540-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:36192 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767183AbXCILPi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 06:15:38 -0500
Received: by py-out-1112.google.com with SMTP id a29so282622pyi
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 03:15:37 -0800 (PST)
In-Reply-To: <1173438935540-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Don't embed ap inside shost.  Allocate it separately and point it back
from shosts's hostdata.  This makes port allocation more flexible and
allows regular ATA and SAS share host alloc/init paths.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   15 +++++++++++----
 include/linux/libata.h    |    2 +-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6e124bd..fab488c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5646,14 +5646,17 @@ static struct ata_port * ata_port_add(const struct ata_probe_ent *ent,
 		return NULL;
 	}
 
-	shost = scsi_host_alloc(ent->sht, sizeof(struct ata_port));
+	ap = kzalloc(sizeof(struct ata_port), GFP_KERNEL);
+	if (!ap)
+		return NULL;
+
+	shost = scsi_host_alloc(ent->sht, sizeof(struct ata_port *));
 	if (!shost)
 		return NULL;
 
+	*(struct ata_port **)&shost->hostdata[0] = ap;
 	shost->transportt = &ata_scsi_transport_template;
 
-	ap = ata_shost_to_port(shost);
-
 	ata_port_init(ap, host, ent, port_no);
 	ata_port_init_shost(ap, shost);
 
@@ -5678,9 +5681,13 @@ static void ata_host_release(struct device *gendev, void *res)
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
-		if (ap)
+		if (!ap)
+			continue;
+
+		if (ap->scsi_host)
 			scsi_host_put(ap->scsi_host);
 
+		kfree(ap);
 		host->ports[i] = NULL;
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 911ac4e..cfdc617 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1221,7 +1221,7 @@ static inline void ata_pad_free(struct ata_port *ap, struct device *dev)
 
 static inline struct ata_port *ata_shost_to_port(struct Scsi_Host *host)
 {
-	return (struct ata_port *) &host->hostdata[0];
+	return *(struct ata_port **)&host->hostdata[0];
 }
 
 #endif /* __LINUX_LIBATA_H__ */
-- 
1.5.0.1


