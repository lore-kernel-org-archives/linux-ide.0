From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 3/9] libata: add ->irq_off() to LLDDs
Date: Fri, 15 Jun 2007 11:19:06 +0800
Message-ID: <4672052A.2000205@tw.ibm.com>
References: <46720353.90209@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:56105 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115AbXFODTP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jun 2007 23:19:15 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5F3JD98031358
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 23:19:13 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5F3JCAk247110
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 21:19:12 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5F3JCuc030839
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 21:19:12 -0600
In-Reply-To: <46720353.90209@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>
Cc: Doug Maxey <dwm@enoyolf.org>

Patch 3/9: 

Minor patch to add the newly added ->irq_off() to LLDDs.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nrup 02_add_irq_off/drivers/ata/ahci.c 03_add_irq_off_lldd/drivers/ata/ahci.c
--- 02_add_irq_off/drivers/ata/ahci.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/ahci.c	2007-06-11 17:37:24.000000000 +0800
@@ -268,6 +268,7 @@ static const struct ata_port_operations 
 
 	.irq_clear		= ahci_irq_clear,
 	.irq_on			= ata_dummy_irq_on,
+	.irq_off		= ata_dummy_irq_off,
 	.irq_ack		= ata_dummy_irq_ack,
 
 	.scr_read		= ahci_scr_read,
@@ -302,6 +303,7 @@ static const struct ata_port_operations 
 
 	.irq_clear		= ahci_irq_clear,
 	.irq_on			= ata_dummy_irq_on,
+	.irq_off		= ata_dummy_irq_off,
 	.irq_ack		= ata_dummy_irq_ack,
 
 	.scr_read		= ahci_scr_read,
diff -Nrup 02_add_irq_off/drivers/ata/ata_generic.c 03_add_irq_off_lldd/drivers/ata/ata_generic.c
--- 02_add_irq_off/drivers/ata/ata_generic.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/ata_generic.c	2007-06-11 17:46:08.000000000 +0800
@@ -121,6 +121,7 @@ static struct ata_port_operations generi
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/ata_piix.c 03_add_irq_off_lldd/drivers/ata/ata_piix.c
--- 02_add_irq_off/drivers/ata/ata_piix.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/ata_piix.c	2007-06-11 17:37:24.000000000 +0800
@@ -305,6 +305,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -339,6 +340,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -369,6 +371,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_ali.c 03_add_irq_off_lldd/drivers/ata/pata_ali.c
--- 02_add_irq_off/drivers/ata/pata_ali.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_ali.c	2007-06-11 17:37:24.000000000 +0800
@@ -320,6 +320,7 @@ static struct ata_port_operations ali_ea
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -362,6 +363,7 @@ static struct ata_port_operations ali_20
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -401,6 +403,7 @@ static struct ata_port_operations ali_c2
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -439,6 +442,7 @@ static struct ata_port_operations ali_c5
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_amd.c 03_add_irq_off_lldd/drivers/ata/pata_amd.c
--- 02_add_irq_off/drivers/ata/pata_amd.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_amd.c	2007-06-11 17:37:24.000000000 +0800
@@ -356,6 +356,7 @@ static struct ata_port_operations amd33_
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -391,6 +392,7 @@ static struct ata_port_operations amd66_
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -426,6 +428,7 @@ static struct ata_port_operations amd100
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -461,6 +464,7 @@ static struct ata_port_operations amd133
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -496,6 +500,7 @@ static struct ata_port_operations nv100_
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -531,6 +536,7 @@ static struct ata_port_operations nv133_
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_artop.c 03_add_irq_off_lldd/drivers/ata/pata_artop.c
--- 02_add_irq_off/drivers/ata/pata_artop.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_artop.c	2007-06-11 17:37:24.000000000 +0800
@@ -358,6 +358,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -391,6 +392,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_atiixp.c 03_add_irq_off_lldd/drivers/ata/pata_atiixp.c
--- 02_add_irq_off/drivers/ata/pata_atiixp.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_atiixp.c	2007-06-11 17:37:24.000000000 +0800
@@ -261,6 +261,7 @@ static struct ata_port_operations atiixp
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_cmd640.c 03_add_irq_off_lldd/drivers/ata/pata_cmd640.c
--- 02_add_irq_off/drivers/ata/pata_cmd640.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_cmd640.c	2007-06-11 17:37:24.000000000 +0800
@@ -213,6 +213,7 @@ static struct ata_port_operations cmd640
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= cmd640_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_cmd64x.c 03_add_irq_off_lldd/drivers/ata/pata_cmd64x.c
--- 02_add_irq_off/drivers/ata/pata_cmd64x.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_cmd64x.c	2007-06-11 17:37:24.000000000 +0800
@@ -298,6 +298,7 @@ static struct ata_port_operations cmd64x
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -333,6 +334,7 @@ static struct ata_port_operations cmd646
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -368,6 +370,7 @@ static struct ata_port_operations cmd648
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_cs5520.c 03_add_irq_off_lldd/drivers/ata/pata_cs5520.c
--- 02_add_irq_off/drivers/ata/pata_cs5520.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_cs5520.c	2007-06-11 17:01:25.000000000 +0800
@@ -184,6 +184,7 @@ static struct ata_port_operations cs5520
 
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_cs5530.c 03_add_irq_off_lldd/drivers/ata/pata_cs5530.c
--- 02_add_irq_off/drivers/ata/pata_cs5530.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_cs5530.c	2007-06-11 17:01:52.000000000 +0800
@@ -209,6 +209,7 @@ static struct ata_port_operations cs5530
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_cs5535.c 03_add_irq_off_lldd/drivers/ata/pata_cs5535.c
--- 02_add_irq_off/drivers/ata/pata_cs5535.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_cs5535.c	2007-06-11 17:02:12.000000000 +0800
@@ -206,6 +206,7 @@ static struct ata_port_operations cs5535
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_cypress.c 03_add_irq_off_lldd/drivers/ata/pata_cypress.c
--- 02_add_irq_off/drivers/ata/pata_cypress.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_cypress.c	2007-06-11 17:03:02.000000000 +0800
@@ -158,6 +158,7 @@ static struct ata_port_operations cy82c6
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_efar.c 03_add_irq_off_lldd/drivers/ata/pata_efar.c
--- 02_add_irq_off/drivers/ata/pata_efar.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_efar.c	2007-06-11 17:03:24.000000000 +0800
@@ -278,6 +278,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_hpt366.c 03_add_irq_off_lldd/drivers/ata/pata_hpt366.c
--- 02_add_irq_off/drivers/ata/pata_hpt366.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_hpt366.c	2007-06-11 17:03:44.000000000 +0800
@@ -342,6 +342,7 @@ static struct ata_port_operations hpt366
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_hpt37x.c 03_add_irq_off_lldd/drivers/ata/pata_hpt37x.c
--- 02_add_irq_off/drivers/ata/pata_hpt37x.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_hpt37x.c	2007-06-11 17:05:52.000000000 +0800
@@ -673,6 +673,7 @@ static struct ata_port_operations hpt370
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -712,6 +713,7 @@ static struct ata_port_operations hpt370
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -752,6 +754,7 @@ static struct ata_port_operations hpt372
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -792,6 +795,7 @@ static struct ata_port_operations hpt374
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_hpt3x2n.c 03_add_irq_off_lldd/drivers/ata/pata_hpt3x2n.c
--- 02_add_irq_off/drivers/ata/pata_hpt3x2n.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_hpt3x2n.c	2007-06-11 17:06:17.000000000 +0800
@@ -390,6 +390,7 @@ static struct ata_port_operations hpt3x2
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_hpt3x3.c 03_add_irq_off_lldd/drivers/ata/pata_hpt3x3.c
--- 02_add_irq_off/drivers/ata/pata_hpt3x3.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_hpt3x3.c	2007-06-11 17:06:39.000000000 +0800
@@ -133,6 +133,7 @@ static struct ata_port_operations hpt3x3
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_icside.c 03_add_irq_off_lldd/drivers/ata/pata_icside.c
--- 02_add_irq_off/drivers/ata/pata_icside.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_icside.c	2007-06-11 17:07:31.000000000 +0800
@@ -402,6 +402,7 @@ static struct ata_port_operations pata_i
 
 	.irq_clear		= ata_dummy_noret,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= pata_icside_irq_ack,
 
 	.port_start		= pata_icside_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_isapnp.c 03_add_irq_off_lldd/drivers/ata/pata_isapnp.c
--- 02_add_irq_off/drivers/ata/pata_isapnp.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_isapnp.c	2007-06-11 17:07:51.000000000 +0800
@@ -58,6 +58,7 @@ static struct ata_port_operations isapnp
 
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_it8213.c 03_add_irq_off_lldd/drivers/ata/pata_it8213.c
--- 02_add_irq_off/drivers/ata/pata_it8213.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_it8213.c	2007-06-11 17:08:16.000000000 +0800
@@ -288,6 +288,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_it821x.c 03_add_irq_off_lldd/drivers/ata/pata_it821x.c
--- 02_add_irq_off/drivers/ata/pata_it821x.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_it821x.c	2007-06-11 17:08:45.000000000 +0800
@@ -653,6 +653,7 @@ static struct ata_port_operations it821x
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= it821x_port_start,
@@ -690,6 +691,7 @@ static struct ata_port_operations it821x
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_handler	= ata_interrupt,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= it821x_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_ixp4xx_cf.c 03_add_irq_off_lldd/drivers/ata/pata_ixp4xx_cf.c
--- 02_add_irq_off/drivers/ata/pata_ixp4xx_cf.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_ixp4xx_cf.c	2007-06-11 17:09:16.000000000 +0800
@@ -133,6 +133,7 @@ static struct ata_port_operations ixp4xx
 
 	.irq_clear	= ixp4xx_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_jmicron.c 03_add_irq_off_lldd/drivers/ata/pata_jmicron.c
--- 02_add_irq_off/drivers/ata/pata_jmicron.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_jmicron.c	2007-06-11 17:09:34.000000000 +0800
@@ -168,6 +168,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	/* Generic PATA PCI ATA helpers */
diff -Nrup 02_add_irq_off/drivers/ata/pata_legacy.c 03_add_irq_off_lldd/drivers/ata/pata_legacy.c
--- 02_add_irq_off/drivers/ata/pata_legacy.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_legacy.c	2007-06-11 17:10:05.000000000 +0800
@@ -172,6 +172,7 @@ static struct ata_port_operations simple
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -201,6 +202,7 @@ static struct ata_port_operations legacy
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -317,6 +319,7 @@ static struct ata_port_operations pdc202
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -373,6 +376,7 @@ static struct ata_port_operations ht6560
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -440,6 +444,7 @@ static struct ata_port_operations ht6560
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -562,6 +567,7 @@ static struct ata_port_operations opti82
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -696,6 +702,7 @@ static struct ata_port_operations opti82
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_marvell.c 03_add_irq_off_lldd/drivers/ata/pata_marvell.c
--- 02_add_irq_off/drivers/ata/pata_marvell.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_marvell.c	2007-06-11 17:10:22.000000000 +0800
@@ -138,6 +138,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	/* Generic PATA PCI ATA helpers */
diff -Nrup 02_add_irq_off/drivers/ata/pata_mpc52xx.c 03_add_irq_off_lldd/drivers/ata/pata_mpc52xx.c
--- 02_add_irq_off/drivers/ata/pata_mpc52xx.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_mpc52xx.c	2007-06-11 17:10:42.000000000 +0800
@@ -299,6 +299,7 @@ static struct ata_port_operations mpc52x
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.port_start		= ata_port_start,
 };
diff -Nrup 02_add_irq_off/drivers/ata/pata_mpiix.c 03_add_irq_off_lldd/drivers/ata/pata_mpiix.c
--- 02_add_irq_off/drivers/ata/pata_mpiix.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_mpiix.c	2007-06-11 17:10:59.000000000 +0800
@@ -189,6 +189,7 @@ static struct ata_port_operations mpiix_
 
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_netcell.c 03_add_irq_off_lldd/drivers/ata/pata_netcell.c
--- 02_add_irq_off/drivers/ata/pata_netcell.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_netcell.c	2007-06-11 17:11:22.000000000 +0800
@@ -68,6 +68,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	/* Generic PATA PCI ATA helpers */
diff -Nrup 02_add_irq_off/drivers/ata/pata_ns87410.c 03_add_irq_off_lldd/drivers/ata/pata_ns87410.c
--- 02_add_irq_off/drivers/ata/pata_ns87410.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_ns87410.c	2007-06-11 17:11:40.000000000 +0800
@@ -184,6 +184,7 @@ static struct ata_port_operations ns8741
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_oldpiix.c 03_add_irq_off_lldd/drivers/ata/pata_oldpiix.c
--- 02_add_irq_off/drivers/ata/pata_oldpiix.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_oldpiix.c	2007-06-11 17:11:55.000000000 +0800
@@ -265,6 +265,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_opti.c 03_add_irq_off_lldd/drivers/ata/pata_opti.c
--- 02_add_irq_off/drivers/ata/pata_opti.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_opti.c	2007-06-11 17:12:12.000000000 +0800
@@ -209,6 +209,7 @@ static struct ata_port_operations opti_p
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_optidma.c 03_add_irq_off_lldd/drivers/ata/pata_optidma.c
--- 02_add_irq_off/drivers/ata/pata_optidma.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_optidma.c	2007-06-11 17:12:39.000000000 +0800
@@ -396,6 +396,7 @@ static struct ata_port_operations optidm
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -432,6 +433,7 @@ static struct ata_port_operations optipl
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_pcmcia.c 03_add_irq_off_lldd/drivers/ata/pata_pcmcia.c
--- 02_add_irq_off/drivers/ata/pata_pcmcia.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_pcmcia.c	2007-06-11 17:12:55.000000000 +0800
@@ -127,6 +127,7 @@ static struct ata_port_operations pcmcia
 
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_pdc2027x.c 03_add_irq_off_lldd/drivers/ata/pata_pdc2027x.c
--- 02_add_irq_off/drivers/ata/pata_pdc2027x.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_pdc2027x.c	2007-06-11 17:13:24.000000000 +0800
@@ -173,6 +173,7 @@ static struct ata_port_operations pdc202
 
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -208,6 +209,7 @@ static struct ata_port_operations pdc202
 
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_pdc202xx_old.c 03_add_irq_off_lldd/drivers/ata/pata_pdc202xx_old.c
--- 02_add_irq_off/drivers/ata/pata_pdc202xx_old.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_pdc202xx_old.c	2007-06-11 17:13:54.000000000 +0800
@@ -275,6 +275,7 @@ static struct ata_port_operations pdc202
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -310,6 +311,7 @@ static struct ata_port_operations pdc202
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_platform.c 03_add_irq_off_lldd/drivers/ata/pata_platform.c
--- 02_add_irq_off/drivers/ata/pata_platform.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_platform.c	2007-06-11 17:14:11.000000000 +0800
@@ -91,6 +91,7 @@ static struct ata_port_operations pata_p
 
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_dummy_ret0,
diff -Nrup 02_add_irq_off/drivers/ata/pata_qdi.c 03_add_irq_off_lldd/drivers/ata/pata_qdi.c
--- 02_add_irq_off/drivers/ata/pata_qdi.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_qdi.c	2007-06-11 17:14:49.000000000 +0800
@@ -192,6 +192,7 @@ static struct ata_port_operations qdi650
 
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -220,6 +221,7 @@ static struct ata_port_operations qdi658
 
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_radisys.c 03_add_irq_off_lldd/drivers/ata/pata_radisys.c
--- 02_add_irq_off/drivers/ata/pata_radisys.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_radisys.c	2007-06-11 17:15:17.000000000 +0800
@@ -231,6 +231,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_rz1000.c 03_add_irq_off_lldd/drivers/ata/pata_rz1000.c
--- 02_add_irq_off/drivers/ata/pata_rz1000.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_rz1000.c	2007-06-11 17:15:45.000000000 +0800
@@ -100,6 +100,7 @@ static struct ata_port_operations rz1000
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_sc1200.c 03_add_irq_off_lldd/drivers/ata/pata_sc1200.c
--- 02_add_irq_off/drivers/ata/pata_sc1200.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_sc1200.c	2007-06-11 17:16:03.000000000 +0800
@@ -227,6 +227,7 @@ static struct ata_port_operations sc1200
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_scc.c 03_add_irq_off_lldd/drivers/ata/pata_scc.c
--- 02_add_irq_off/drivers/ata/pata_scc.c	2007-06-11 17:32:07.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_scc.c	2007-06-12 13:06:12.000000000 +0800
@@ -812,6 +812,29 @@ static u8 scc_irq_on (struct ata_port *a
 }
 
 /**
+ *	scc_irq_off - Disable interrupts on a port.
+ *	@ap: Port on which interrupts are disabled.
+ *
+ *	Note: Original code is ata_irq_off().
+ */
+
+static u8 scc_irq_off (struct ata_port *ap)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	u8 tmp;
+
+	ap->ctl |= ATA_NIEN;
+	ap->last_ctl = ap->ctl;
+
+	out_be32(ioaddr->ctl_addr, ap->ctl);
+	tmp = ata_wait_idle(ap);
+
+	ap->ops->irq_clear(ap);
+
+	return tmp;
+}
+
+/**
  *	scc_irq_ack - Acknowledge a device interrupt.
  *	@ap: Port on which interrupts are enabled.
  *
@@ -1020,6 +1043,7 @@ static const struct ata_port_operations 
 
 	.irq_clear		= scc_bmdma_irq_clear,
 	.irq_on			= scc_irq_on,
+	.irq_off		= scc_irq_off,
 	.irq_ack		= scc_irq_ack,
 
 	.port_start		= scc_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_serverworks.c 03_add_irq_off_lldd/drivers/ata/pata_serverworks.c
--- 02_add_irq_off/drivers/ata/pata_serverworks.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_serverworks.c	2007-06-11 17:18:28.000000000 +0800
@@ -348,6 +348,7 @@ static struct ata_port_operations server
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -384,6 +385,7 @@ static struct ata_port_operations server
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_sil680.c 03_add_irq_off_lldd/drivers/ata/pata_sil680.c
--- 02_add_irq_off/drivers/ata/pata_sil680.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_sil680.c	2007-06-11 17:19:04.000000000 +0800
@@ -264,6 +264,7 @@ static struct ata_port_operations sil680
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_sis.c 03_add_irq_off_lldd/drivers/ata/pata_sis.c
--- 02_add_irq_off/drivers/ata/pata_sis.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_sis.c	2007-06-11 17:19:37.000000000 +0800
@@ -555,6 +555,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -589,6 +590,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -623,6 +625,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -657,6 +660,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -691,6 +695,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_sl82c105.c 03_add_irq_off_lldd/drivers/ata/pata_sl82c105.c
--- 02_add_irq_off/drivers/ata/pata_sl82c105.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_sl82c105.c	2007-06-11 17:20:09.000000000 +0800
@@ -253,6 +253,7 @@ static struct ata_port_operations sl82c1
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_triflex.c 03_add_irq_off_lldd/drivers/ata/pata_triflex.c
--- 02_add_irq_off/drivers/ata/pata_triflex.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_triflex.c	2007-06-11 17:20:20.000000000 +0800
@@ -226,6 +226,7 @@ static struct ata_port_operations trifle
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_via.c 03_add_irq_off_lldd/drivers/ata/pata_via.c
--- 02_add_irq_off/drivers/ata/pata_via.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_via.c	2007-06-11 17:20:59.000000000 +0800
@@ -363,6 +363,7 @@ static struct ata_port_operations via_po
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -399,6 +400,7 @@ static struct ata_port_operations via_po
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pata_winbond.c 03_add_irq_off_lldd/drivers/ata/pata_winbond.c
--- 02_add_irq_off/drivers/ata/pata_winbond.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pata_winbond.c	2007-06-11 17:21:19.000000000 +0800
@@ -160,6 +160,7 @@ static struct ata_port_operations winbon
 
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/pdc_adma.c 03_add_irq_off_lldd/drivers/ata/pdc_adma.c
--- 02_add_irq_off/drivers/ata/pdc_adma.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/pdc_adma.c	2007-06-11 17:21:35.000000000 +0800
@@ -173,6 +173,7 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= adma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.port_start		= adma_port_start,
 	.port_stop		= adma_port_stop,
diff -Nrup 02_add_irq_off/drivers/ata/sata_inic162x.c 03_add_irq_off_lldd/drivers/ata/sata_inic162x.c
--- 02_add_irq_off/drivers/ata/sata_inic162x.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/sata_inic162x.c	2007-06-11 17:21:58.000000000 +0800
@@ -560,6 +560,7 @@ static struct ata_port_operations inic_p
 
 	.irq_clear		= inic_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.qc_prep	 	= ata_qc_prep,
diff -Nrup 02_add_irq_off/drivers/ata/sata_mv.c 03_add_irq_off_lldd/drivers/ata/sata_mv.c
--- 02_add_irq_off/drivers/ata/sata_mv.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/sata_mv.c	2007-06-11 17:22:29.000000000 +0800
@@ -455,6 +455,7 @@ static const struct ata_port_operations 
 
 	.irq_clear		= mv_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= mv5_scr_read,
@@ -484,6 +485,7 @@ static const struct ata_port_operations 
 
 	.irq_clear		= mv_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= mv_scr_read,
@@ -513,6 +515,7 @@ static const struct ata_port_operations 
 
 	.irq_clear		= mv_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= mv_scr_read,
diff -Nrup 02_add_irq_off/drivers/ata/sata_nv.c 03_add_irq_off_lldd/drivers/ata/sata_nv.c
--- 02_add_irq_off/drivers/ata/sata_nv.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/sata_nv.c	2007-06-11 17:23:09.000000000 +0800
@@ -358,6 +358,7 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
@@ -384,6 +385,7 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
@@ -410,6 +412,7 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
@@ -438,6 +441,7 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= nv_adma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
diff -Nrup 02_add_irq_off/drivers/ata/sata_promise.c 03_add_irq_off_lldd/drivers/ata/sata_promise.c
--- 02_add_irq_off/drivers/ata/sata_promise.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/sata_promise.c	2007-06-11 17:23:47.000000000 +0800
@@ -187,6 +187,7 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= pdc_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= pdc_sata_scr_read,
@@ -214,6 +215,7 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= pdc_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= pdc_sata_scr_read,
@@ -240,6 +242,7 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= pdc_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= pdc_common_port_start,
diff -Nrup 02_add_irq_off/drivers/ata/sata_qstor.c 03_add_irq_off_lldd/drivers/ata/sata_qstor.c
--- 02_add_irq_off/drivers/ata/sata_qstor.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/sata_qstor.c	2007-06-11 17:24:00.000000000 +0800
@@ -159,6 +159,7 @@ static const struct ata_port_operations 
 	.eng_timeout		= qs_eng_timeout,
 	.irq_clear		= qs_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= qs_scr_read,
 	.scr_write		= qs_scr_write,
diff -Nrup 02_add_irq_off/drivers/ata/sata_sil.c 03_add_irq_off_lldd/drivers/ata/sata_sil.c
--- 02_add_irq_off/drivers/ata/sata_sil.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/sata_sil.c	2007-06-11 17:24:14.000000000 +0800
@@ -206,6 +206,7 @@ static const struct ata_port_operations 
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= sil_scr_read,
 	.scr_write		= sil_scr_write,
diff -Nrup 02_add_irq_off/drivers/ata/sata_sil24.c 03_add_irq_off_lldd/drivers/ata/sata_sil24.c
--- 02_add_irq_off/drivers/ata/sata_sil24.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/sata_sil24.c	2007-06-11 17:24:30.000000000 +0800
@@ -399,6 +399,7 @@ static const struct ata_port_operations 
 
 	.irq_clear		= sil24_irq_clear,
 	.irq_on			= ata_dummy_irq_on,
+	.irq_off		= ata_dummy_irq_off,
 	.irq_ack		= ata_dummy_irq_ack,
 
 	.scr_read		= sil24_scr_read,
diff -Nrup 02_add_irq_off/drivers/ata/sata_sis.c 03_add_irq_off_lldd/drivers/ata/sata_sis.c
--- 02_add_irq_off/drivers/ata/sata_sis.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/sata_sis.c	2007-06-11 17:24:41.000000000 +0800
@@ -123,6 +123,7 @@ static const struct ata_port_operations 
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= sis_scr_read,
 	.scr_write		= sis_scr_write,
diff -Nrup 02_add_irq_off/drivers/ata/sata_svw.c 03_add_irq_off_lldd/drivers/ata/sata_svw.c
--- 02_add_irq_off/drivers/ata/sata_svw.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/sata_svw.c	2007-06-11 17:24:51.000000000 +0800
@@ -347,6 +347,7 @@ static const struct ata_port_operations 
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= k2_sata_scr_read,
 	.scr_write		= k2_sata_scr_write,
diff -Nrup 02_add_irq_off/drivers/ata/sata_sx4.c 03_add_irq_off_lldd/drivers/ata/sata_sx4.c
--- 02_add_irq_off/drivers/ata/sata_sx4.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/sata_sx4.c	2007-06-11 17:25:03.000000000 +0800
@@ -205,6 +205,7 @@ static const struct ata_port_operations 
 	.eng_timeout		= pdc_eng_timeout,
 	.irq_clear		= pdc20621_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.port_start		= pdc_port_start,
 };
diff -Nrup 02_add_irq_off/drivers/ata/sata_uli.c 03_add_irq_off_lldd/drivers/ata/sata_uli.c
--- 02_add_irq_off/drivers/ata/sata_uli.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/sata_uli.c	2007-06-11 17:25:22.000000000 +0800
@@ -117,6 +117,7 @@ static const struct ata_port_operations 
 
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= uli_scr_read,
diff -Nrup 02_add_irq_off/drivers/ata/sata_via.c 03_add_irq_off_lldd/drivers/ata/sata_via.c
--- 02_add_irq_off/drivers/ata/sata_via.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/sata_via.c	2007-06-11 17:25:40.000000000 +0800
@@ -146,6 +146,7 @@ static const struct ata_port_operations 
 
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -180,6 +181,7 @@ static const struct ata_port_operations 
 
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -211,6 +213,7 @@ static const struct ata_port_operations 
 
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= svia_scr_read,
diff -Nrup 02_add_irq_off/drivers/ata/sata_vsc.c 03_add_irq_off_lldd/drivers/ata/sata_vsc.c
--- 02_add_irq_off/drivers/ata/sata_vsc.c	2007-06-01 12:08:21.000000000 +0800
+++ 03_add_irq_off_lldd/drivers/ata/sata_vsc.c	2007-06-11 17:25:50.000000000 +0800
@@ -335,6 +335,7 @@ static const struct ata_port_operations 
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= vsc_sata_scr_read,
 	.scr_write		= vsc_sata_scr_write,


