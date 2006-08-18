From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: finish CONFIG_SCSI_[S]ATA -> CONFIG_[S]ATA renames
Date: Sat, 19 Aug 2006 03:08:32 +0900
Message-ID: <20060818180832.GJ6371@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:22550 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751459AbWHRSIk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Aug 2006 14:08:40 -0400
Received: by py-out-1112.google.com with SMTP id n25so1179997pyg
        for <linux-ide@vger.kernel.org>; Fri, 18 Aug 2006 11:08:39 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

libata CONFIG_* constants have been renamed during drivers/scsi ->
drivers/ata move but old constants are still in use in many places.
This patch converts all such places to new constants.

This patch restores INTEL_COMBINED quirk handling.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/arch/alpha/defconfig b/arch/alpha/defconfig
index 6da9c3d..fdd236f 100644
--- a/arch/alpha/defconfig
+++ b/arch/alpha/defconfig
@@ -270,7 +270,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_IN2000 is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_DTC3280 is not set
diff --git a/arch/arm/configs/ateb9200_defconfig b/arch/arm/configs/ateb9200_defconfig
index bee7813..9bc3549 100644
--- a/arch/arm/configs/ateb9200_defconfig
+++ b/arch/arm/configs/ateb9200_defconfig
@@ -462,7 +462,7 @@ #
 # SCSI low-level drivers
 #
 # CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/arm/configs/badge4_defconfig b/arch/arm/configs/badge4_defconfig
index cfe6bd8..c174d39 100644
--- a/arch/arm/configs/badge4_defconfig
+++ b/arch/arm/configs/badge4_defconfig
@@ -386,7 +386,7 @@ # CONFIG_SCSI_AHA152X is not set
 # CONFIG_SCSI_AHA1542 is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DTC3280 is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/arm/configs/corgi_defconfig b/arch/arm/configs/corgi_defconfig
index 3c3461e..98162f8 100644
--- a/arch/arm/configs/corgi_defconfig
+++ b/arch/arm/configs/corgi_defconfig
@@ -657,7 +657,7 @@ #
 # SCSI low-level drivers
 #
 # CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/arm/configs/csb337_defconfig b/arch/arm/configs/csb337_defconfig
index 3594155..0828b60 100644
--- a/arch/arm/configs/csb337_defconfig
+++ b/arch/arm/configs/csb337_defconfig
@@ -452,7 +452,7 @@ #
 # SCSI low-level drivers
 #
 # CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/arm/configs/csb637_defconfig b/arch/arm/configs/csb637_defconfig
index 640d70c..efee7af 100644
--- a/arch/arm/configs/csb637_defconfig
+++ b/arch/arm/configs/csb637_defconfig
@@ -452,7 +452,7 @@ #
 # SCSI low-level drivers
 #
 # CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/arm/configs/ep80219_defconfig b/arch/arm/configs/ep80219_defconfig
index 3c73b70..3787003 100644
--- a/arch/arm/configs/ep80219_defconfig
+++ b/arch/arm/configs/ep80219_defconfig
@@ -344,7 +344,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
index 2948b45..4ee6c1a 100644
--- a/arch/arm/configs/ep93xx_defconfig
+++ b/arch/arm/configs/ep93xx_defconfig
@@ -471,7 +471,7 @@ #
 # SCSI low-level drivers
 #
 # CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/arm/configs/iq31244_defconfig b/arch/arm/configs/iq31244_defconfig
index 3246716..3c967fd 100644
--- a/arch/arm/configs/iq31244_defconfig
+++ b/arch/arm/configs/iq31244_defconfig
@@ -345,7 +345,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/arm/configs/iq80331_defconfig b/arch/arm/configs/iq80331_defconfig
index 46c79e1..114e001 100644
--- a/arch/arm/configs/iq80331_defconfig
+++ b/arch/arm/configs/iq80331_defconfig
@@ -348,7 +348,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/arm/configs/iq80332_defconfig b/arch/arm/configs/iq80332_defconfig
index 11959b7..c6ebf3d 100644
--- a/arch/arm/configs/iq80332_defconfig
+++ b/arch/arm/configs/iq80332_defconfig
@@ -348,7 +348,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/arm/configs/ixp23xx_defconfig b/arch/arm/configs/ixp23xx_defconfig
index 7b18997..32990f5 100644
--- a/arch/arm/configs/ixp23xx_defconfig
+++ b/arch/arm/configs/ixp23xx_defconfig
@@ -533,7 +533,7 @@ # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
diff --git a/arch/arm/configs/kb9202_defconfig b/arch/arm/configs/kb9202_defconfig
index 45396e0..10d8afc 100644
--- a/arch/arm/configs/kb9202_defconfig
+++ b/arch/arm/configs/kb9202_defconfig
@@ -247,7 +247,7 @@ # CONFIG_SCSI_ISCSI_ATTRS is not set
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/arm/configs/lpd7a400_defconfig b/arch/arm/configs/lpd7a400_defconfig
index bf9cf9c..eeb7bf4 100644
--- a/arch/arm/configs/lpd7a400_defconfig
+++ b/arch/arm/configs/lpd7a400_defconfig
@@ -343,7 +343,7 @@ # CONFIG_SCSI_ISCSI_ATTRS is not set
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/arm/configs/lpd7a404_defconfig b/arch/arm/configs/lpd7a404_defconfig
index 3a57be3..2acceda 100644
--- a/arch/arm/configs/lpd7a404_defconfig
+++ b/arch/arm/configs/lpd7a404_defconfig
@@ -459,7 +459,7 @@ #
 # SCSI low-level drivers
 #
 # CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index 3d35255..c9fb275 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -364,7 +364,7 @@ # CONFIG_SCSI_AHA152X is not set
 # CONFIG_SCSI_AHA1542 is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DTC3280 is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/arm/configs/omap_h2_1610_defconfig b/arch/arm/configs/omap_h2_1610_defconfig
index 05adb0b..c3df03c 100644
--- a/arch/arm/configs/omap_h2_1610_defconfig
+++ b/arch/arm/configs/omap_h2_1610_defconfig
@@ -427,7 +427,7 @@ #
 # SCSI low-level drivers
 #
 # CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/arm/configs/pnx4008_defconfig b/arch/arm/configs/pnx4008_defconfig
index 8a078d4..7b6b888 100644
--- a/arch/arm/configs/pnx4008_defconfig
+++ b/arch/arm/configs/pnx4008_defconfig
@@ -807,7 +807,7 @@ #
 # SCSI low-level drivers
 #
 # CONFIG_ISCSI_TCP is not set
-CONFIG_SCSI_SATA=m
+CONFIG_ATA=m
 CONFIG_SCSI_PPA=m
 CONFIG_SCSI_IMM=m
 # CONFIG_SCSI_IZIP_EPP16 is not set
diff --git a/arch/arm/configs/rpc_defconfig b/arch/arm/configs/rpc_defconfig
index b498afd..6d6c36c 100644
--- a/arch/arm/configs/rpc_defconfig
+++ b/arch/arm/configs/rpc_defconfig
@@ -283,7 +283,7 @@ # CONFIG_SCSI_ISCSI_ATTRS is not set
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 CONFIG_SCSI_PPA=m
 CONFIG_SCSI_IMM=m
 # CONFIG_SCSI_IZIP_EPP16 is not set
diff --git a/arch/arm/configs/shark_defconfig b/arch/arm/configs/shark_defconfig
index c48d170..350b292 100644
--- a/arch/arm/configs/shark_defconfig
+++ b/arch/arm/configs/shark_defconfig
@@ -300,7 +300,7 @@ # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_IN2000 is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_DTC3280 is not set
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index d1ace3a..a9ed3b2 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -656,7 +656,7 @@ #
 # SCSI low-level drivers
 #
 # CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/arm/configs/trizeps4_defconfig b/arch/arm/configs/trizeps4_defconfig
index a6698dc..ba1bb70 100644
--- a/arch/arm/configs/trizeps4_defconfig
+++ b/arch/arm/configs/trizeps4_defconfig
@@ -627,7 +627,7 @@ #
 # SCSI low-level drivers
 #
 # CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/i386/defconfig b/arch/i386/defconfig
index 89ebb7a..cc787c0 100644
--- a/arch/i386/defconfig
+++ b/arch/i386/defconfig
@@ -575,7 +575,7 @@ # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/ia64/configs/bigsur_defconfig b/arch/ia64/configs/bigsur_defconfig
index 90e9c2e..657df4e 100644
--- a/arch/ia64/configs/bigsur_defconfig
+++ b/arch/ia64/configs/bigsur_defconfig
@@ -428,7 +428,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
 # CONFIG_SCSI_IPS is not set
diff --git a/arch/ia64/configs/gensparse_defconfig b/arch/ia64/configs/gensparse_defconfig
index 0d29aa2..fd03d07 100644
--- a/arch/ia64/configs/gensparse_defconfig
+++ b/arch/ia64/configs/gensparse_defconfig
@@ -449,22 +449,22 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-CONFIG_SCSI_SATA=y
-# CONFIG_SCSI_SATA_AHCI is not set
-# CONFIG_SCSI_SATA_SVW is not set
-# CONFIG_SCSI_ATA_PIIX is not set
-# CONFIG_SCSI_SATA_MV is not set
-# CONFIG_SCSI_SATA_NV is not set
-# CONFIG_SCSI_PDC_ADMA is not set
-# CONFIG_SCSI_SATA_QSTOR is not set
-# CONFIG_SCSI_SATA_PROMISE is not set
-# CONFIG_SCSI_SATA_SX4 is not set
-# CONFIG_SCSI_SATA_SIL is not set
-# CONFIG_SCSI_SATA_SIL24 is not set
-# CONFIG_SCSI_SATA_SIS is not set
-# CONFIG_SCSI_SATA_ULI is not set
-# CONFIG_SCSI_SATA_VIA is not set
-CONFIG_SCSI_SATA_VITESSE=y
+CONFIG_ATA=y
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SVW is not set
+# CONFIG_ATA_PIIX is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+CONFIG_SATA_VITESSE=y
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
 # CONFIG_SCSI_IPS is not set
diff --git a/arch/ia64/configs/sim_defconfig b/arch/ia64/configs/sim_defconfig
index d9146c3..f66147d 100644
--- a/arch/ia64/configs/sim_defconfig
+++ b/arch/ia64/configs/sim_defconfig
@@ -308,7 +308,7 @@ #
 # SCSI low-level drivers
 #
 # CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/ia64/configs/sn2_defconfig b/arch/ia64/configs/sn2_defconfig
index 0f14a82..9e3c00b 100644
--- a/arch/ia64/configs/sn2_defconfig
+++ b/arch/ia64/configs/sn2_defconfig
@@ -446,22 +446,22 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-CONFIG_SCSI_SATA=y
-# CONFIG_SCSI_SATA_AHCI is not set
-# CONFIG_SCSI_SATA_SVW is not set
-# CONFIG_SCSI_ATA_PIIX is not set
-# CONFIG_SCSI_SATA_MV is not set
-# CONFIG_SCSI_SATA_NV is not set
-# CONFIG_SCSI_PDC_ADMA is not set
-# CONFIG_SCSI_SATA_QSTOR is not set
-# CONFIG_SCSI_SATA_PROMISE is not set
-# CONFIG_SCSI_SATA_SX4 is not set
-# CONFIG_SCSI_SATA_SIL is not set
-# CONFIG_SCSI_SATA_SIL24 is not set
-# CONFIG_SCSI_SATA_SIS is not set
-# CONFIG_SCSI_SATA_ULI is not set
-# CONFIG_SCSI_SATA_VIA is not set
-CONFIG_SCSI_SATA_VITESSE=y
+CONFIG_ATA=y
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SVW is not set
+# CONFIG_ATA_PIIX is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+CONFIG_SATA_VITESSE=y
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
 # CONFIG_SCSI_IPS is not set
diff --git a/arch/ia64/configs/tiger_defconfig b/arch/ia64/configs/tiger_defconfig
index 9d1cffb..94376b0 100644
--- a/arch/ia64/configs/tiger_defconfig
+++ b/arch/ia64/configs/tiger_defconfig
@@ -440,7 +440,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
 # CONFIG_SCSI_IPS is not set
diff --git a/arch/ia64/configs/zx1_defconfig b/arch/ia64/configs/zx1_defconfig
index 949dc46..c3aee0b 100644
--- a/arch/ia64/configs/zx1_defconfig
+++ b/arch/ia64/configs/zx1_defconfig
@@ -454,7 +454,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
 # CONFIG_SCSI_IPS is not set
diff --git a/arch/ia64/defconfig b/arch/ia64/defconfig
index 9001b3f..4611a98 100644
--- a/arch/ia64/defconfig
+++ b/arch/ia64/defconfig
@@ -449,22 +449,22 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-CONFIG_SCSI_SATA=y
-# CONFIG_SCSI_SATA_AHCI is not set
-# CONFIG_SCSI_SATA_SVW is not set
-# CONFIG_SCSI_ATA_PIIX is not set
-# CONFIG_SCSI_SATA_MV is not set
-# CONFIG_SCSI_SATA_NV is not set
-# CONFIG_SCSI_PDC_ADMA is not set
-# CONFIG_SCSI_SATA_QSTOR is not set
-# CONFIG_SCSI_SATA_PROMISE is not set
-# CONFIG_SCSI_SATA_SX4 is not set
-# CONFIG_SCSI_SATA_SIL is not set
-# CONFIG_SCSI_SATA_SIL24 is not set
-# CONFIG_SCSI_SATA_SIS is not set
-# CONFIG_SCSI_SATA_ULI is not set
-# CONFIG_SCSI_SATA_VIA is not set
-CONFIG_SCSI_SATA_VITESSE=y
+CONFIG_ATA=y
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SVW is not set
+# CONFIG_ATA_PIIX is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+CONFIG_SATA_VITESSE=y
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
 # CONFIG_SCSI_IPS is not set
diff --git a/arch/m32r/defconfig b/arch/m32r/defconfig
index 8530930..b2b9a3a 100644
--- a/arch/m32r/defconfig
+++ b/arch/m32r/defconfig
@@ -234,7 +234,7 @@ # CONFIG_SCSI_ISCSI_ATTRS is not set
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/m32r/m32700ut/defconfig.m32700ut.smp b/arch/m32r/m32700ut/defconfig.m32700ut.smp
index 3e607d9..6018339 100644
--- a/arch/m32r/m32700ut/defconfig.m32700ut.smp
+++ b/arch/m32r/m32700ut/defconfig.m32700ut.smp
@@ -238,7 +238,7 @@ # CONFIG_SCSI_ISCSI_ATTRS is not set
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/m32r/m32700ut/defconfig.m32700ut.up b/arch/m32r/m32700ut/defconfig.m32700ut.up
index 2d3e7cd..0aae567 100644
--- a/arch/m32r/m32700ut/defconfig.m32700ut.up
+++ b/arch/m32r/m32700ut/defconfig.m32700ut.up
@@ -234,7 +234,7 @@ # CONFIG_SCSI_ISCSI_ATTRS is not set
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/m32r/mappi2/defconfig.vdec2 b/arch/m32r/mappi2/defconfig.vdec2
index 56f287b..793c369 100644
--- a/arch/m32r/mappi2/defconfig.vdec2
+++ b/arch/m32r/mappi2/defconfig.vdec2
@@ -230,7 +230,7 @@ # CONFIG_SCSI_ISCSI_ATTRS is not set
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/m32r/opsput/defconfig.opsput b/arch/m32r/opsput/defconfig.opsput
index 66adec6..6dce463 100644
--- a/arch/m32r/opsput/defconfig.opsput
+++ b/arch/m32r/opsput/defconfig.opsput
@@ -209,7 +209,7 @@ # CONFIG_SCSI_ISCSI_ATTRS is not set
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 5649fba..eb097e4 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -227,7 +227,7 @@ #
 # CONFIG_SCSI_AHA152X is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DTC3280 is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
 # CONFIG_SCSI_GENERIC_NCR5380 is not set
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 63024b0..e351896 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -183,7 +183,7 @@ # CONFIG_SCSI_ISCSI_ATTRS is not set
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 6433da2..a38eb25 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -214,7 +214,7 @@ # CONFIG_SCSI_ISCSI_ATTRS is not set
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_PPA is not set
 # CONFIG_SCSI_IMM is not set
 # CONFIG_SCSI_DEBUG is not set
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index da2a23a..493bc67 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -183,7 +183,7 @@ # CONFIG_SCSI_ISCSI_ATTRS is not set
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 5125188..de16181 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -184,7 +184,7 @@ # CONFIG_SCSI_ISCSI_ATTRS is not set
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 15b80ab..e929a14 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -208,7 +208,7 @@ # CONFIG_SCSI_ISCSI_ATTRS is not set
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 CONFIG_MAC_SCSI=y
 CONFIG_SCSI_MAC_ESP=y
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index f0d5534..24868b4 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -183,7 +183,7 @@ # CONFIG_SCSI_ISCSI_ATTRS is not set
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 CONFIG_MVME147_SCSI=y
 
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 1d5c46f..a8692a6 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -183,7 +183,7 @@ # CONFIG_SCSI_ISCSI_ATTRS is not set
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 8562386..fb223b4 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -214,7 +214,7 @@ #
 # CONFIG_SCSI_AHA152X is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DTC3280 is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
 # CONFIG_SCSI_GENERIC_NCR5380 is not set
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index af903b5..20e5d0e 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -171,7 +171,7 @@ # CONFIG_SCSI_ISCSI_ATTRS is not set
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 997143b..8f846eb 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -182,7 +182,7 @@ # CONFIG_SCSI_ISCSI_ATTRS is not set
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 CONFIG_SUN3X_ESP=y
 
diff --git a/arch/m68k/defconfig b/arch/m68k/defconfig
index 7d935e4..54cc8ef 100644
--- a/arch/m68k/defconfig
+++ b/arch/m68k/defconfig
@@ -176,7 +176,7 @@ # CONFIG_SCSI_ISCSI_ATTRS is not set
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 CONFIG_A3000_SCSI=y
 CONFIG_A2091_SCSI=y
diff --git a/arch/mips/configs/atlas_defconfig b/arch/mips/configs/atlas_defconfig
index 5427406..4c573b5 100644
--- a/arch/mips/configs/atlas_defconfig
+++ b/arch/mips/configs/atlas_defconfig
@@ -723,7 +723,7 @@ # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
diff --git a/arch/mips/configs/db1200_defconfig b/arch/mips/configs/db1200_defconfig
index c13768e..6eb903f 100644
--- a/arch/mips/configs/db1200_defconfig
+++ b/arch/mips/configs/db1200_defconfig
@@ -571,7 +571,7 @@ #
 # SCSI low-level drivers
 #
 # CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/mips/configs/decstation_defconfig b/arch/mips/configs/decstation_defconfig
index 597150b..f41fa4c 100644
--- a/arch/mips/configs/decstation_defconfig
+++ b/arch/mips/configs/decstation_defconfig
@@ -422,7 +422,7 @@ #
 CONFIG_ISCSI_TCP=m
 CONFIG_SCSI_DECNCR=y
 # CONFIG_SCSI_DECSII is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/mips/configs/emma2rh_defconfig b/arch/mips/configs/emma2rh_defconfig
index 375b2ac..4cdc867 100644
--- a/arch/mips/configs/emma2rh_defconfig
+++ b/arch/mips/configs/emma2rh_defconfig
@@ -554,7 +554,7 @@ # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
diff --git a/arch/mips/configs/excite_defconfig b/arch/mips/configs/excite_defconfig
index 045ebd0..49e7216 100644
--- a/arch/mips/configs/excite_defconfig
+++ b/arch/mips/configs/excite_defconfig
@@ -505,7 +505,7 @@ # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index ef16d1f..8f08c37 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -633,7 +633,7 @@ # SCSI low-level drivers
 #
 CONFIG_ISCSI_TCP=m
 CONFIG_SGIWD93_SCSI=y
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 4bf1ee7..bab9a47 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -498,7 +498,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
index f83dc09..d0df651 100644
--- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -448,7 +448,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 2690baf..b2463bd 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -768,7 +768,7 @@ # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
diff --git a/arch/mips/configs/ocelot_3_defconfig b/arch/mips/configs/ocelot_3_defconfig
index ec5758f..03b9534 100644
--- a/arch/mips/configs/ocelot_3_defconfig
+++ b/arch/mips/configs/ocelot_3_defconfig
@@ -501,7 +501,7 @@ # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
diff --git a/arch/mips/configs/pnx8550-jbs_defconfig b/arch/mips/configs/pnx8550-jbs_defconfig
index ac616c8..f265f8d 100644
--- a/arch/mips/configs/pnx8550-jbs_defconfig
+++ b/arch/mips/configs/pnx8550-jbs_defconfig
@@ -445,7 +445,7 @@ # SCSI low-level drivers
 #
 CONFIG_ISCSI_TCP=m
 # CONFIG_SGIWD93_SCSI is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/mips/configs/pnx8550-v2pci_defconfig b/arch/mips/configs/pnx8550-v2pci_defconfig
index a8eb51b..8af9128 100644
--- a/arch/mips/configs/pnx8550-v2pci_defconfig
+++ b/arch/mips/configs/pnx8550-v2pci_defconfig
@@ -500,7 +500,7 @@ # SCSI low-level drivers
 #
 CONFIG_ISCSI_TCP=m
 # CONFIG_SGIWD93_SCSI is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index b7826d3..38adb80 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -726,7 +726,7 @@ CONFIG_MEGARAID_MM=m
 CONFIG_MEGARAID_MAILBOX=m
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_DTC3280 is not set
diff --git a/arch/mips/configs/tb0226_defconfig b/arch/mips/configs/tb0226_defconfig
index 2ba4e25..b179d52 100644
--- a/arch/mips/configs/tb0226_defconfig
+++ b/arch/mips/configs/tb0226_defconfig
@@ -443,7 +443,7 @@ # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
diff --git a/arch/mips/configs/tb0287_defconfig b/arch/mips/configs/tb0287_defconfig
index effcb63..e92cb1f 100644
--- a/arch/mips/configs/tb0287_defconfig
+++ b/arch/mips/configs/tb0287_defconfig
@@ -510,7 +510,7 @@ # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
diff --git a/arch/mips/defconfig b/arch/mips/defconfig
index fff6fcc..6d9c4e4 100644
--- a/arch/mips/defconfig
+++ b/arch/mips/defconfig
@@ -633,7 +633,7 @@ # SCSI low-level drivers
 #
 CONFIG_ISCSI_TCP=m
 CONFIG_SGIWD93_SCSI=y
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
diff --git a/arch/parisc/configs/712_defconfig b/arch/parisc/configs/712_defconfig
index 41fd069..bef5d75 100644
--- a/arch/parisc/configs/712_defconfig
+++ b/arch/parisc/configs/712_defconfig
@@ -346,7 +346,7 @@ #
 # SCSI low-level drivers
 #
 # CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_PPA is not set
 # CONFIG_SCSI_IMM is not set
 CONFIG_SCSI_LASI700=y
diff --git a/arch/parisc/configs/a500_defconfig b/arch/parisc/configs/a500_defconfig
index f3b812f..59e6e99 100644
--- a/arch/parisc/configs/a500_defconfig
+++ b/arch/parisc/configs/a500_defconfig
@@ -455,7 +455,7 @@ # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_CPQFCTS is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA_PIO is not set
diff --git a/arch/parisc/configs/b180_defconfig b/arch/parisc/configs/b180_defconfig
index 3509361..c737900 100644
--- a/arch/parisc/configs/b180_defconfig
+++ b/arch/parisc/configs/b180_defconfig
@@ -313,7 +313,7 @@ # CONFIG_SCSI_IN2000 is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_DTC3280 is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
diff --git a/arch/parisc/configs/c3000_defconfig b/arch/parisc/configs/c3000_defconfig
index 782906b..4c26ae1 100644
--- a/arch/parisc/configs/c3000_defconfig
+++ b/arch/parisc/configs/c3000_defconfig
@@ -419,23 +419,23 @@ # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-CONFIG_SCSI_SATA=y
-# CONFIG_SCSI_SATA_AHCI is not set
-# CONFIG_SCSI_SATA_SVW is not set
-CONFIG_SCSI_ATA_PIIX=m
-# CONFIG_SCSI_SATA_MV is not set
-# CONFIG_SCSI_SATA_NV is not set
-# CONFIG_SCSI_PDC_ADMA is not set
-# CONFIG_SCSI_SATA_QSTOR is not set
-CONFIG_SCSI_SATA_PROMISE=m
-# CONFIG_SCSI_SATA_SX4 is not set
-CONFIG_SCSI_SATA_SIL=m
-# CONFIG_SCSI_SATA_SIL24 is not set
-# CONFIG_SCSI_SATA_SIS is not set
-# CONFIG_SCSI_SATA_ULI is not set
-CONFIG_SCSI_SATA_VIA=m
-# CONFIG_SCSI_SATA_VITESSE is not set
-CONFIG_SCSI_SATA_INTEL_COMBINED=y
+CONFIG_ATA=y
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SVW is not set
+CONFIG_ATA_PIIX=m
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+CONFIG_SATA_PROMISE=m
+# CONFIG_SATA_SX4 is not set
+CONFIG_SATA_SIL=m
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+CONFIG_SATA_VIA=m
+# CONFIG_SATA_VITESSE is not set
+CONFIG_SATA_INTEL_COMBINED=y
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
 # CONFIG_SCSI_IPS is not set
diff --git a/arch/parisc/defconfig b/arch/parisc/defconfig
index b38b58e..c07927a 100644
--- a/arch/parisc/defconfig
+++ b/arch/parisc/defconfig
@@ -428,7 +428,7 @@ # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
 # CONFIG_SCSI_IPS is not set
diff --git a/arch/powerpc/configs/chrp32_defconfig b/arch/powerpc/configs/chrp32_defconfig
index 0fa010a..be5fb8e 100644
--- a/arch/powerpc/configs/chrp32_defconfig
+++ b/arch/powerpc/configs/chrp32_defconfig
@@ -482,7 +482,7 @@ # CONFIG_SCSI_IN2000 is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index a456275..7a560bf 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -471,22 +471,22 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-CONFIG_SCSI_SATA=y
-# CONFIG_SCSI_SATA_AHCI is not set
-CONFIG_SCSI_SATA_SVW=y
-# CONFIG_SCSI_ATA_PIIX is not set
-# CONFIG_SCSI_SATA_MV is not set
-# CONFIG_SCSI_SATA_NV is not set
-# CONFIG_SCSI_PDC_ADMA is not set
-# CONFIG_SCSI_SATA_QSTOR is not set
-# CONFIG_SCSI_SATA_PROMISE is not set
-# CONFIG_SCSI_SATA_SX4 is not set
-# CONFIG_SCSI_SATA_SIL is not set
-# CONFIG_SCSI_SATA_SIL24 is not set
-# CONFIG_SCSI_SATA_SIS is not set
-# CONFIG_SCSI_SATA_ULI is not set
-# CONFIG_SCSI_SATA_VIA is not set
-# CONFIG_SCSI_SATA_VITESSE is not set
+CONFIG_ATA=y
+# CONFIG_SATA_AHCI is not set
+CONFIG_SATA_SVW=y
+# CONFIG_ATA_PIIX is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/powerpc/configs/iseries_defconfig b/arch/powerpc/configs/iseries_defconfig
index a95e455..076a7a6 100644
--- a/arch/powerpc/configs/iseries_defconfig
+++ b/arch/powerpc/configs/iseries_defconfig
@@ -452,7 +452,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/powerpc/configs/mpc7448_hpc2_defconfig b/arch/powerpc/configs/mpc7448_hpc2_defconfig
index 15a50f4..c03cc8b 100644
--- a/arch/powerpc/configs/mpc7448_hpc2_defconfig
+++ b/arch/powerpc/configs/mpc7448_hpc2_defconfig
@@ -392,22 +392,22 @@ # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-CONFIG_SCSI_SATA=y
-# CONFIG_SCSI_SATA_AHCI is not set
-# CONFIG_SCSI_SATA_SVW is not set
-# CONFIG_SCSI_ATA_PIIX is not set
-CONFIG_SCSI_SATA_MV=y
-# CONFIG_SCSI_SATA_NV is not set
-# CONFIG_SCSI_PDC_ADMA is not set
-# CONFIG_SCSI_SATA_QSTOR is not set
-# CONFIG_SCSI_SATA_PROMISE is not set
-# CONFIG_SCSI_SATA_SX4 is not set
-# CONFIG_SCSI_SATA_SIL is not set
-# CONFIG_SCSI_SATA_SIL24 is not set
-# CONFIG_SCSI_SATA_SIS is not set
-# CONFIG_SCSI_SATA_ULI is not set
-# CONFIG_SCSI_SATA_VIA is not set
-# CONFIG_SCSI_SATA_VITESSE is not set
+CONFIG_ATA=y
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SVW is not set
+# CONFIG_ATA_PIIX is not set
+CONFIG_SATA_MV=y
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/powerpc/configs/mpc834x_itx_defconfig b/arch/powerpc/configs/mpc834x_itx_defconfig
index fc2d978..e9e22c2 100644
--- a/arch/powerpc/configs/mpc834x_itx_defconfig
+++ b/arch/powerpc/configs/mpc834x_itx_defconfig
@@ -460,23 +460,23 @@ # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-CONFIG_SCSI_SATA=y
-# CONFIG_SCSI_SATA_AHCI is not set
-# CONFIG_SCSI_SATA_SVW is not set
-# CONFIG_SCSI_ATA_PIIX is not set
-# CONFIG_SCSI_SATA_MV is not set
-# CONFIG_SCSI_SATA_NV is not set
-# CONFIG_SCSI_PDC_ADMA is not set
+CONFIG_ATA=y
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SVW is not set
+# CONFIG_ATA_PIIX is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
 # CONFIG_SCSI_HPTIOP is not set
-# CONFIG_SCSI_SATA_QSTOR is not set
-# CONFIG_SCSI_SATA_PROMISE is not set
-# CONFIG_SCSI_SATA_SX4 is not set
-CONFIG_SCSI_SATA_SIL=y
-# CONFIG_SCSI_SATA_SIL24 is not set
-# CONFIG_SCSI_SATA_SIS is not set
-# CONFIG_SCSI_SATA_ULI is not set
-# CONFIG_SCSI_SATA_VIA is not set
-# CONFIG_SCSI_SATA_VITESSE is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+CONFIG_SATA_SIL=y
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index 3545af9..ddd9a88 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -679,7 +679,7 @@ # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 395e498..fdb20d1 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -490,22 +490,22 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-CONFIG_SCSI_SATA=y
-# CONFIG_SCSI_SATA_AHCI is not set
-CONFIG_SCSI_SATA_SVW=y
-# CONFIG_SCSI_ATA_PIIX is not set
-# CONFIG_SCSI_SATA_MV is not set
-# CONFIG_SCSI_SATA_NV is not set
-# CONFIG_SCSI_PDC_ADMA is not set
-# CONFIG_SCSI_SATA_QSTOR is not set
-# CONFIG_SCSI_SATA_PROMISE is not set
-# CONFIG_SCSI_SATA_SX4 is not set
-# CONFIG_SCSI_SATA_SIL is not set
-# CONFIG_SCSI_SATA_SIL24 is not set
-# CONFIG_SCSI_SATA_SIS is not set
-# CONFIG_SCSI_SATA_ULI is not set
-# CONFIG_SCSI_SATA_VIA is not set
-# CONFIG_SCSI_SATA_VITESSE is not set
+CONFIG_ATA=y
+# CONFIG_SATA_AHCI is not set
+CONFIG_SATA_SVW=y
+# CONFIG_ATA_PIIX is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 31708ad..2f55c9d 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -486,7 +486,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/ppc/configs/bamboo_defconfig b/arch/ppc/configs/bamboo_defconfig
index 41fd393..611fad8 100644
--- a/arch/ppc/configs/bamboo_defconfig
+++ b/arch/ppc/configs/bamboo_defconfig
@@ -304,7 +304,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/ppc/configs/hdpu_defconfig b/arch/ppc/configs/hdpu_defconfig
index 956a178..57b0545 100644
--- a/arch/ppc/configs/hdpu_defconfig
+++ b/arch/ppc/configs/hdpu_defconfig
@@ -337,7 +337,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/ppc/configs/lopec_defconfig b/arch/ppc/configs/lopec_defconfig
index 85ea06b..b23672c 100644
--- a/arch/ppc/configs/lopec_defconfig
+++ b/arch/ppc/configs/lopec_defconfig
@@ -266,7 +266,7 @@ # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_MEGARAID is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
 # CONFIG_SCSI_DMX3191D is not set
diff --git a/arch/ppc/configs/mvme5100_defconfig b/arch/ppc/configs/mvme5100_defconfig
index 46776b9..a87a2a4 100644
--- a/arch/ppc/configs/mvme5100_defconfig
+++ b/arch/ppc/configs/mvme5100_defconfig
@@ -240,7 +240,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/ppc/configs/pplus_defconfig b/arch/ppc/configs/pplus_defconfig
index 5e459bc..5a4c194 100644
--- a/arch/ppc/configs/pplus_defconfig
+++ b/arch/ppc/configs/pplus_defconfig
@@ -217,7 +217,7 @@ # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_MEGARAID is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
 # CONFIG_SCSI_DMX3191D is not set
diff --git a/arch/ppc/configs/prep_defconfig b/arch/ppc/configs/prep_defconfig
index 4d33bee..80c3b21 100644
--- a/arch/ppc/configs/prep_defconfig
+++ b/arch/ppc/configs/prep_defconfig
@@ -526,7 +526,7 @@ # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_IN2000 is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_DTC3280 is not set
diff --git a/arch/ppc/configs/prpmc800_defconfig b/arch/ppc/configs/prpmc800_defconfig
index 613c266..59c7b78 100644
--- a/arch/ppc/configs/prpmc800_defconfig
+++ b/arch/ppc/configs/prpmc800_defconfig
@@ -207,7 +207,7 @@ # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_MEGARAID is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
 # CONFIG_SCSI_DMX3191D is not set
diff --git a/arch/ppc/configs/radstone_ppc7d_defconfig b/arch/ppc/configs/radstone_ppc7d_defconfig
index ca4d1fd..dbe6697 100644
--- a/arch/ppc/configs/radstone_ppc7d_defconfig
+++ b/arch/ppc/configs/radstone_ppc7d_defconfig
@@ -404,7 +404,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/ppc/configs/stx_gp3_defconfig b/arch/ppc/configs/stx_gp3_defconfig
index 3fedc43..88205a9 100644
--- a/arch/ppc/configs/stx_gp3_defconfig
+++ b/arch/ppc/configs/stx_gp3_defconfig
@@ -268,7 +268,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index f1d4591..96a511f 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -333,7 +333,7 @@ #
 # SCSI low-level drivers
 #
 # CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_DEBUG is not set
 CONFIG_ZFCP=y
 CONFIG_CCW=y
diff --git a/arch/sh/configs/sh03_defconfig b/arch/sh/configs/sh03_defconfig
index 078f78c..729a9c5 100644
--- a/arch/sh/configs/sh03_defconfig
+++ b/arch/sh/configs/sh03_defconfig
@@ -313,7 +313,7 @@ # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
 # CONFIG_SCSI_DMX3191D is not set
diff --git a/arch/sh64/configs/cayman_defconfig b/arch/sh64/configs/cayman_defconfig
index 48f2740..ea5bb20 100644
--- a/arch/sh64/configs/cayman_defconfig
+++ b/arch/sh64/configs/cayman_defconfig
@@ -237,7 +237,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/sparc/defconfig b/arch/sparc/defconfig
index a698562..6327ecb 100644
--- a/arch/sparc/defconfig
+++ b/arch/sparc/defconfig
@@ -196,7 +196,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_MEGARAID is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/arch/sparc64/defconfig b/arch/sparc64/defconfig
index 43d9229..3d05c25 100644
--- a/arch/sparc64/defconfig
+++ b/arch/sparc64/defconfig
@@ -437,7 +437,7 @@ # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
diff --git a/arch/x86_64/defconfig b/arch/x86_64/defconfig
index 840d5d9..ab33279 100644
--- a/arch/x86_64/defconfig
+++ b/arch/x86_64/defconfig
@@ -536,24 +536,24 @@ CONFIG_MEGARAID_MM=y
 CONFIG_MEGARAID_MAILBOX=y
 # CONFIG_MEGARAID_LEGACY is not set
 CONFIG_MEGARAID_SAS=y
-CONFIG_SCSI_SATA=y
-CONFIG_SCSI_SATA_AHCI=y
-# CONFIG_SCSI_SATA_SVW is not set
-CONFIG_SCSI_ATA_PIIX=y
-# CONFIG_SCSI_SATA_MV is not set
-CONFIG_SCSI_SATA_NV=y
-# CONFIG_SCSI_PDC_ADMA is not set
+CONFIG_ATA=y
+CONFIG_SATA_AHCI=y
+# CONFIG_SATA_SVW is not set
+CONFIG_ATA_PIIX=y
+# CONFIG_SATA_MV is not set
+CONFIG_SATA_NV=y
+# CONFIG_PDC_ADMA is not set
 # CONFIG_SCSI_HPTIOP is not set
-# CONFIG_SCSI_SATA_QSTOR is not set
-# CONFIG_SCSI_SATA_PROMISE is not set
-# CONFIG_SCSI_SATA_SX4 is not set
-CONFIG_SCSI_SATA_SIL=y
-# CONFIG_SCSI_SATA_SIL24 is not set
-# CONFIG_SCSI_SATA_SIS is not set
-# CONFIG_SCSI_SATA_ULI is not set
-CONFIG_SCSI_SATA_VIA=y
-# CONFIG_SCSI_SATA_VITESSE is not set
-CONFIG_SCSI_SATA_INTEL_COMBINED=y
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+CONFIG_SATA_SIL=y
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+CONFIG_SATA_VIA=y
+# CONFIG_SATA_VITESSE is not set
+CONFIG_SATA_INTEL_COMBINED=y
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index fb08bc9..9896fa3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1209,7 +1209,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
 
-#if defined(CONFIG_SCSI_SATA) || defined(CONFIG_SCSI_SATA_MODULE)
+#if defined(CONFIG_ATA) || defined(CONFIG_SATA_MODULE)
 
 /*
  *	If we are using libata we can drive this chip properly but must
@@ -1299,7 +1299,7 @@ static int __init combined_setup(char *s
 }
 __setup("combined_mode=", combined_setup);
 
-#ifdef CONFIG_SCSI_SATA_INTEL_COMBINED
+#ifdef CONFIG_SATA_INTEL_COMBINED
 static void __devinit quirk_intel_ide_combined(struct pci_dev *pdev)
 {
 	u8 prog, comb, tmp;
@@ -1392,7 +1392,7 @@ static void __devinit quirk_intel_ide_co
 		request_region(0x170, 8, "libata");	/* port 1 */
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,    PCI_ANY_ID,	  quirk_intel_ide_combined );
-#endif /* CONFIG_SCSI_SATA_INTEL_COMBINED */
+#endif /* CONFIG_SATA_INTEL_COMBINED */
 
 
 int pcie_mch_quirk;
