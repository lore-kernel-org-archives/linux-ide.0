From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: make ata_generic and pata_pdc2027x use pci_register_driver()
Date: Thu, 10 Aug 2006 18:36:27 +0900
Message-ID: <20060810093627.GE6371@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:40507 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751485AbWHJJgc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 05:36:32 -0400
Received: by py-out-1112.google.com with SMTP id z74so757024pyg
        for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 02:36:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Make ata_generic and pata_pdc2027x use pci_register_driver() instead
of pci_module_init().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

This patch is for review.  Please pull from libata-tj git tree
described in the following post.

  http://article.gmane.org/gmane.linux.ide/12565

 drivers/scsi/ata_generic.c   |    2 +-
 drivers/scsi/pata_pdc2027x.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

48583b7d38ae0550cb372a21d6929d38f91b4676
diff --git a/drivers/scsi/ata_generic.c b/drivers/scsi/ata_generic.c
index 35b0ae2..781bc01 100644
--- a/drivers/scsi/ata_generic.c
+++ b/drivers/scsi/ata_generic.c
@@ -231,7 +231,7 @@ static struct pci_driver ata_generic_pci
 
 static int __init ata_generic_init(void)
 {
-	return pci_module_init(&ata_generic_pci_driver);
+	return pci_register_driver(&ata_generic_pci_driver);
 }
 
 
diff --git a/drivers/scsi/pata_pdc2027x.c b/drivers/scsi/pata_pdc2027x.c
index 4f713fc..f816785 100644
--- a/drivers/scsi/pata_pdc2027x.c
+++ b/drivers/scsi/pata_pdc2027x.c
@@ -854,7 +854,7 @@ static void __devexit pdc2027x_remove_on
  */
 static int __init pdc2027x_init(void)
 {
-	return pci_module_init(&pdc2027x_pci_driver);
+	return pci_register_driver(&pdc2027x_pci_driver);
 }
 
 /**
-- 
1.3.2

