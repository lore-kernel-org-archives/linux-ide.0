From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 05/13] ata: update references for libata documentation
Date: Sun, 14 May 2017 12:38:39 -0300
Message-ID: <1b21c841315ac1da96b4866d3266b0f8a414586f.1494775891.git.mchehab@s-opensource.com>
References: <cover.1494775891.git.mchehab@s-opensource.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1494775891.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1494775891.git.mchehab@s-opensource.com>
References: <cover.1494775891.git.mchehab@s-opensource.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mikael Pettersson <mikpelinux@gmail.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The libata documentation is now using ReST. Update references
to it to point to the new place.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/ata/acard-ahci.c    | 2 +-
 drivers/ata/ahci.c          | 2 +-
 drivers/ata/ahci.h          | 2 +-
 drivers/ata/ata_piix.c      | 2 +-
 drivers/ata/libahci.c       | 2 +-
 drivers/ata/libata-core.c   | 2 +-
 drivers/ata/libata-eh.c     | 2 +-
 drivers/ata/libata-scsi.c   | 2 +-
 drivers/ata/libata-sff.c    | 2 +-
 drivers/ata/libata.h        | 2 +-
 drivers/ata/pata_pdc2027x.c | 2 +-
 drivers/ata/pdc_adma.c      | 2 +-
 drivers/ata/sata_nv.c       | 2 +-
 drivers/ata/sata_promise.c  | 2 +-
 drivers/ata/sata_promise.h  | 2 +-
 drivers/ata/sata_qstor.c    | 2 +-
 drivers/ata/sata_sil.c      | 2 +-
 drivers/ata/sata_sis.c      | 2 +-
 drivers/ata/sata_svw.c      | 2 +-
 drivers/ata/sata_sx4.c      | 2 +-
 drivers/ata/sata_uli.c      | 2 +-
 drivers/ata/sata_via.c      | 2 +-
 drivers/ata/sata_vsc.c      | 2 +-
 include/linux/ata.h         | 2 +-
 include/linux/libata.h      | 2 +-
 25 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index ed6a30cd681a..940ddbc59aa7 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -25,7 +25,7 @@
  *
  *
  * libata documentation is available via 'make {ps|pdf}docs',
- * as Documentation/DocBook/libata.*
+ * as Documentation/driver-api/libata.rst
  *
  * AHCI hardware documentation:
  * http://www.intel.com/technology/serialata/pdf/rev1_0.pdf
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2fc52407306c..fd712e0e9d87 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -24,7 +24,7 @@
  *
  *
  * libata documentation is available via 'make {ps|pdf}docs',
- * as Documentation/DocBook/libata.*
+ * as Documentation/driver-api/libata.rst
  *
  * AHCI hardware documentation:
  * http://www.intel.com/technology/serialata/pdf/rev1_0.pdf
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 5db6ab261643..30f67a1a4f54 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -24,7 +24,7 @@
  *
  *
  * libata documentation is available via 'make {ps|pdf}docs',
- * as Documentation/DocBook/libata.*
+ * as Documentation/driver-api/libata.rst
  *
  * AHCI hardware documentation:
  * http://www.intel.com/technology/serialata/pdf/rev1_0.pdf
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index ffbe625e6fd2..8401c3b5be92 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -33,7 +33,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  *  Hardware documentation available at http://developer.intel.com/
  *
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 3159f9e66d8f..6154f0e2b81a 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -24,7 +24,7 @@
  *
  *
  * libata documentation is available via 'make {ps|pdf}docs',
- * as Documentation/DocBook/libata.*
+ * as Documentation/driver-api/libata.rst
  *
  * AHCI hardware documentation:
  * http://www.intel.com/technology/serialata/pdf/rev1_0.pdf
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2d83b8c75965..55aaa2e4c683 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -25,7 +25,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  *  Hardware documentation available from http://www.t13.org/ and
  *  http://www.sata-io.org/
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ef68232b5222..7e33e200aae5 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -25,7 +25,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  *  Hardware documentation available from http://www.t13.org/ and
  *  http://www.sata-io.org/
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index dcd38d9e9804..b0866f040d1f 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -25,7 +25,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  *  Hardware documentation available from
  *  - http://www.t10.org/
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 274d6d7193d7..052921352f31 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -25,7 +25,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  *  Hardware documentation available from http://www.t13.org/ and
  *  http://www.sata-io.org/
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 120fce0befd3..5afe35baf61b 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -21,7 +21,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  */
 
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index d9ef9e276225..82bfd51692f3 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -17,7 +17,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  *  Hardware information only available under NDA.
  *
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 64d682c6ee57..f1e873a37465 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -21,7 +21,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  *
  *  Supports ATA disks in single-packet ADMA mode.
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 734f563b8d37..8c683ddd0f58 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -21,7 +21,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  *  No hardware documentation available outside of NVIDIA.
  *  This driver programs the NVIDIA SATA controller in a similar
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 0fa211e2831c..d032bf657f70 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -25,7 +25,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  *  Hardware information only available under NDA.
  *
diff --git a/drivers/ata/sata_promise.h b/drivers/ata/sata_promise.h
index 00d6000e546f..61633ef5ed72 100644
--- a/drivers/ata/sata_promise.h
+++ b/drivers/ata/sata_promise.h
@@ -20,7 +20,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  */
 
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index af987a4f33d1..1fe941688e95 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -23,7 +23,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  */
 
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 29bcff086bce..ed76f070d21e 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -25,7 +25,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  *  Documentation for SiI 3112:
  *  http://gkernel.sourceforge.net/specs/sii/3112A_SiI-DS-0095-B2.pdf.bz2
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index d1637ac40a73..30f4f35f36d4 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -24,7 +24,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  *  Hardware documentation available under NDA.
  *
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index ff614be55d0f..0fd6ac7e57ba 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -30,7 +30,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  *  Hardware documentation available under NDA.
  *
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 48301cb3a316..405e606a234d 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -24,7 +24,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  *  Hardware documentation available under NDA.
  *
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index 08f98c3ed5c8..4f6e8d8156de 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -18,7 +18,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  *  Hardware documentation available under NDA.
  *
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index f3f538eec7b3..22e96fc77d09 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -25,7 +25,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  *  Hardware documentation available under NDA.
  *
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 183eb52085df..9648127cca70 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -26,7 +26,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  *  Vitesse hardware documentation presumably available under NDA.
  *  Intel 31244 (same hardware interface) documentation presumably
diff --git a/include/linux/ata.h b/include/linux/ata.h
index ad7d9ee89ff0..73fe18edfdaf 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -20,7 +20,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  *  Hardware documentation available from http://www.t13.org/
  *
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c9a69fc8821e..9e6633235ad7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -19,7 +19,7 @@
  *
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
- *  as Documentation/DocBook/libata.*
+ *  as Documentation/driver-api/libata.rst
  *
  */
 
-- 
2.9.3
