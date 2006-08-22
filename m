From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: implement force_pcs module parameter
Date: Tue, 22 Aug 2006 21:15:58 +0900
Message-ID: <20060822121558.GB21866@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:40684 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932147AbWHVMQE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Aug 2006 08:16:04 -0400
Received: by nz-out-0102.google.com with SMTP id 14so471740nzn
        for <linux-ide@vger.kernel.org>; Tue, 22 Aug 2006 05:16:03 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

This patch implements force_pcs module parameter for ata_piix.  If 1,
PCS is ignored, 2 honored.  As there seem to be quite a few ICHs w/
impaired PCS, this option will be useful for cases where the default
setting doesn't work.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

Jeff, this patch is against libata-dev#usptream-fixes.  I think this
should go into 2.6.18 as it helps to work around possible regressions
and diagnose problem when this sort problem is met by innocent and
patch-unfriendly stable kernel users.

 drivers/scsi/ata_piix.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

Index: work/drivers/scsi/ata_piix.c
===================================================================
--- work.orig/drivers/scsi/ata_piix.c
+++ work/drivers/scsi/ata_piix.c
@@ -468,6 +468,11 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
+static int force_pcs = 0;
+module_param(force_pcs, int, 0444);
+MODULE_PARM_DESC(force_pcs, "force honoring or ignoring PCS to work around "
+		 "device mis-detection (0=default, 1=ignore PCS, 2=honor PCS)");
+
 /**
  *	piix_pata_cbl_detect - Probe host controller cable detect info
  *	@ap: Port for which cable detect info is desired
@@ -812,6 +817,7 @@ static int __devinit piix_check_450nx_er
 }
 
 static void __devinit piix_init_pcs(struct pci_dev *pdev,
+				    struct ata_port_info *pinfo,
 				    const struct piix_map_db *map_db)
 {
 	u16 pcs, new_pcs;
@@ -825,6 +831,18 @@ static void __devinit piix_init_pcs(stru
 		pci_write_config_word(pdev, ICH5_PCS, new_pcs);
 		msleep(150);
 	}
+
+	if (force_pcs == 1) {
+		dev_printk(KERN_INFO, &pdev->dev,
+			   "force ignoring PCS (0x%x)\n", new_pcs);
+		pinfo[0].host_flags |= PIIX_FLAG_IGNORE_PCS;
+		pinfo[1].host_flags |= PIIX_FLAG_IGNORE_PCS;
+	} else if (force_pcs == 2) {
+		dev_printk(KERN_INFO, &pdev->dev,
+			   "force honoring PCS (0x%x)\n", new_pcs);
+		pinfo[0].host_flags &= ~PIIX_FLAG_IGNORE_PCS;
+		pinfo[1].host_flags &= ~PIIX_FLAG_IGNORE_PCS;
+	}
 }
 
 static void __devinit piix_init_sata_map(struct pci_dev *pdev,
@@ -933,7 +951,8 @@ static int piix_init_one (struct pci_dev
 	if (host_flags & ATA_FLAG_SATA) {
 		piix_init_sata_map(pdev, port_info,
 				   piix_map_db_table[ent->driver_data]);
-		piix_init_pcs(pdev, piix_map_db_table[ent->driver_data]);
+		piix_init_pcs(pdev, port_info,
+			      piix_map_db_table[ent->driver_data]);
 	}
 
 	/* On ICH5, some BIOSen disable the interrupt using the
