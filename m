From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 4/4] libata-dev: Minor comment fix
Date: Wed, 08 Feb 2006 16:51:34 +0800
Message-ID: <43E9B116.6000801@tw.ibm.com>
References: <43DA2CFB.4010605@pobox.com> <43E9AAE0.8020302@tw.ibm.com> <43E9AD00.8070900@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:32944 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030584AbWBHIvk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Feb 2006 03:51:40 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k188pcqs030218
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 03:51:38 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k188s55b184902
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 01:54:05 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k188pbpA030267
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 01:51:38 -0700
In-Reply-To: <43E9AD00.8070900@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Patch 4/4:

  - Minor comment movement

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

===

--- errmask/drivers/scsi/libata-core.c	2006-02-08 14:42:34.000000000 +0800
+++ comments/drivers/scsi/libata-core.c	2006-02-08 14:44:31.000000000 +0800
@@ -4510,19 +4510,6 @@ irqreturn_t ata_interrupt (int irq, void
 	return IRQ_RETVAL(handled);
 }
 
-/**
- *	ata_port_start - Set port up for dma.
- *	@ap: Port to initialize
- *
- *	Called just after data structures for each port are
- *	initialized.  Allocates space for PRD table.
- *
- *	May be used as the port_start() entry in ata_port_operations.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
 /*
  * Execute a 'simple' command, that only consists of the opcode 'cmd' itself,
  * without filling any other registers
@@ -4613,6 +4600,19 @@ int ata_device_suspend(struct ata_port *
 	return 0;
 }
 
+/**
+ *	ata_port_start - Set port up for dma.
+ *	@ap: Port to initialize
+ *
+ *	Called just after data structures for each port are
+ *	initialized.  Allocates space for PRD table.
+ *
+ *	May be used as the port_start() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
 int ata_port_start (struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;



