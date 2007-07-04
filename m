From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 10/10] libata: Integrate freeze/thaw with irq_on/off in LLDDs
Date: Wed, 04 Jul 2007 17:29:20 +0800
Message-ID: <468B6870.50308@tw.ibm.com>
References: <468B5C97.1000803@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:41243 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756565AbXGDJ32 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 05:29:28 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l649TQ86023899
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 05:29:26 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l649TQir262024
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 03:29:26 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l649TP9t013000
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 03:29:26 -0600
In-Reply-To: <468B5C97.1000803@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

Patch 10/10:

Integrate freeze/thaw with irq_on/off in LLDDs.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

The strange thing here is sata_via. It implements
svia_noop_freeze() that doesn't actually disable the irq.
This is related to the following bug:
http://bugzilla.kernel.org/show_bug.cgi?id=7415

Sine a lot has been changed since 2.6.19, maybe we
can remove such quirk at this momemt and ask the bug submitter
to test his VIA 8420 with the new code again.

diff -Nrup 09_integrate_irq_on_off/drivers/ata/ahci.c 10_integrate_irq_on_off_lldd/drivers/ata/ahci.c
--- 09_integrate_irq_on_off/drivers/ata/ahci.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/ahci.c	2007-07-04 14:30:27.000000000 +0800
@@ -223,8 +223,8 @@ static void ahci_port_stop(struct ata_po
 static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
-static void ahci_freeze(struct ata_port *ap);
-static void ahci_thaw(struct ata_port *ap);
+static void ahci_irq_on(struct ata_port *ap);
+static void ahci_irq_off(struct ata_port *ap);
 static void ahci_error_handler(struct ata_port *ap);
 static void ahci_vt8251_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
@@ -267,16 +267,13 @@ static const struct ata_port_operations 
 	.qc_issue		= ahci_qc_issue,
 
 	.irq_clear		= ahci_irq_clear,
-	.irq_on			= ata_dummy_irq_on,
-	.irq_off		= ata_dummy_irq_off,
+	.irq_on			= ahci_irq_on,
+	.irq_off		= ahci_irq_off,
 	.irq_ack		= ata_dummy_irq_ack,
 
 	.scr_read		= ahci_scr_read,
 	.scr_write		= ahci_scr_write,
 
-	.freeze			= ahci_freeze,
-	.thaw			= ahci_thaw,
-
 	.error_handler		= ahci_error_handler,
 	.post_internal_cmd	= ahci_post_internal_cmd,
 
@@ -302,16 +299,13 @@ static const struct ata_port_operations 
 	.qc_issue		= ahci_qc_issue,
 
 	.irq_clear		= ahci_irq_clear,
-	.irq_on			= ata_dummy_irq_on,
-	.irq_off		= ata_dummy_irq_off,
+	.irq_on			= ahci_irq_on,
+	.irq_off		= ahci_irq_off,
 	.irq_ack		= ata_dummy_irq_ack,
 
 	.scr_read		= ahci_scr_read,
 	.scr_write		= ahci_scr_write,
 
-	.freeze			= ahci_freeze,
-	.thaw			= ahci_thaw,
-
 	.error_handler		= ahci_vt8251_error_handler,
 	.post_internal_cmd	= ahci_post_internal_cmd,
 
@@ -1397,7 +1391,7 @@ static unsigned int ahci_qc_issue(struct
 	return 0;
 }
 
-static void ahci_freeze(struct ata_port *ap)
+static void ahci_irq_off(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
 
@@ -1405,7 +1399,7 @@ static void ahci_freeze(struct ata_port 
 	writel(0, port_mmio + PORT_IRQ_MASK);
 }
 
-static void ahci_thaw(struct ata_port *ap)
+static void ahci_irq_on(struct ata_port *ap)
 {
 	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
 	void __iomem *port_mmio = ahci_port_base(ap);
diff -Nrup 09_integrate_irq_on_off/drivers/ata/ata_generic.c 10_integrate_irq_on_off_lldd/drivers/ata/ata_generic.c
--- 09_integrate_irq_on_off/drivers/ata/ata_generic.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/ata_generic.c	2007-07-04 14:31:21.000000000 +0800
@@ -109,8 +109,6 @@ static struct ata_port_operations generi
 
 	.data_xfer	= ata_data_xfer,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_unknown,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/ata_piix.c 10_integrate_irq_on_off_lldd/drivers/ata/ata_piix.c
--- 09_integrate_irq_on_off/drivers/ata/ata_piix.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/ata_piix.c	2007-07-04 14:31:51.000000000 +0800
@@ -296,8 +296,6 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= piix_pata_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
@@ -331,8 +329,6 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= piix_pata_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ich_pata_cable_detect,
@@ -363,8 +359,6 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_ali.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_ali.c
--- 09_integrate_irq_on_off/drivers/ata/pata_ali.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_ali.c	2007-07-04 14:32:30.000000000 +0800
@@ -306,8 +306,6 @@ static struct ata_port_operations ali_ea
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -344,8 +342,6 @@ static struct ata_port_operations ali_20
 	.dev_select 	= ata_std_dev_select,
 	.dev_config	= ali_lock_sectors,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -384,8 +380,6 @@ static struct ata_port_operations ali_c2
 	.dev_select 	= ata_std_dev_select,
 	.dev_config	= ali_lock_sectors,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ali_c2_cable_detect,
@@ -423,8 +417,6 @@ static struct ata_port_operations ali_c5
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ali_c2_cable_detect,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_amd.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_amd.c
--- 09_integrate_irq_on_off/drivers/ata/pata_amd.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_amd.c	2007-07-04 14:33:01.000000000 +0800
@@ -337,8 +337,6 @@ static struct ata_port_operations amd33_
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -373,8 +371,6 @@ static struct ata_port_operations amd66_
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_unknown,
@@ -409,8 +405,6 @@ static struct ata_port_operations amd100
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_unknown,
@@ -445,8 +439,6 @@ static struct ata_port_operations amd133
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= amd_cable_detect,
@@ -481,8 +473,6 @@ static struct ata_port_operations nv100_
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= nv_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= nv_cable_detect,
@@ -517,8 +507,6 @@ static struct ata_port_operations nv133_
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= nv_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= nv_cable_detect,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_artop.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_artop.c
--- 09_integrate_irq_on_off/drivers/ata/pata_artop.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_artop.c	2007-07-04 14:33:36.000000000 +0800
@@ -340,8 +340,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= artop6210_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
@@ -375,8 +373,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= artop6260_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= artop6260_cable_detect,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_atiixp.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_atiixp.c
--- 09_integrate_irq_on_off/drivers/ata/pata_atiixp.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_atiixp.c	2007-07-04 14:33:48.000000000 +0800
@@ -242,8 +242,6 @@ static struct ata_port_operations atiixp
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= atiixp_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= atiixp_cable_detect,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_cmd640.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_cmd640.c
--- 09_integrate_irq_on_off/drivers/ata/pata_cmd640.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_cmd640.c	2007-07-04 14:34:02.000000000 +0800
@@ -193,8 +193,6 @@ static struct ata_port_operations cmd640
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_cmd64x.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_cmd64x.c
--- 09_integrate_irq_on_off/drivers/ata/pata_cmd64x.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_cmd64x.c	2007-07-04 14:34:21.000000000 +0800
@@ -279,8 +279,6 @@ static struct ata_port_operations cmd64x
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -315,8 +313,6 @@ static struct ata_port_operations cmd646
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -351,8 +347,6 @@ static struct ata_port_operations cmd648
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= cmd648_cable_detect,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_cs5520.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_cs5520.c
--- 09_integrate_irq_on_off/drivers/ata/pata_cs5520.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_cs5520.c	2007-07-04 14:34:36.000000000 +0800
@@ -168,8 +168,6 @@ static struct ata_port_operations cs5520
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_cs5530.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_cs5530.c
--- 09_integrate_irq_on_off/drivers/ata/pata_cs5530.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_cs5530.c	2007-07-04 14:34:53.000000000 +0800
@@ -195,8 +195,6 @@ static struct ata_port_operations cs5530
 	.bmdma_stop	= ata_bmdma_stop,
 	.bmdma_status 	= ata_bmdma_status,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_cs5535.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_cs5535.c
--- 09_integrate_irq_on_off/drivers/ata/pata_cs5535.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_cs5535.c	2007-07-04 14:35:40.000000000 +0800
@@ -187,8 +187,6 @@ static struct ata_port_operations cs5535
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= cs5535_cable_detect,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_cypress.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_cypress.c
--- 09_integrate_irq_on_off/drivers/ata/pata_cypress.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_cypress.c	2007-07-04 14:35:58.000000000 +0800
@@ -139,8 +139,6 @@ static struct ata_port_operations cy82c6
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_efar.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_efar.c
--- 09_integrate_irq_on_off/drivers/ata/pata_efar.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_efar.c	2007-07-04 14:36:10.000000000 +0800
@@ -261,8 +261,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= efar_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= efar_cable_detect,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_hpt366.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_hpt366.c
--- 09_integrate_irq_on_off/drivers/ata/pata_hpt366.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_hpt366.c	2007-07-04 14:36:23.000000000 +0800
@@ -323,8 +323,6 @@ static struct ata_port_operations hpt366
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= hpt36x_cable_detect,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_hpt37x.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_hpt37x.c
--- 09_integrate_irq_on_off/drivers/ata/pata_hpt37x.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_hpt37x.c	2007-07-04 14:36:54.000000000 +0800
@@ -655,8 +655,6 @@ static struct ata_port_operations hpt370
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= hpt37x_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 
@@ -695,8 +693,6 @@ static struct ata_port_operations hpt370
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= hpt37x_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 
@@ -736,8 +732,6 @@ static struct ata_port_operations hpt372
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= hpt37x_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 
@@ -777,8 +771,6 @@ static struct ata_port_operations hpt374
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= hpt374_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_hpt3x2n.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_hpt3x2n.c
--- 09_integrate_irq_on_off/drivers/ata/pata_hpt3x2n.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_hpt3x2n.c	2007-07-04 14:37:10.000000000 +0800
@@ -371,8 +371,6 @@ static struct ata_port_operations hpt3x2
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= hpt3x2n_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= hpt3x2n_cable_detect,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_hpt3x3.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_hpt3x3.c
--- 09_integrate_irq_on_off/drivers/ata/pata_hpt3x3.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_hpt3x3.c	2007-07-04 14:37:24.000000000 +0800
@@ -114,8 +114,6 @@ static struct ata_port_operations hpt3x3
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_icside.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_icside.c
--- 09_integrate_irq_on_off/drivers/ata/pata_icside.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_icside.c	2007-07-04 14:37:35.000000000 +0800
@@ -395,8 +395,6 @@ static struct ata_port_operations pata_i
 	.qc_prep		= ata_noop_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= pata_icside_bmdma_stop,
 
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_isapnp.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_isapnp.c
--- 09_integrate_irq_on_off/drivers/ata/pata_isapnp.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_isapnp.c	2007-07-04 14:37:51.000000000 +0800
@@ -45,8 +45,6 @@ static struct ata_port_operations isapnp
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_it8213.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_it8213.c
--- 09_integrate_irq_on_off/drivers/ata/pata_it8213.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_it8213.c	2007-07-04 14:38:05.000000000 +0800
@@ -271,8 +271,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= it8213_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= it8213_cable_detect,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_it821x.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_it821x.c
--- 09_integrate_irq_on_off/drivers/ata/pata_it821x.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_it821x.c	2007-07-04 14:38:21.000000000 +0800
@@ -629,8 +629,6 @@ static struct ata_port_operations it821x
 	.dev_select 	= ata_std_dev_select,
 	.dev_config	= it821x_dev_config,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_unknown,
@@ -667,8 +665,6 @@ static struct ata_port_operations it821x
 	.check_atapi_dma= it821x_check_atapi_dma,
 	.dev_select 	= it821x_passthru_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_unknown,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_ixp4xx_cf.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_ixp4xx_cf.c
--- 09_integrate_irq_on_off/drivers/ata/pata_ixp4xx_cf.c	2007-07-04 13:17:13.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_ixp4xx_cf.c	2007-07-04 14:38:33.000000000 +0800
@@ -131,9 +131,6 @@ static struct ata_port_operations ixp4xx
 	.data_xfer	= ixp4xx_mmio_data_xfer,
 	.cable_detect	= ata_cable_40wire,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-
 	.irq_clear	= ixp4xx_irq_clear,
 	.irq_on		= ata_irq_on,
 	.irq_off	= ata_irq_off,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_jmicron.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_jmicron.c
--- 09_integrate_irq_on_off/drivers/ata/pata_jmicron.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_jmicron.c	2007-07-04 14:38:49.000000000 +0800
@@ -150,8 +150,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= jmicron_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_legacy.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_legacy.c
--- 09_integrate_irq_on_off/drivers/ata/pata_legacy.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_legacy.c	2007-07-04 14:39:19.000000000 +0800
@@ -158,8 +158,6 @@ static struct ata_port_operations simple
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -189,8 +187,6 @@ static struct ata_port_operations legacy
 	.dev_select 	= ata_std_dev_select,
 	.cable_detect	= ata_cable_40wire,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 
@@ -305,8 +301,6 @@ static struct ata_port_operations pdc202
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -362,8 +356,6 @@ static struct ata_port_operations ht6560
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -430,8 +422,6 @@ static struct ata_port_operations ht6560
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -553,8 +543,6 @@ static struct ata_port_operations opti82
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -688,8 +676,6 @@ static struct ata_port_operations opti82
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_marvell.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_marvell.c
--- 09_integrate_irq_on_off/drivers/ata/pata_marvell.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_marvell.c	2007-07-04 14:39:37.000000000 +0800
@@ -119,8 +119,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= marvell_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= marvell_cable_detect,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_mpc52xx.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_mpc52xx.c
--- 09_integrate_irq_on_off/drivers/ata/pata_mpc52xx.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_mpc52xx.c	2007-07-04 14:39:49.000000000 +0800
@@ -290,8 +290,6 @@ static struct ata_port_operations mpc52x
 	.tf_read		= ata_tf_read,
 	.check_status		= ata_check_status,
 	.exec_command		= ata_exec_command,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= mpc52xx_ata_error_handler,
 	.cable_detect		= ata_cable_40wire,
 	.qc_prep		= ata_qc_prep,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_mpiix.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_mpiix.c
--- 09_integrate_irq_on_off/drivers/ata/pata_mpiix.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_mpiix.c	2007-07-04 14:40:02.000000000 +0800
@@ -177,8 +177,6 @@ static struct ata_port_operations mpiix_
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= mpiix_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_netcell.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_netcell.c
--- 09_integrate_irq_on_off/drivers/ata/pata_netcell.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_netcell.c	2007-07-04 14:40:14.000000000 +0800
@@ -49,8 +49,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_80wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_ns87410.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_ns87410.c
--- 09_integrate_irq_on_off/drivers/ata/pata_ns87410.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_ns87410.c	2007-07-04 14:40:29.000000000 +0800
@@ -170,8 +170,6 @@ static struct ata_port_operations ns8741
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ns87410_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_oldpiix.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_oldpiix.c
--- 09_integrate_irq_on_off/drivers/ata/pata_oldpiix.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_oldpiix.c	2007-07-04 14:40:41.000000000 +0800
@@ -248,8 +248,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= oldpiix_pata_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_opti.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_opti.c
--- 09_integrate_irq_on_off/drivers/ata/pata_opti.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_opti.c	2007-07-04 14:40:55.000000000 +0800
@@ -190,8 +190,6 @@ static struct ata_port_operations opti_p
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= opti_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_optidma.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_optidma.c
--- 09_integrate_irq_on_off/drivers/ata/pata_optidma.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_optidma.c	2007-07-04 14:41:15.000000000 +0800
@@ -376,8 +376,6 @@ static struct ata_port_operations optidm
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.error_handler	= optidma_error_handler,
 	.set_mode	= optidma_set_mode,
@@ -413,8 +411,6 @@ static struct ata_port_operations optipl
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.error_handler	= optidma_error_handler,
 	.set_mode	= optidma_set_mode,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_pcmcia.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_pcmcia.c
--- 09_integrate_irq_on_off/drivers/ata/pata_pcmcia.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_pcmcia.c	2007-07-04 14:41:25.000000000 +0800
@@ -114,8 +114,6 @@ static struct ata_port_operations pcmcia
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_pdc2027x.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_pdc2027x.c
--- 09_integrate_irq_on_off/drivers/ata/pata_pdc2027x.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_pdc2027x.c	2007-07-04 14:41:39.000000000 +0800
@@ -165,8 +165,6 @@ static struct ata_port_operations pdc202
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= pdc2027x_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= pdc2027x_cable_detect,
@@ -201,8 +199,6 @@ static struct ata_port_operations pdc202
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= pdc2027x_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= pdc2027x_cable_detect,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_pdc202xx_old.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_pdc202xx_old.c
--- 09_integrate_irq_on_off/drivers/ata/pata_pdc202xx_old.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_pdc202xx_old.c	2007-07-04 14:41:51.000000000 +0800
@@ -257,8 +257,6 @@ static struct ata_port_operations pdc202
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -293,8 +291,6 @@ static struct ata_port_operations pdc202
 	.dev_select 	= ata_std_dev_select,
 	.dev_config	= pdc2026x_dev_config,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= pdc2026x_cable_detect,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_platform.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_platform.c
--- 09_integrate_irq_on_off/drivers/ata/pata_platform.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_platform.c	2007-07-04 14:42:00.000000000 +0800
@@ -78,8 +78,6 @@ static struct ata_port_operations pata_p
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_unknown,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_qdi.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_qdi.c
--- 09_integrate_irq_on_off/drivers/ata/pata_qdi.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_qdi.c	2007-07-04 14:42:14.000000000 +0800
@@ -179,8 +179,6 @@ static struct ata_port_operations qdi650
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -208,8 +206,6 @@ static struct ata_port_operations qdi658
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_radisys.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_radisys.c
--- 09_integrate_irq_on_off/drivers/ata/pata_radisys.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_radisys.c	2007-07-04 14:42:26.000000000 +0800
@@ -214,8 +214,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_unknown,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_rz1000.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_rz1000.c
--- 09_integrate_irq_on_off/drivers/ata/pata_rz1000.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_rz1000.c	2007-07-04 14:42:37.000000000 +0800
@@ -91,8 +91,6 @@ static struct ata_port_operations rz1000
 
 	.data_xfer	= ata_data_xfer,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_sc1200.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_sc1200.c
--- 09_integrate_irq_on_off/drivers/ata/pata_sc1200.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_sc1200.c	2007-07-04 14:42:46.000000000 +0800
@@ -208,8 +208,6 @@ static struct ata_port_operations sc1200
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_scc.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_scc.c
--- 09_integrate_irq_on_off/drivers/ata/pata_scc.c	2007-07-04 13:20:30.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_scc.c	2007-07-04 14:43:51.000000000 +0800
@@ -789,20 +789,17 @@ static void scc_data_xfer (struct ata_de
  *	Note: Original code is ata_irq_on().
  */
 
-static u8 scc_irq_on (struct ata_port *ap)
+static void scc_irq_on (struct ata_port *ap)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
-	u8 tmp;
 
 	ap->ctl &= ~ATA_NIEN;
 	ap->last_ctl = ap->ctl;
 
 	out_be32(ioaddr->ctl_addr, ap->ctl);
-	tmp = ata_wait_idle(ap);
+	ata_wait_idle(ap);
 
 	ap->ops->irq_clear(ap);
-
-	return tmp;
 }
 
 /**
@@ -812,20 +809,17 @@ static u8 scc_irq_on (struct ata_port *a
  *	Note: Original code is ata_irq_off().
  */
 
-static u8 scc_irq_off (struct ata_port *ap)
+static void scc_irq_off (struct ata_port *ap)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
-	u8 tmp;
 
 	ap->ctl |= ATA_NIEN;
 	ap->last_ctl = ap->ctl;
 
 	out_be32(ioaddr->ctl_addr, ap->ctl);
-	tmp = ata_wait_idle(ap);
+	ata_wait_idle(ap);
 
 	ap->ops->irq_clear(ap);
-
-	return tmp;
 }
 
 /**
@@ -861,30 +855,6 @@ static u8 scc_irq_ack (struct ata_port *
 }
 
 /**
- *	scc_bmdma_freeze - Freeze BMDMA controller port
- *	@ap: port to freeze
- *
- *	Note: Original code is ata_bmdma_freeze().
- */
-
-static void scc_bmdma_freeze (struct ata_port *ap)
-{
-	scc_irq_off(ap);
-}
-
-/**
- *	scc_bmdma_thaw - Thaw BMDMA controller port
- *	@ap: port to thaw
- *
- *	Note: Original code is ata_bmdma_thaw().
- */
-
-static void scc_bmdma_thaw (struct ata_port *ap)
-{
-	scc_irq_on(ap);
-}
-
-/**
  *	scc_pata_prereset - prepare for reset
  *	@ap: ATA port to be reset
  *	@deadline: deadline jiffies for the operation
@@ -1030,8 +1000,6 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
-	.freeze			= scc_bmdma_freeze,
-	.thaw			= scc_bmdma_thaw,
 	.error_handler		= scc_error_handler,
 	.post_internal_cmd	= scc_bmdma_stop,
 
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_serverworks.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_serverworks.c
--- 09_integrate_irq_on_off/drivers/ata/pata_serverworks.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_serverworks.c	2007-07-04 14:44:14.000000000 +0800
@@ -329,8 +329,6 @@ static struct ata_port_operations server
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= serverworks_cable_detect,
@@ -366,8 +364,6 @@ static struct ata_port_operations server
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= serverworks_cable_detect,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_sil680.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_sil680.c
--- 09_integrate_irq_on_off/drivers/ata/pata_sil680.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_sil680.c	2007-07-04 14:44:24.000000000 +0800
@@ -245,8 +245,6 @@ static struct ata_port_operations sil680
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= sil680_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= sil680_cable_detect,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_sis.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_sis.c
--- 09_integrate_irq_on_off/drivers/ata/pata_sis.c	2007-07-04 12:57:09.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_sis.c	2007-07-04 14:44:46.000000000 +0800
@@ -538,8 +538,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= sis_133_cable_detect,
@@ -573,8 +571,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= sis_133_cable_detect,
@@ -608,8 +604,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= sis_66_cable_detect,
@@ -643,8 +637,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= sis_66_cable_detect,
@@ -679,8 +671,6 @@ static const struct ata_port_operations 
 	.dev_select		= ata_std_dev_select,
 	.cable_detect		= sis_66_cable_detect,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
@@ -713,8 +703,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_sl82c105.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_sl82c105.c
--- 09_integrate_irq_on_off/drivers/ata/pata_sl82c105.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_sl82c105.c	2007-07-04 14:44:58.000000000 +0800
@@ -234,8 +234,6 @@ static struct ata_port_operations sl82c1
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= sl82c105_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_triflex.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_triflex.c
--- 09_integrate_irq_on_off/drivers/ata/pata_triflex.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_triflex.c	2007-07-04 14:45:15.000000000 +0800
@@ -207,8 +207,6 @@ static struct ata_port_operations trifle
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= triflex_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_via.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_via.c
--- 09_integrate_irq_on_off/drivers/ata/pata_via.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_via.c	2007-07-04 14:45:25.000000000 +0800
@@ -344,8 +344,6 @@ static struct ata_port_operations via_po
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= via_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= via_cable_detect,
@@ -381,8 +379,6 @@ static struct ata_port_operations via_po
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= via_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= via_cable_detect,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pata_winbond.c 10_integrate_irq_on_off_lldd/drivers/ata/pata_winbond.c
--- 09_integrate_irq_on_off/drivers/ata/pata_winbond.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pata_winbond.c	2007-07-04 14:45:34.000000000 +0800
@@ -147,8 +147,6 @@ static struct ata_port_operations winbon
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/pdc_adma.c 10_integrate_irq_on_off_lldd/drivers/ata/pdc_adma.c
--- 09_integrate_irq_on_off/drivers/ata/pdc_adma.c	2007-07-04 13:17:13.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/pdc_adma.c	2007-07-04 14:45:51.000000000 +0800
@@ -171,8 +171,6 @@ static const struct ata_port_operations 
 	.qc_issue		= adma_qc_issue,
 	.eng_timeout		= adma_eng_timeout,
 	.data_xfer		= ata_data_xfer,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.irq_clear		= adma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_off		= ata_irq_off,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/sata_inic162x.c 10_integrate_irq_on_off_lldd/drivers/ata/sata_inic162x.c
--- 09_integrate_irq_on_off/drivers/ata/sata_inic162x.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/sata_inic162x.c	2007-07-04 14:46:51.000000000 +0800
@@ -388,7 +388,7 @@ static unsigned int inic_qc_issue(struct
 	return ata_qc_issue_prot(qc);
 }
 
-static void inic_freeze(struct ata_port *ap)
+static void inic_irq_off(struct ata_port *ap)
 {
 	void __iomem *port_base = inic_port_base(ap);
 
@@ -400,7 +400,7 @@ static void inic_freeze(struct ata_port 
 	readb(port_base + PORT_IRQ_STAT); /* flush */
 }
 
-static void inic_thaw(struct ata_port *ap)
+static void inic_irq_on(struct ata_port *ap)
 {
 	void __iomem *port_base = inic_port_base(ap);
 
@@ -566,16 +566,14 @@ static struct ata_port_operations inic_p
 	.bmdma_status		= inic_bmdma_status,
 
 	.irq_clear		= inic_irq_clear,
-	.irq_on			= ata_irq_on,
-	.irq_off		= ata_irq_off,
+	.irq_on			= inic_irq_on,
+	.irq_off		= inic_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.qc_prep	 	= ata_qc_prep,
 	.qc_issue		= inic_qc_issue,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= inic_freeze,
-	.thaw			= inic_thaw,
 	.error_handler		= inic_error_handler,
 	.post_internal_cmd	= inic_post_internal_cmd,
 	.dev_config		= inic_dev_config,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/sata_mv.c 10_integrate_irq_on_off_lldd/drivers/ata/sata_mv.c
--- 09_integrate_irq_on_off/drivers/ata/sata_mv.c	2007-07-04 13:17:13.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/sata_mv.c	2007-07-04 14:47:46.000000000 +0800
@@ -453,9 +453,6 @@ static const struct ata_port_operations 
 
 	.eng_timeout		= mv_eng_timeout,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-
 	.irq_clear		= mv_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_off		= ata_irq_off,
@@ -486,9 +483,6 @@ static const struct ata_port_operations 
 
 	.eng_timeout		= mv_eng_timeout,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-
 	.irq_clear		= mv_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_off		= ata_irq_off,
@@ -519,9 +513,6 @@ static const struct ata_port_operations 
 
 	.eng_timeout		= mv_eng_timeout,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-
 	.irq_clear		= mv_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_off		= ata_irq_off,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/sata_nv.c 10_integrate_irq_on_off_lldd/drivers/ata/sata_nv.c
--- 09_integrate_irq_on_off/drivers/ata/sata_nv.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/sata_nv.c	2007-07-04 14:51:54.000000000 +0800
@@ -239,10 +239,10 @@ static irqreturn_t nv_ck804_interrupt(in
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
-static void nv_nf2_freeze(struct ata_port *ap);
-static void nv_nf2_thaw(struct ata_port *ap);
-static void nv_ck804_freeze(struct ata_port *ap);
-static void nv_ck804_thaw(struct ata_port *ap);
+static void nv_nf2_irq_on(struct ata_port *ap);
+static void nv_nf2_irq_off(struct ata_port *ap);
+static void nv_ck804_irq_on(struct ata_port *ap);
+static void nv_ck804_irq_off(struct ata_port *ap);
 static void nv_error_handler(struct ata_port *ap);
 static int nv_adma_slave_config(struct scsi_device *sdev);
 static int nv_adma_check_atapi_dma(struct ata_queued_cmd *qc);
@@ -256,8 +256,8 @@ static void nv_adma_port_stop(struct ata
 static int nv_adma_port_suspend(struct ata_port *ap, pm_message_t mesg);
 static int nv_adma_port_resume(struct ata_port *ap);
 #endif
-static void nv_adma_freeze(struct ata_port *ap);
-static void nv_adma_thaw(struct ata_port *ap);
+static void nv_adma_irq_on(struct ata_port *ap);
+static void nv_adma_irq_off(struct ata_port *ap);
 static void nv_adma_error_handler(struct ata_port *ap);
 static void nv_adma_host_stop(struct ata_host *host);
 static void nv_adma_post_internal_cmd(struct ata_queued_cmd *qc);
@@ -352,8 +352,6 @@ static const struct ata_port_operations 
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= nv_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.data_xfer		= ata_data_xfer,
@@ -379,14 +377,12 @@ static const struct ata_port_operations 
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.freeze			= nv_nf2_freeze,
-	.thaw			= nv_nf2_thaw,
 	.error_handler		= nv_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-	.irq_off		= ata_irq_off,
+	.irq_on			= nv_nf2_irq_on,
+	.irq_off		= nv_nf2_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
@@ -406,14 +402,12 @@ static const struct ata_port_operations 
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.freeze			= nv_ck804_freeze,
-	.thaw			= nv_ck804_thaw,
 	.error_handler		= nv_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-	.irq_off		= ata_irq_off,
+	.irq_on			= nv_ck804_irq_on,
+	.irq_off		= nv_ck804_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
@@ -435,14 +429,12 @@ static const struct ata_port_operations 
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= nv_adma_qc_prep,
 	.qc_issue		= nv_adma_qc_issue,
-	.freeze			= nv_adma_freeze,
-	.thaw			= nv_adma_thaw,
 	.error_handler		= nv_adma_error_handler,
 	.post_internal_cmd	= nv_adma_post_internal_cmd,
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= nv_adma_irq_clear,
-	.irq_on			= ata_irq_on,
-	.irq_off		= ata_irq_off,
+	.irq_on			= nv_adma_irq_on,
+	.irq_off		= nv_adma_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
@@ -911,13 +903,13 @@ static irqreturn_t nv_adma_interrupt(int
 	return IRQ_RETVAL(handled);
 }
 
-static void nv_adma_freeze(struct ata_port *ap)
+static void nv_adma_irq_off(struct ata_port *ap)
 {
 	struct nv_adma_port_priv *pp = ap->private_data;
 	void __iomem *mmio = pp->ctl_block;
 	u16 tmp;
 
-	nv_ck804_freeze(ap);
+	nv_ck804_irq_off(ap);
 
 	if (pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE)
 		return;
@@ -933,13 +925,13 @@ static void nv_adma_freeze(struct ata_po
 	readw( mmio + NV_ADMA_CTL );	/* flush posted write */
 }
 
-static void nv_adma_thaw(struct ata_port *ap)
+static void nv_adma_irq_on(struct ata_port *ap)
 {
 	struct nv_adma_port_priv *pp = ap->private_data;
 	void __iomem *mmio = pp->ctl_block;
 	u16 tmp;
 
-	nv_ck804_thaw(ap);
+	nv_ck804_irq_on(ap);
 
 	if (pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE)
 		return;
@@ -1411,7 +1403,7 @@ static void nv_scr_write (struct ata_por
 	iowrite32(val, ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
-static void nv_nf2_freeze(struct ata_port *ap)
+static void nv_nf2_irq_off(struct ata_port *ap)
 {
 	void __iomem *scr_addr = ap->host->ports[0]->ioaddr.scr_addr;
 	int shift = ap->port_no * NV_INT_PORT_SHIFT;
@@ -1422,7 +1414,7 @@ static void nv_nf2_freeze(struct ata_por
 	iowrite8(mask, scr_addr + NV_INT_ENABLE);
 }
 
-static void nv_nf2_thaw(struct ata_port *ap)
+static void nv_nf2_irq_on(struct ata_port *ap)
 {
 	void __iomem *scr_addr = ap->host->ports[0]->ioaddr.scr_addr;
 	int shift = ap->port_no * NV_INT_PORT_SHIFT;
@@ -1435,7 +1427,7 @@ static void nv_nf2_thaw(struct ata_port 
 	iowrite8(mask, scr_addr + NV_INT_ENABLE);
 }
 
-static void nv_ck804_freeze(struct ata_port *ap)
+static void nv_ck804_irq_off(struct ata_port *ap)
 {
 	void __iomem *mmio_base = ap->host->iomap[NV_MMIO_BAR];
 	int shift = ap->port_no * NV_INT_PORT_SHIFT;
@@ -1446,7 +1438,7 @@ static void nv_ck804_freeze(struct ata_p
 	writeb(mask, mmio_base + NV_INT_ENABLE_CK804);
 }
 
-static void nv_ck804_thaw(struct ata_port *ap)
+static void nv_ck804_irq_on(struct ata_port *ap)
 {
 	void __iomem *mmio_base = ap->host->iomap[NV_MMIO_BAR];
 	int shift = ap->port_no * NV_INT_PORT_SHIFT;
diff -Nrup 09_integrate_irq_on_off/drivers/ata/sata_promise.c 10_integrate_irq_on_off_lldd/drivers/ata/sata_promise.c
--- 09_integrate_irq_on_off/drivers/ata/sata_promise.c	2007-07-04 13:17:59.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/sata_promise.c	2007-07-04 14:53:38.000000000 +0800
@@ -142,8 +142,8 @@ static int pdc_check_atapi_dma(struct at
 static int pdc_old_sata_check_atapi_dma(struct ata_queued_cmd *qc);
 static void pdc_irq_clear(struct ata_port *ap);
 static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
-static void pdc_freeze(struct ata_port *ap);
-static void pdc_thaw(struct ata_port *ap);
+static void pdc_irq_on(struct ata_port *ap);
+static void pdc_irq_off(struct ata_port *ap);
 static void pdc_pata_error_handler(struct ata_port *ap);
 static void pdc_sata_error_handler(struct ata_port *ap);
 static void pdc_post_internal_cmd(struct ata_queued_cmd *qc);
@@ -179,15 +179,13 @@ static const struct ata_port_operations 
 
 	.qc_prep		= pdc_qc_prep,
 	.qc_issue		= pdc_qc_issue_prot,
-	.freeze			= pdc_freeze,
-	.thaw			= pdc_thaw,
 	.error_handler		= pdc_sata_error_handler,
 	.post_internal_cmd	= pdc_post_internal_cmd,
 	.cable_detect		= pdc_sata_cable_detect,
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= pdc_irq_clear,
-	.irq_on			= ata_irq_on,
-	.irq_off		= ata_irq_off,
+	.irq_on			= pdc_irq_on,
+	.irq_off		= pdc_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= pdc_sata_scr_read,
@@ -207,15 +205,13 @@ static const struct ata_port_operations 
 
 	.qc_prep		= pdc_qc_prep,
 	.qc_issue		= pdc_qc_issue_prot,
-	.freeze			= pdc_freeze,
-	.thaw			= pdc_thaw,
 	.error_handler		= pdc_sata_error_handler,
 	.post_internal_cmd	= pdc_post_internal_cmd,
 	.cable_detect		= pdc_sata_cable_detect,
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= pdc_irq_clear,
-	.irq_on			= ata_irq_on,
-	.irq_off		= ata_irq_off,
+	.irq_on			= pdc_irq_on,
+	.irq_off		= pdc_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= pdc_sata_scr_read,
@@ -234,15 +230,13 @@ static const struct ata_port_operations 
 
 	.qc_prep		= pdc_qc_prep,
 	.qc_issue		= pdc_qc_issue_prot,
-	.freeze			= pdc_freeze,
-	.thaw			= pdc_thaw,
 	.error_handler		= pdc_pata_error_handler,
 	.post_internal_cmd	= pdc_post_internal_cmd,
 	.cable_detect		= pdc_pata_cable_detect,
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= pdc_irq_clear,
-	.irq_on			= ata_irq_on,
-	.irq_off		= ata_irq_off,
+	.irq_on			= pdc_irq_on,
+	.irq_off		= pdc_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= pdc_common_port_start,
@@ -574,7 +568,7 @@ static void pdc_qc_prep(struct ata_queue
 	}
 }
 
-static void pdc_freeze(struct ata_port *ap)
+static void pdc_irq_off(struct ata_port *ap)
 {
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
 	u32 tmp;
@@ -585,7 +579,7 @@ static void pdc_freeze(struct ata_port *
 	readl(mmio + PDC_CTLSTAT); /* flush */
 }
 
-static void pdc_thaw(struct ata_port *ap)
+static void pdc_irq_on(struct ata_port *ap)
 {
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
 	u32 tmp;
diff -Nrup 09_integrate_irq_on_off/drivers/ata/sata_qstor.c 10_integrate_irq_on_off_lldd/drivers/ata/sata_qstor.c
--- 09_integrate_irq_on_off/drivers/ata/sata_qstor.c	2007-07-04 13:17:13.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/sata_qstor.c	2007-07-04 14:53:52.000000000 +0800
@@ -157,8 +157,6 @@ static const struct ata_port_operations 
 	.qc_issue		= qs_qc_issue,
 	.data_xfer		= ata_data_xfer,
 	.eng_timeout		= qs_eng_timeout,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.irq_clear		= qs_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_off		= ata_irq_off,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/sata_sil.c 10_integrate_irq_on_off_lldd/drivers/ata/sata_sil.c
--- 09_integrate_irq_on_off/drivers/ata/sata_sil.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/sata_sil.c	2007-07-04 14:54:36.000000000 +0800
@@ -118,8 +118,8 @@ static void sil_dev_config(struct ata_de
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int sil_set_mode (struct ata_port *ap, struct ata_device **r_failed);
-static void sil_freeze(struct ata_port *ap);
-static void sil_thaw(struct ata_port *ap);
+static void sil_irq_on(struct ata_port *ap);
+static void sil_irq_off(struct ata_port *ap);
 
 
 static const struct pci_device_id sil_pci_tbl[] = {
@@ -200,13 +200,11 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
-	.freeze			= sil_freeze,
-	.thaw			= sil_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-	.irq_off		= ata_irq_off,
+	.irq_on			= sil_irq_on,
+	.irq_off		= sil_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= sil_scr_read,
 	.scr_write		= sil_scr_write,
@@ -491,7 +489,7 @@ static irqreturn_t sil_interrupt(int irq
 	return IRQ_RETVAL(handled);
 }
 
-static void sil_freeze(struct ata_port *ap)
+static void sil_irq_off(struct ata_port *ap)
 {
 	void __iomem *mmio_base = ap->host->iomap[SIL_MMIO_BAR];
 	u32 tmp;
@@ -506,7 +504,7 @@ static void sil_freeze(struct ata_port *
 	readl(mmio_base + SIL_SYSCFG);	/* flush */
 }
 
-static void sil_thaw(struct ata_port *ap)
+static void sil_irq_on(struct ata_port *ap)
 {
 	void __iomem *mmio_base = ap->host->iomap[SIL_MMIO_BAR];
 	u32 tmp;
diff -Nrup 09_integrate_irq_on_off/drivers/ata/sata_sil24.c 10_integrate_irq_on_off_lldd/drivers/ata/sata_sil24.c
--- 09_integrate_irq_on_off/drivers/ata/sata_sil24.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/sata_sil24.c	2007-07-04 14:55:32.000000000 +0800
@@ -332,8 +332,8 @@ static void sil24_tf_read(struct ata_por
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
 static void sil24_irq_clear(struct ata_port *ap);
-static void sil24_freeze(struct ata_port *ap);
-static void sil24_thaw(struct ata_port *ap);
+static void sil24_irq_on(struct ata_port *ap);
+static void sil24_irq_off(struct ata_port *ap);
 static void sil24_error_handler(struct ata_port *ap);
 static void sil24_post_internal_cmd(struct ata_queued_cmd *qc);
 static int sil24_port_start(struct ata_port *ap);
@@ -398,15 +398,13 @@ static const struct ata_port_operations 
 	.qc_issue		= sil24_qc_issue,
 
 	.irq_clear		= sil24_irq_clear,
-	.irq_on			= ata_dummy_irq_on,
-	.irq_off		= ata_dummy_irq_off,
+	.irq_on			= sil24_irq_on,
+	.irq_off		= sil24_irq_off,
 	.irq_ack		= ata_dummy_irq_ack,
 
 	.scr_read		= sil24_scr_read,
 	.scr_write		= sil24_scr_write,
 
-	.freeze			= sil24_freeze,
-	.thaw			= sil24_thaw,
 	.error_handler		= sil24_error_handler,
 	.post_internal_cmd	= sil24_post_internal_cmd,
 
@@ -729,7 +727,7 @@ static void sil24_irq_clear(struct ata_p
 	/* unused */
 }
 
-static void sil24_freeze(struct ata_port *ap)
+static void sil24_irq_off(struct ata_port *ap)
 {
 	void __iomem *port = ap->ioaddr.cmd_addr;
 
@@ -739,7 +737,7 @@ static void sil24_freeze(struct ata_port
 	writel(0xffff, port + PORT_IRQ_ENABLE_CLR);
 }
 
-static void sil24_thaw(struct ata_port *ap)
+static void sil24_irq_on(struct ata_port *ap)
 {
 	void __iomem *port = ap->ioaddr.cmd_addr;
 	u32 tmp;
diff -Nrup 09_integrate_irq_on_off/drivers/ata/sata_sis.c 10_integrate_irq_on_off_lldd/drivers/ata/sata_sis.c
--- 09_integrate_irq_on_off/drivers/ata/sata_sis.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/sata_sis.c	2007-07-04 14:55:46.000000000 +0800
@@ -117,8 +117,6 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_clear		= ata_bmdma_irq_clear,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/sata_svw.c 10_integrate_irq_on_off_lldd/drivers/ata/sata_svw.c
--- 09_integrate_irq_on_off/drivers/ata/sata_svw.c	2007-07-04 13:20:30.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/sata_svw.c	2007-07-04 14:55:59.000000000 +0800
@@ -336,8 +336,6 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_clear		= ata_bmdma_irq_clear,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/sata_sx4.c 10_integrate_irq_on_off_lldd/drivers/ata/sata_sx4.c
--- 09_integrate_irq_on_off/drivers/ata/sata_sx4.c	2007-07-04 13:17:13.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/sata_sx4.c	2007-07-04 14:56:15.000000000 +0800
@@ -203,8 +203,6 @@ static const struct ata_port_operations 
 	.qc_issue		= pdc20621_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 	.eng_timeout		= pdc_eng_timeout,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.irq_clear		= pdc20621_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_off		= ata_irq_off,
diff -Nrup 09_integrate_irq_on_off/drivers/ata/sata_uli.c 10_integrate_irq_on_off_lldd/drivers/ata/sata_uli.c
--- 09_integrate_irq_on_off/drivers/ata/sata_uli.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/sata_uli.c	2007-07-04 14:56:28.000000000 +0800
@@ -110,8 +110,6 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
diff -Nrup 09_integrate_irq_on_off/drivers/ata/sata_via.c 10_integrate_irq_on_off_lldd/drivers/ata/sata_via.c
--- 09_integrate_irq_on_off/drivers/ata/sata_via.c	2007-07-04 12:09:29.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/sata_via.c	2007-07-04 15:49:44.000000000 +0800
@@ -74,7 +74,7 @@ enum {
 static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
-static void svia_noop_freeze(struct ata_port *ap);
+static void svia_irq_off(struct ata_port *ap);
 static void vt6420_error_handler(struct ata_port *ap);
 static int vt6421_pata_cable_detect(struct ata_port *ap);
 static void vt6421_set_pio_mode(struct ata_port *ap, struct ata_device *adev);
@@ -139,14 +139,12 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= svia_noop_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= vt6420_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
-	.irq_off		= ata_irq_off,
+	.irq_off		= svia_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -173,8 +171,6 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= vt6421_pata_cable_detect,
@@ -205,8 +201,6 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_sata,
@@ -266,13 +260,17 @@ static void svia_scr_write (struct ata_p
 	iowrite32(val, ap->ioaddr.scr_addr + (4 * sc_reg));
 }
 
-static void svia_noop_freeze(struct ata_port *ap)
+static void svia_irq_off(struct ata_port *ap)
 {
-	/* Some VIA controllers choke if ATA_NIEN is manipulated in
-	 * certain way.  Leave it alone and just clear pending IRQ.
-	 */
-	ata_chk_status(ap);
-	ata_bmdma_irq_clear(ap);
+	if (0) {
+		/* Some VIA controllers choke if ATA_NIEN is manipulated in
+		 * certain way.  Leave it alone and just clear pending IRQ.
+		 */
+		/* FIXME: http://bugzilla.kernel.org/show_bug.cgi?id=7415 */
+		ata_chk_status(ap);
+		ata_bmdma_irq_clear(ap);
+	} else
+		ata_irq_off(ap);
 }
 
 /**
diff -Nrup 09_integrate_irq_on_off/drivers/ata/sata_vsc.c 10_integrate_irq_on_off_lldd/drivers/ata/sata_vsc.c
--- 09_integrate_irq_on_off/drivers/ata/sata_vsc.c	2007-07-04 13:20:30.000000000 +0800
+++ 10_integrate_irq_on_off_lldd/drivers/ata/sata_vsc.c	2007-07-04 15:12:33.000000000 +0800
@@ -115,7 +115,7 @@ static void vsc_sata_scr_write (struct a
 }
 
 
-static void vsc_freeze(struct ata_port *ap)
+static void vsc_irq_off(struct ata_port *ap)
 {
 	void __iomem *mask_addr;
 
@@ -126,7 +126,7 @@ static void vsc_freeze(struct ata_port *
 }
 
 
-static void vsc_thaw(struct ata_port *ap)
+static void vsc_irq_on(struct ata_port *ap)
 {
 	void __iomem *mask_addr;
 
@@ -304,13 +304,11 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
-	.freeze			= vsc_freeze,
-	.thaw			= vsc_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-	.irq_off		= ata_irq_off,
+	.irq_on			= vsc_irq_on,
+	.irq_off		= vsc_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= vsc_sata_scr_read,
 	.scr_write		= vsc_sata_scr_write,



