From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: implement ignore_PCS driver option
Date: Sun, 12 Feb 2006 19:08:41 +0900
Message-ID: <20060212100841.GB20979@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:57351 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932370AbWBLKIp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 05:08:45 -0500
Received: by zproxy.gmail.com with SMTP id 14so805595nzn
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2006 02:08:44 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: jfs@keytradebank.com, kmannth@gmail.com, 0602@eq.cz

On some configurations, ICH5 SATA incorrectly reports 0 for PCS even
when ports are active and operational.  This patch adds a driver
parameter which, when set, causes ata_piix ignore PCS value and
proceed with device probing.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

This patch is against
the current upstream (bef4a456b8dc8b3638f4d49a25a89e1467da9483)
+ http://article.gmane.org/gmane.linux.ide/7967
+ http://article.gmane.org/gmane.linux.ide/7968 (2 patches)
+ http://article.gmane.org/gmane.linux.ide/7970

 drivers/scsi/ata_piix.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: work1/drivers/scsi/ata_piix.c
===================================================================
--- work1.orig/drivers/scsi/ata_piix.c	2006-02-12 18:48:31.000000000 +0900
+++ work1/drivers/scsi/ata_piix.c	2006-02-12 18:48:31.000000000 +0900
@@ -330,6 +330,11 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
+static int ignore_PCS = 0;
+module_param(ignore_PCS, int, 0444);
+MODULE_PARM_DESC(ignore_PCS, "ignore PCS register to force device probing, "
+			     "useful on some ICH5 SATA setups (0=off, 1=on)");
+
 /**
  *	piix_pata_cbl_detect - Probe host controller cable detect info
  *	@ap: Port for which cable detect info is desired
@@ -428,6 +433,12 @@ static int piix_sata_probe (struct ata_p
 	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
 	orig_mask = (int) pcs & 0xff;
 
+	if (ignore_PCS) {
+		printk(KERN_INFO "ata%u: ignoring PIIX PCS (0x%x)\n",
+		       ap->id, pcs);
+		return 1;
+	}
+
 	/* TODO: this is vaguely wrong for ICH6 combined mode,
 	 * where only two of the four SATA ports are mapped
 	 * onto a single ATA channel.  It is also vaguely inaccurate
