From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: kill spurious assignment in piix_sata_probe()
Date: Sun, 12 Feb 2006 19:05:07 +0900
Message-ID: <20060212100507.GA20979@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:34772 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932367AbWBLKFK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 05:05:10 -0500
Received: by zproxy.gmail.com with SMTP id 40so752750nzk
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2006 02:05:09 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

In piix_sata_probe(), mask gets assigned unnecessarily at the
beginning of the function.  Kill the assignment.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

This patch is against
the current upstream (bef4a456b8dc8b3638f4d49a25a89e1467da9483)
+ http://article.gmane.org/gmane.linux.ide/7967
+ http://article.gmane.org/gmane.linux.ide/7968 (2 patches)

 drivers/scsi/ata_piix.c |    3 ---
 1 file changed, 3 deletions(-)

Index: work1/drivers/scsi/ata_piix.c
===================================================================
--- work1.orig/drivers/scsi/ata_piix.c	2006-02-12 18:48:31.000000000 +0900
+++ work1/drivers/scsi/ata_piix.c	2006-02-12 18:48:31.000000000 +0900
@@ -425,9 +425,6 @@ static int piix_sata_probe (struct ata_p
 	int orig_mask, mask, i;
 	u8 pcs;
 
-	mask = (PIIX_PORT_PRESENT << ap->hard_port_no) |
-	       (PIIX_PORT_ENABLED << ap->hard_port_no);
-
 	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
 	orig_mask = (int) pcs & 0xff;
 
