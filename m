From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix probe_ent free in ata_sas_port_alloc()
Date: Sat, 17 Feb 2007 23:27:52 +0900
Message-ID: <45D710E8.3090104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, James Bottomley <James.Bottomley@SteelEye.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, SCSI Mailing List <linux-scsi@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

probe_ent is allocated using devm_kzalloc() and thus should be freed
using devm_kfree().  ata_sas_port_alloc() freed its probe_ent using
kfree() thus causing double free later.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
James, does this fix the bug you mentioned on IRC?

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0009818..e5e19e3 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3234,7 +3234,7 @@ struct ata_port *ata_sas_port_alloc(struct ata_host *host,
 
 	ata_port_init(ap, host, ent, 0);
 	ap->lock = shost->host_lock;
-	kfree(ent);
+	devm_kfree(host->dev, ent);
 	return ap;
 }
 EXPORT_SYMBOL_GPL(ata_sas_port_alloc);
