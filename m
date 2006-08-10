From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: replace pci_module_init() with pci_register_driver()
Date: Thu, 10 Aug 2006 18:33:59 +0900
Message-ID: <20060810093359.GD6371@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.198]:13588 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751483AbWHJJeF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 05:34:05 -0400
Received: by nz-out-0102.google.com with SMTP id n1so131744nzf
        for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 02:34:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, proski@gnu.org

From: Pavel Roskin <proski@gnu.org>

Replace pci_module_init() with pci_register_driver().

Signed-off-by: Pavel Roskin <proski@gnu.org>
Signed-off-by: Tejun Heo <htejun@gmail.com>

---

This patch is against

 upstream (3f066887595de490c411762ce58a31412b09e939)
 + improve-init-and-legacy-handling patchset, take #3
   (http://article.gmane.org/gmane.linux.ide/12556)

And avaliable in the following git tree.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-upstream-pci_register_driver
  git://htj.dyndns.org/libata-tj tj-upstream-pci_register_driver

#pata-drivers and #ALL are updated accordingly and available at...

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-pata-drivers-pci_register_driver
  git://htj.dyndns.org/libata-tj tj-pata-drivers-pci_register_driver

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-ALL-pci_register_driver
  git://htj.dyndns.org/libata-tj tj-ALL-pci_register_driver

Thanks.

 drivers/scsi/ahci.c         |    2 +-
 drivers/scsi/ata_piix.c     |    4 ++--
 drivers/scsi/pdc_adma.c     |    2 +-
 drivers/scsi/sata_mv.c      |    2 +-
 drivers/scsi/sata_nv.c      |    2 +-
 drivers/scsi/sata_promise.c |    2 +-
 drivers/scsi/sata_qstor.c   |    2 +-
 drivers/scsi/sata_sil.c     |    2 +-
 drivers/scsi/sata_sil24.c   |    2 +-
 drivers/scsi/sata_sis.c     |    2 +-
 drivers/scsi/sata_svw.c     |    2 +-
 drivers/scsi/sata_sx4.c     |    2 +-
 drivers/scsi/sata_uli.c     |    2 +-
 drivers/scsi/sata_via.c     |    2 +-
 drivers/scsi/sata_vsc.c     |    2 +-
 15 files changed, 16 insertions(+), 16 deletions(-)

b7887196e38da54ff893897b80875d632d1a1114
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 68fd766..813031c 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -1665,7 +1665,7 @@ static void ahci_remove_one (struct pci_
 
 static int __init ahci_init(void)
 {
-	return pci_module_init(&ahci_pci_driver);
+	return pci_register_driver(&ahci_pci_driver);
 }
 
 static void __exit ahci_exit(void)
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 501755a..46c34fd 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -939,8 +939,8 @@ static int __init piix_init(void)
 {
 	int rc;
 
-	DPRINTK("pci_module_init\n");
-	rc = pci_module_init(&piix_pci_driver);
+	DPRINTK("pci_register_driver\n");
+	rc = pci_register_driver(&piix_pci_driver);
 	if (rc)
 		return rc;
 
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index d1f38c3..6b7b624 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -721,7 +721,7 @@ err_out:
 
 static int __init adma_ata_init(void)
 {
-	return pci_module_init(&adma_ata_pci_driver);
+	return pci_register_driver(&adma_ata_pci_driver);
 }
 
 static void __exit adma_ata_exit(void)
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 1053c7c..a2915a5 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -2447,7 +2447,7 @@ err_out:
 
 static int __init mv_init(void)
 {
-	return pci_module_init(&mv_pci_driver);
+	return pci_register_driver(&mv_pci_driver);
 }
 
 static void __exit mv_exit(void)
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 56da255..be46df7 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -583,7 +583,7 @@ static void nv_ck804_host_stop(struct at
 
 static int __init nv_init(void)
 {
-	return pci_module_init(&nv_pci_driver);
+	return pci_register_driver(&nv_pci_driver);
 }
 
 static void __exit nv_exit(void)
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 4776f4e..a5b3a7d 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -824,7 +824,7 @@ err_out:
 
 static int __init pdc_ata_init(void)
 {
-	return pci_module_init(&pdc_ata_pci_driver);
+	return pci_register_driver(&pdc_ata_pci_driver);
 }
 
 
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index d374c1d..71bd671 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -712,7 +712,7 @@ err_out:
 
 static int __init qs_ata_init(void)
 {
-	return pci_module_init(&qs_ata_pci_driver);
+	return pci_register_driver(&qs_ata_pci_driver);
 }
 
 static void __exit qs_ata_exit(void)
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index d0a8507..2393379 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -714,7 +714,7 @@ static int sil_pci_device_resume(struct 
 
 static int __init sil_init(void)
 {
-	return pci_module_init(&sil_pci_driver);
+	return pci_register_driver(&sil_pci_driver);
 }
 
 static void __exit sil_exit(void)
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 3f368c7..3a0161d 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -1205,7 +1205,7 @@ static int sil24_pci_device_resume(struc
 
 static int __init sil24_init(void)
 {
-	return pci_module_init(&sil24_pci_driver);
+	return pci_register_driver(&sil24_pci_driver);
 }
 
 static void __exit sil24_exit(void)
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index ee6b5df..ac24f66 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -334,7 +334,7 @@ err_out:
 
 static int __init sis_init(void)
 {
-	return pci_module_init(&sis_pci_driver);
+	return pci_register_driver(&sis_pci_driver);
 }
 
 static void __exit sis_exit(void)
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index 7d08580..baf259a 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -488,7 +488,7 @@ static struct pci_driver k2_sata_pci_dri
 
 static int __init k2_sata_init(void)
 {
-	return pci_module_init(&k2_sata_pci_driver);
+	return pci_register_driver(&k2_sata_pci_driver);
 }
 
 
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index ccc8cad..0da83cb 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -1482,7 +1482,7 @@ err_out:
 
 static int __init pdc_sata_init(void)
 {
-	return pci_module_init(&pdc_sata_pci_driver);
+	return pci_register_driver(&pdc_sata_pci_driver);
 }
 
 
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index 33cdb48..654aae2 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -287,7 +287,7 @@ err_out:
 
 static int __init uli_init(void)
 {
-	return pci_module_init(&uli_pci_driver);
+	return pci_register_driver(&uli_pci_driver);
 }
 
 static void __exit uli_exit(void)
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index 03baec2..0bf1dbe 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -381,7 +381,7 @@ err_out:
 
 static int __init svia_init(void)
 {
-	return pci_module_init(&svia_pci_driver);
+	return pci_register_driver(&svia_pci_driver);
 }
 
 static void __exit svia_exit(void)
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index ad37871..4c69a70 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -462,7 +462,7 @@ static struct pci_driver vsc_sata_pci_dr
 
 static int __init vsc_sata_init(void)
 {
-	return pci_module_init(&vsc_sata_pci_driver);
+	return pci_register_driver(&vsc_sata_pci_driver);
 }
 
 
-- 
1.3.2

