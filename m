From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/9] libata: fix several bugs in reworked legacy handling
Date: Sat, 5 Aug 2006 06:01:33 +0900
Message-ID: <11547252931996-git-send-email-htejun@gmail.com>
References: <11547252923301-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.205]:29803 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161459AbWHDVBo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Aug 2006 17:01:44 -0400
Received: by nz-out-0102.google.com with SMTP id n1so109138nzf
        for <linux-ide@vger.kernel.org>; Fri, 04 Aug 2006 14:01:44 -0700 (PDT)
In-Reply-To: <11547252923301-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, davej@redhat.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch fixes the following bugs from reworked legacy handling.

* In ata_pci_init_legacy_port(), probe_num was incorrectly incremented
  during initialization of the secondary port and probe_ent->n_ports
  was incorrectly fixed to 1.

* Both legacy ports ended up having the same hard_port_no.

* When printing port information, both legacy ports printed the first
  irq.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-bmdma.c |    5 +++--
 drivers/scsi/libata-core.c  |   14 ++++++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

69cc948426e05f43ea99d1b5f5f65c57dc395834
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 34343e5..d43dc9a 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -905,7 +905,6 @@ static struct ata_probe_ent *ata_pci_ini
 		return NULL;
 
 	probe_ent->legacy_mode = 1;
-	probe_ent->n_ports = 1;
 	probe_ent->hard_port_no = 0;
 	probe_ent->private_data = port[0]->private_data;
 
@@ -933,7 +932,6 @@ static struct ata_probe_ent *ata_pci_ini
 		probe_ent->port[port_num].cmd_addr = ATA_SECONDARY_CMD;
 		probe_ent->port[port_num].altstatus_addr =
 		probe_ent->port[port_num].ctl_addr = ATA_SECONDARY_CTL;
-		port_num ++;
 		if (bmdma) {
 			probe_ent->port[port_num].bmdma_addr = bmdma + 8;
 			if (inb(bmdma + 10) & 0x80)
@@ -942,6 +940,9 @@ static struct ata_probe_ent *ata_pci_ini
 		ata_std_ports(&probe_ent->port[port_num]);
 		port_num ++;
 	}
+
+	probe_ent->n_ports = port_num;
+
 	return probe_ent;
 }
 
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 16134d5..01eae98 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5244,8 +5244,9 @@ static void ata_port_init(struct ata_por
 	ap->host_set = host_set;
 	ap->dev = ent->dev;
 	ap->port_no = port_no;
-	ap->hard_port_no =
-		ent->legacy_mode ? ent->hard_port_no : port_no;
+	ap->hard_port_no = port_no;
+	if (ent->legacy_mode)
+		ap->hard_port_no += ent->hard_port_no;
 	ap->pio_mask = ent->pio_mask;
 	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
@@ -5404,16 +5405,15 @@ int ata_device_add(const struct ata_prob
 				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
 				(ap->pio_mask << ATA_SHIFT_PIO);
 
-		/* FIXME: maybe print both IRQ lines ? */
 		/* print per-port info to dmesg */
 		ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd 0x%lX "
-				"ctl 0x%lX bmdma 0x%lX irq %lu\n",
+				"ctl 0x%lX bmdma 0x%lX irq %d\n",
 				ap->flags & ATA_FLAG_SATA ? 'S' : 'P',
 				ata_mode_string(xfer_mode_mask),
 				ap->ioaddr.cmd_addr,
 				ap->ioaddr.ctl_addr,
 				ap->ioaddr.bmdma_addr,
-				ent->irq);
+				irq_line);
 
 		ata_chk_status(ap);
 		host_set->ops->irq_clear(ap);
@@ -5440,7 +5440,7 @@ int ata_device_add(const struct ata_prob
 		if (rc) {
 			dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
 				   ent->irq2, rc);
-			goto err_out;
+			goto err_out_free_irq;
 		}
 	}
 
@@ -5517,6 +5517,8 @@ int ata_device_add(const struct ata_prob
 	VPRINTK("EXIT, returning %u\n", ent->n_ports);
 	return ent->n_ports; /* success */
 
+err_out_free_irq:
+	free_irq(ent->irq, host_set);
 err_out:
 	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap = host_set->ports[i];
-- 
1.3.2


