From: Brian King <brking@us.ibm.com>
Subject: [PATCH 1/1] libata: Build fix for drivers/scsi users
Date: Thu, 10 Aug 2006 10:15:59 -0500
Message-ID: <200608101516.k7AFG0Ov030312@d03av03.boulder.ibm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:1739 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161334AbWHJPQL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Aug 2006 11:16:11 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k7AFGB14009007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 11:16:11 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k7AFG11W268086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 09:16:01 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7AFG1fC030349
	for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 09:16:01 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, brking@us.ibm.com


When moving libata to drivers/ata, SCSI/SAS drivers were
broken. Alter the build process for libata to be done in
a similar manner to how scsi is done today.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 libata-dev-bjking1/drivers/ata/Makefile |   31 ++++++++++++++++---------------
 1 files changed, 16 insertions(+), 15 deletions(-)

diff -puN drivers/ata/Makefile~libata_build_fix drivers/ata/Makefile
--- libata-dev/drivers/ata/Makefile~libata_build_fix	2006-08-10 09:12:15.000000000 -0500
+++ libata-dev-bjking1/drivers/ata/Makefile	2006-08-10 09:12:15.000000000 -0500
@@ -1,19 +1,20 @@
+obj-$(CONFIG_ATA)		+= libata.o
 
-obj-$(CONFIG_SCSI_SATA_AHCI)	+= libata.o ahci.o
-obj-$(CONFIG_SCSI_SATA_SVW)	+= libata.o sata_svw.o
-obj-$(CONFIG_SCSI_ATA_PIIX)	+= libata.o ata_piix.o
-obj-$(CONFIG_SCSI_SATA_PROMISE)	+= libata.o sata_promise.o
-obj-$(CONFIG_SCSI_SATA_QSTOR)	+= libata.o sata_qstor.o
-obj-$(CONFIG_SCSI_SATA_SIL)	+= libata.o sata_sil.o
-obj-$(CONFIG_SCSI_SATA_SIL24)	+= libata.o sata_sil24.o
-obj-$(CONFIG_SCSI_SATA_VIA)	+= libata.o sata_via.o
-obj-$(CONFIG_SCSI_SATA_VITESSE)	+= libata.o sata_vsc.o
-obj-$(CONFIG_SCSI_SATA_SIS)	+= libata.o sata_sis.o
-obj-$(CONFIG_SCSI_SATA_SX4)	+= libata.o sata_sx4.o
-obj-$(CONFIG_SCSI_SATA_NV)	+= libata.o sata_nv.o
-obj-$(CONFIG_SCSI_SATA_ULI)	+= libata.o sata_uli.o
-obj-$(CONFIG_SCSI_SATA_MV)	+= libata.o sata_mv.o
-obj-$(CONFIG_SCSI_PDC_ADMA)	+= libata.o pdc_adma.o
+obj-$(CONFIG_SCSI_SATA_AHCI)	+= ahci.o
+obj-$(CONFIG_SCSI_SATA_SVW)	+= sata_svw.o
+obj-$(CONFIG_SCSI_ATA_PIIX)	+= ata_piix.o
+obj-$(CONFIG_SCSI_SATA_PROMISE)	+= sata_promise.o
+obj-$(CONFIG_SCSI_SATA_QSTOR)	+= sata_qstor.o
+obj-$(CONFIG_SCSI_SATA_SIL)	+= sata_sil.o
+obj-$(CONFIG_SCSI_SATA_SIL24)	+= sata_sil24.o
+obj-$(CONFIG_SCSI_SATA_VIA)	+= sata_via.o
+obj-$(CONFIG_SCSI_SATA_VITESSE)	+= sata_vsc.o
+obj-$(CONFIG_SCSI_SATA_SIS)	+= sata_sis.o
+obj-$(CONFIG_SCSI_SATA_SX4)	+= sata_sx4.o
+obj-$(CONFIG_SCSI_SATA_NV)	+= sata_nv.o
+obj-$(CONFIG_SCSI_SATA_ULI)	+= sata_uli.o
+obj-$(CONFIG_SCSI_SATA_MV)	+= sata_mv.o
+obj-$(CONFIG_SCSI_PDC_ADMA)	+= pdc_adma.o
 
 libata-objs	:= libata-core.o libata-scsi.o libata-bmdma.o libata-eh.o
 
_
