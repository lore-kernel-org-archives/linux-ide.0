From: Henning Schmiedehausen <hps@intermeta.de>
Subject: PCI Constants Update for SATA Driver
Date: Sun, 27 Feb 2005 18:42:43 +0100
Message-ID: <1109526163.19325.2.camel@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-FCTtOx4qMr93xuzbDYNZ"
Received: from babsi.intermeta.de ([194.77.152.163]:29377 "EHLO
	mail.intermeta.de") by vger.kernel.org with ESMTP id S261471AbVB0RnM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Feb 2005 12:43:12 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE Mailingliste <linux-ide@vger.kernel.org>


--=-FCTtOx4qMr93xuzbDYNZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

having the various constants in pci_ids.h is a really good thing for
grepping through the kernel source. And if they were used, it would be
even better (if you e.g. are looking for which driver claims an SIImage
3112 card...). However, the sata_xxx.c files in the drivers/scsi
directory are notorious for not using the PCI Ids but just hard coded
numbers.

This patch tries to fix this. It is against the 2.6.10 tree from Fedora
Core 3 but should apply to a regular 2.6.10 too.

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

      RedHat Certified Engineer -- Jakarta Turbine Development
   Linux, Java, perl, Solaris -- Consulting, Training, Engineering

"Now you can start with implementation and integration and do the
requirements later".  -- Prof. Dr. Dr. h.c. Manfred Broy about the new
german federal software development standard "V-Model XT"
(found at http://de.biz.yahoo.com/050207/299/4en0t.html)

--=-FCTtOx4qMr93xuzbDYNZ
Content-Disposition: attachment; filename=sata_pci.patch
Content-Type: text/x-patch; name=sata_pci.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.6.10/drivers/scsi/sata_promise.c~	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6.10/drivers/scsi/sata_promise.c	2005-02-27 18:06:21.832987233 +0100
@@ -148,17 +148,17 @@
 };
 
 static struct pci_device_id pdc_ata_pci_tbl[] = {
-	{ PCI_VENDOR_ID_PROMISE, 0x3371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
-	{ PCI_VENDOR_ID_PROMISE, 0x3373, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20378, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
-	{ PCI_VENDOR_ID_PROMISE, 0x3375, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20375, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
-	{ PCI_VENDOR_ID_PROMISE, 0x3376, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20376, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
-	{ PCI_VENDOR_ID_PROMISE, 0x3318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
-	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 	{ }	/* terminate list */
 };
--- linux-2.6.10/drivers/scsi/sata_uli.c~	2005-02-27 12:29:10.000000000 +0100
+++ linux-2.6.10/drivers/scsi/sata_uli.c	2005-02-27 18:06:13.659752507 +0100
@@ -51,9 +51,9 @@
 static void uli_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
 static struct pci_device_id uli_pci_tbl[] = {
-	{ PCI_VENDOR_ID_AL, 0x5289, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5289 },
-	{ PCI_VENDOR_ID_AL, 0x5287, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5287 },
-	{ PCI_VENDOR_ID_AL, 0x5281, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5281 },
+	{ PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_ULI_5287, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5289 },
+	{ PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_ULI_5289, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5287 },
+	{ PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M5281, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5281 },
 	{ }	/* terminate list */
 };
 
--- linux-2.6.10/drivers/scsi/sata_sil.c~	2005-02-27 12:29:10.000000000 +0100
+++ linux-2.6.10/drivers/scsi/sata_sil.c	2005-02-27 18:06:20.152144613 +0100
@@ -67,12 +67,12 @@
 static void sil_post_set_mode (struct ata_port *ap);
 
 static struct pci_device_id sil_pci_tbl[] = {
-	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
-	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_SATA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SATA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
 	{ }	/* terminate list */
 };
 
--- linux-2.6.10/drivers/scsi/sata_via.c~	2004-12-24 22:34:01.000000000 +0100
+++ linux-2.6.10/drivers/scsi/sata_via.c	2005-02-27 18:06:11.947912788 +0100
@@ -66,7 +66,7 @@
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
 static struct pci_device_id svia_pci_tbl[] = {
-	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, via_sata },
+	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237_SATA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, via_sata },
 
 	{ }	/* terminate list */
 };
--- linux-2.6.10/drivers/scsi/sata_sx4.c~	2004-12-24 22:33:48.000000000 +0100
+++ linux-2.6.10/drivers/scsi/sata_sx4.c	2005-02-27 17:50:24.569601228 +0100
@@ -223,7 +223,7 @@
 };
 
 static struct pci_device_id pdc_sata_pci_tbl[] = {
-	{ PCI_VENDOR_ID_PROMISE, 0x6622, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20621, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20621 },
 	{ }	/* terminate list */
 };
--- linux-2.6.10/drivers/scsi/sata_vsc.c~	2004-12-24 22:34:58.000000000 +0100
+++ linux-2.6.10/drivers/scsi/sata_vsc.c	2005-02-27 18:06:01.601881495 +0100
@@ -363,8 +363,8 @@
  * compatibility is untested as of yet
  */
 static struct pci_device_id vsc_sata_pci_tbl[] = {
-	{ 0x1725, 0x7174, PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
-	{ 0x8086, 0x3200, PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
+	{ PCI_VENDOR_ID_VITESSE, PCI_DEVICE_ID_VITESSE_VSC7174, PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_GD31244, PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
 	{ }
 };
 
--- linux-2.6.10/drivers/scsi/sata_sis.c~	2004-12-24 22:34:57.000000000 +0100
+++ linux-2.6.10/drivers/scsi/sata_sis.c	2005-02-27 18:06:18.583291508 +0100
@@ -60,8 +60,8 @@
 static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
 static struct pci_device_id sis_pci_tbl[] = {
-	{ PCI_VENDOR_ID_SI, 0x180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
-	{ PCI_VENDOR_ID_SI, 0x181, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
+	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_RAID180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
+	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_RAID180_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
 	{ }	/* terminate list */
 };
 
--- linux-2.6.10/drivers/scsi/sata_svw.c~	2004-12-24 22:35:00.000000000 +0100
+++ linux-2.6.10/drivers/scsi/sata_svw.c	2005-02-27 18:06:16.878451135 +0100
@@ -439,9 +439,9 @@
 
 
 static struct pci_device_id k2_sata_pci_tbl[] = {
-	{ 0x1166, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ 0x1166, 0x0241, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ 0x1166, 0x0242, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_K2_240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_K2_241, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_K2_242, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ }
 };
 
--- linux-2.6.10/include/linux/pci_ids.h~	2005-02-27 18:35:28.312973711 +0100
+++ linux-2.6.10/include/linux/pci_ids.h	2005-02-27 18:37:04.623021628 +0100
@@ -598,6 +598,8 @@
 #define PCI_DEVICE_ID_SI_503		0x0008
 #define PCI_DEVICE_ID_SI_ACPI		0x0009
 #define PCI_DEVICE_ID_SI_LPC		0x0018
+#define PCI_DEVICE_ID_SI_RAID180	0x0180
+#define PCI_DEVICE_ID_SI_RAID180_2	0x0181
 #define PCI_DEVICE_ID_SI_5597_VGA	0x0200
 #define PCI_DEVICE_ID_SI_6205		0x0205
 #define PCI_DEVICE_ID_SI_501		0x0406
@@ -793,19 +795,26 @@
 
 #define PCI_VENDOR_ID_PROMISE		0x105a
 #define PCI_DEVICE_ID_PROMISE_20265	0x0d30
+#define PCI_DEVICE_ID_PROMISE_20263	0x0d38
+#define PCI_DEVICE_ID_PROMISE_20275	0x1275
+#define PCI_DEVICE_ID_PROMISE_20318	0x3318
+#define PCI_DEVICE_ID_PROMISE_20319	0x3319
+#define PCI_DEVICE_ID_PROMISE_20371	0x3371
+#define PCI_DEVICE_ID_PROMISE_20378	0x3373
+#define PCI_DEVICE_ID_PROMISE_20375	0x3375
+#define PCI_DEVICE_ID_PROMISE_20376	0x3376
 #define PCI_DEVICE_ID_PROMISE_20267	0x4d30
 #define PCI_DEVICE_ID_PROMISE_20246	0x4d33
 #define PCI_DEVICE_ID_PROMISE_20262	0x4d38
-#define PCI_DEVICE_ID_PROMISE_20263	0x0D38
 #define PCI_DEVICE_ID_PROMISE_20268	0x4d68
-#define PCI_DEVICE_ID_PROMISE_20268R	0x6268
 #define PCI_DEVICE_ID_PROMISE_20269	0x4d69
+#define PCI_DEVICE_ID_PROMISE_20276	0x5275
+#define PCI_DEVICE_ID_PROMISE_5300	0x5300
+#define PCI_DEVICE_ID_PROMISE_20268R	0x6268
 #define PCI_DEVICE_ID_PROMISE_20270	0x6268
 #define PCI_DEVICE_ID_PROMISE_20271	0x6269
-#define PCI_DEVICE_ID_PROMISE_20275	0x1275
-#define PCI_DEVICE_ID_PROMISE_20276	0x5275
+#define PCI_DEVICE_ID_PROMISE_20621	0x6622
 #define PCI_DEVICE_ID_PROMISE_20277	0x7275
-#define PCI_DEVICE_ID_PROMISE_5300	0x5300
 
 #define PCI_VENDOR_ID_N9		0x105d
 #define PCI_DEVICE_ID_N9_I128		0x2309
@@ -927,6 +936,7 @@
 #define PCI_DEVICE_ID_SUN_TOMATILLO	0xa801
 
 #define PCI_VENDOR_ID_CMD		0x1095
+#define PCI_DEVICE_ID_SII_1210SA	0x0240
 #define PCI_DEVICE_ID_CMD_640		0x0640
 #define PCI_DEVICE_ID_CMD_643		0x0643
 #define PCI_DEVICE_ID_CMD_646		0x0646
@@ -938,7 +948,8 @@
 
 #define PCI_DEVICE_ID_SII_680		0x0680
 #define PCI_DEVICE_ID_SII_3112		0x3112
-#define PCI_DEVICE_ID_SII_1210SA	0x0240
+#define PCI_DEVICE_ID_SII_3114		0x3114
+#define PCI_DEVICE_ID_SII_3512		0x3512
 
 #define PCI_VENDOR_ID_VISION		0x1098
 #define PCI_DEVICE_ID_VISION_QD8500	0x0001
@@ -1050,6 +1061,9 @@
 #define PCI_DEVICE_ID_AL_M5228		0x5228
 #define PCI_DEVICE_ID_AL_M5229		0x5229
 #define PCI_DEVICE_ID_AL_M5237		0x5237
+#define PCI_DEVICE_ID_AL_M5281		0x5281
+#define PCI_DEVICE_ID_AL_ULI_5287	0x5287
+#define PCI_DEVICE_ID_AL_ULI_5289	0x5289
 #define PCI_DEVICE_ID_AL_M5243		0x5243
 #define PCI_DEVICE_ID_AL_M5451		0x5451
 #define PCI_DEVICE_ID_AL_M7101		0x7101
@@ -1447,6 +1461,9 @@
 #define PCI_DEVICE_ID_SERVERWORKS_GCLE    0x0225
 #define PCI_DEVICE_ID_SERVERWORKS_GCLE2   0x0227
 #define PCI_DEVICE_ID_SERVERWORKS_CSB5ISA 0x0230
+#define PCI_DEVICE_ID_SERVERWORKS_K2_240  0x0240
+#define PCI_DEVICE_ID_SERVERWORKS_K2_241  0x0241
+#define PCI_DEVICE_ID_SERVERWORKS_K2_242  0x0242
 
 #define PCI_VENDOR_ID_SBE		0x1176
 #define PCI_DEVICE_ID_SBE_WANXL100	0x0301
@@ -2015,6 +2032,9 @@
 #define PCI_DEVICE_ID_FARSITE_TE1       0x1610
 #define PCI_DEVICE_ID_FARSITE_TE1C      0x1612
 
+#define PCI_VENDOR_ID_VITESSE           0x1725
+#define PCI_DEVICE_ID_VITESSE_VSC7174   0x7174
+
 #define PCI_VENDOR_ID_LINKSYS		0x1737
 #define PCI_DEVICE_ID_LINKSYS_EG1032	0x1032
 #define PCI_DEVICE_ID_LINKSYS_EG1064	0x1064
@@ -2275,6 +2295,7 @@
 #define PCI_DEVICE_ID_INTEL_ICH7_21	0x27df
 #define PCI_DEVICE_ID_INTEL_ICH7_22	0x27e0
 #define PCI_DEVICE_ID_INTEL_ICH7_23	0x27e2
+#define PCI_DEVICE_ID_INTEL_GD31244	0x3200
 #define PCI_DEVICE_ID_INTEL_82855PM_HB	0x3340
 #define PCI_DEVICE_ID_INTEL_82830_HB	0x3575
 #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577

--=-FCTtOx4qMr93xuzbDYNZ--

