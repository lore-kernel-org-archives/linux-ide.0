From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 7/9] libata: use dummy port for stolen legacy ports
Date: Thu, 10 Aug 2006 17:16:30 +0900
Message-ID: <11551977901974-git-send-email-htejun@gmail.com>
References: <11551977882917-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:27950 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751462AbWHJIQj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 04:16:39 -0400
Received: by py-out-1112.google.com with SMTP id z74so730394pyg
        for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 01:16:38 -0700 (PDT)
In-Reply-To: <11551977882917-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Use dummy port for stolen legacy ports.  This makes ap->port_no always
equal ap->hard_port_no.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-bmdma.c |   41 +++++++++++++++++------------------------
 drivers/scsi/libata-core.c  |    2 --
 2 files changed, 17 insertions(+), 26 deletions(-)

c4b01f1de254820175fe2d02b4cf7c0fab335846
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index e694f60..158f62d 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -872,50 +872,43 @@ static struct ata_probe_ent *ata_pci_ini
 	struct ata_probe_ent *probe_ent;
 	unsigned long bmdma = pci_resource_start(pdev, 4);
 
-	int port_num = 0;
-
 	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
 	if (!probe_ent)
 		return NULL;
 
-	probe_ent->legacy_mode = 1;
-	probe_ent->hard_port_no = 0;
+	probe_ent->n_ports = 2;
 	probe_ent->private_data = port[0]->private_data;
 
 	if (port_mask & ATA_PORT_PRIMARY) {
 		probe_ent->irq = 14;
-		probe_ent->port[port_num].cmd_addr = ATA_PRIMARY_CMD;
-		probe_ent->port[port_num].altstatus_addr =
-		probe_ent->port[port_num].ctl_addr = ATA_PRIMARY_CTL;
+		probe_ent->port[0].cmd_addr = ATA_PRIMARY_CMD;
+		probe_ent->port[0].altstatus_addr =
+		probe_ent->port[0].ctl_addr = ATA_PRIMARY_CTL;
 		if (bmdma) {
 			probe_ent->port[0].bmdma_addr = bmdma;
 			if (inb(bmdma + 2) & 0x80)
 				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
 		}
-		ata_std_ports(&probe_ent->port[port_num]);
-		port_num ++;
-	}
+		ata_std_ports(&probe_ent->port[0]);
+	} else
+		probe_ent->dummy_port_mask |= ATA_PORT_PRIMARY;
+
 	if (port_mask & ATA_PORT_SECONDARY) {
-		if (port_num == 1)
+		if (probe_ent->irq)
 			probe_ent->irq2 = 15;
-		else {
-			/* Secondary only. IRQ 15 only and "first" port is port 1 */
+		else
 			probe_ent->irq = 15;
-			probe_ent->hard_port_no = 1;
-		}
-		probe_ent->port[port_num].cmd_addr = ATA_SECONDARY_CMD;
-		probe_ent->port[port_num].altstatus_addr =
-		probe_ent->port[port_num].ctl_addr = ATA_SECONDARY_CTL;
+		probe_ent->port[1].cmd_addr = ATA_SECONDARY_CMD;
+		probe_ent->port[1].altstatus_addr =
+		probe_ent->port[1].ctl_addr = ATA_SECONDARY_CTL;
 		if (bmdma) {
-			probe_ent->port[port_num].bmdma_addr = bmdma + 8;
+			probe_ent->port[1].bmdma_addr = bmdma + 8;
 			if (inb(bmdma + 10) & 0x80)
 				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
 		}
-		ata_std_ports(&probe_ent->port[port_num]);
-		port_num ++;
-	}
-
-	probe_ent->n_ports = port_num;
+		ata_std_ports(&probe_ent->port[1]);
+	} else
+		probe_ent->dummy_port_mask |= ATA_PORT_SECONDARY;
 
 	return probe_ent;
 }
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f2e7e2f..2ef86b4 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5224,8 +5224,6 @@ void ata_port_init(struct ata_port *ap, 
 	ap->dev = ent->dev;
 	ap->port_no = port_no;
 	ap->hard_port_no = port_no;
-	if (ent->legacy_mode)
-		ap->hard_port_no += ent->hard_port_no;
 	ap->pio_mask = ent->pio_mask;
 	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
-- 
1.3.2


