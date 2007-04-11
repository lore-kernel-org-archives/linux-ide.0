From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/12] libata: allocate ap separately from shost
Date: Wed, 11 Apr 2007 15:42:04 +0900
Message-ID: <11762737243751-git-send-email-htejun@gmail.com>
References: <1176273724198-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:40961 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbXDKGmK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Apr 2007 02:42:10 -0400
Received: by nz-out-0506.google.com with SMTP id s1so57272nze
        for <linux-ide@vger.kernel.org>; Tue, 10 Apr 2007 23:42:09 -0700 (PDT)
In-Reply-To: <1176273724198-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, brking@linux.vnet.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

Don't embed ap inside shost.  Allocate it separately and point it back
from shosts's hostdata.  This makes port allocation more flexible and
allows regular ATA and SAS share host alloc/init paths.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   19 ++++++++++++++-----
 include/linux/libata.h    |    2 +-
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 735f0b0..542e9ea 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5782,13 +5782,18 @@ static struct ata_port * ata_port_add(const struct ata_probe_ent *ent,
 		return NULL;
 	}
 
-	shost = scsi_host_alloc(ent->sht, sizeof(struct ata_port));
-	if (!shost)
+	ap = kzalloc(sizeof(struct ata_port), GFP_KERNEL);
+	if (!ap)
 		return NULL;
 
-	shost->transportt = &ata_scsi_transport_template;
+	shost = scsi_host_alloc(ent->sht, sizeof(struct ata_port *));
+	if (!shost) {
+		kfree(ap);
+		return NULL;
+	}
 
-	ap = ata_shost_to_port(shost);
+	*(struct ata_port **)&shost->hostdata[0] = ap;
+	shost->transportt = &ata_scsi_transport_template;
 
 	ata_port_init(ap, host, ent, port_no);
 	ata_port_init_shost(ap, shost);
@@ -5814,9 +5819,13 @@ static void ata_host_release(struct device *gendev, void *res)
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
index 12237d4..ced9dd5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1231,7 +1231,7 @@ static inline void ata_pad_free(struct ata_port *ap, struct device *dev)
 
 static inline struct ata_port *ata_shost_to_port(struct Scsi_Host *host)
 {
-	return (struct ata_port *) &host->hostdata[0];
+	return *(struct ata_port **)&host->hostdata[0];
 }
 
 #endif /* __LINUX_LIBATA_H__ */
-- 
1.5.0.3


