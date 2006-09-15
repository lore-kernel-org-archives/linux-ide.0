From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix non-uniform ports handling
Date: Sat, 16 Sep 2006 03:04:15 +0900
Message-ID: <20060915180415.GB25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:64872 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751297AbWIOSEW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Sep 2006 14:04:22 -0400
Received: by py-out-1112.google.com with SMTP id n25so4169518pyg
        for <linux-ide@vger.kernel.org>; Fri, 15 Sep 2006 11:04:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, alan@lxorguk.ukuu.org.uk, "Nelson A. de Oliveira" <naoliv@gmail.com>

Non-uniform ports handling got broken while updating libata to handle
those in the same host.  Only separate irq for the non-uniform
secondary port was implemented while all other fields (host flags,
transfer mode...) of the secondary port simply shared those of the
first.

For ata_piix combined mode, which ATM is the only user of non-uniform
ports, this causes the secondary port assume the wrong type.  This can
cause PATA port to use SATA ops, which results in bogus check on PCS
and detection failure.

This patch adds ata_probe_ent->pinfo2 which points to optional
port_info for the secondary port.  For the time being, this seems to
be the simplest solution.  This workaround will be removed together
with ata_probe_ent itself after init model is updated to allow more
flexibility.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nelson A. de Oliveira <naoliv@gmail.com>
---
 drivers/ata/libata-core.c |   18 +++++++++++++-----
 drivers/ata/libata-sff.c  |    2 ++
 include/linux/libata.h    |    8 ++++++++
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1c93154..bb66a12 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5269,11 +5269,19 @@ void ata_port_init(struct ata_port *ap, 
 	ap->host = host;
 	ap->dev = ent->dev;
 	ap->port_no = port_no;
-	ap->pio_mask = ent->pio_mask;
-	ap->mwdma_mask = ent->mwdma_mask;
-	ap->udma_mask = ent->udma_mask;
-	ap->flags |= ent->port_flags;
-	ap->ops = ent->port_ops;
+	if (port_no == 1 && ent->pinfo2) {
+		ap->pio_mask = ent->pinfo2->pio_mask;
+		ap->mwdma_mask = ent->pinfo2->mwdma_mask;
+		ap->udma_mask = ent->pinfo2->udma_mask;
+		ap->flags |= ent->pinfo2->flags;
+		ap->ops = ent->pinfo2->port_ops;
+	} else {
+		ap->pio_mask = ent->pio_mask;
+		ap->mwdma_mask = ent->mwdma_mask;
+		ap->udma_mask = ent->udma_mask;
+		ap->flags |= ent->port_flags;
+		ap->ops = ent->port_ops;
+	}
 	ap->hw_sata_spd_limit = UINT_MAX;
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 7605028..e72ed8d 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -858,6 +858,7 @@ ata_pci_init_native_mode(struct pci_dev 
 			probe_ent->port[p].bmdma_addr = bmdma;
 		}
 		ata_std_ports(&probe_ent->port[p]);
+		probe_ent->pinfo2 = port[1];
 		p++;
 	}
 
@@ -907,6 +908,7 @@ static struct ata_probe_ent *ata_pci_ini
 				probe_ent->_host_flags |= ATA_HOST_SIMPLEX;
 		}
 		ata_std_ports(&probe_ent->port[1]);
+		probe_ent->pinfo2 = port[1];
 	} else
 		probe_ent->dummy_port_mask |= ATA_PORT_SECONDARY;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8715305..ff67e75 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -361,6 +361,14 @@ struct ata_probe_ent {
 	unsigned long		_host_flags;
 	void __iomem		*mmio_base;
 	void			*private_data;
+
+	/* port_info for the secondary port.  Together with irq2, it's
+	 * used to implement non-uniform secondary port.  Currently,
+	 * the only user is ata_piix combined mode.  This workaround
+	 * will be removed together with ata_probe_ent when init model
+	 * is updated.
+	 */
+	const struct ata_port_info *pinfo2;
 };
 
 struct ata_host {
