From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 9/9] libata: remove irq_on/off and rename freeze()/thaw()
 to irq_on/off
Date: Fri, 15 Jun 2007 11:44:32 +0800
Message-ID: <46720B20.6060402@tw.ibm.com>
References: <46720353.90209@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:45707 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885AbXFODog (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jun 2007 23:44:36 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5F3iaB2023532
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 23:44:36 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5F3iaKn262840
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 21:44:36 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5F3iZbW002359
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 21:44:35 -0600
In-Reply-To: <46720353.90209@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>
Cc: Doug Maxey <dwm@enoyolf.org>

Patch 9/9:

  It seems  ->irq_on and ->irq_off are now only wrapped by freeze()/thaw() and unused elsewhere.
This patch
  - Remove ->irq_on and ->irq_off.
  - Rename ->freeze and ->thaw to irq_on() and irq_off() to be specific.

Hopefully the LLDDs need to implement only one irq on/off by either host adapter masking,
nIEN manipulation, or both or something else.

No patch for this yet. Just some idea like below...

diff -Nrup 09_freeze_thaw_pdc2027x/include/linux/libata.h 10_replace_irq_on_off/include/linux/libata.h
--- 09_freeze_thaw_pdc2027x/include/linux/libata.h	2007-06-12 13:35:19.000000000 +0800
+++ 10_replace_irq_on_off/include/linux/libata.h	2007-06-15 11:43:47.000000000 +0800
@@ -591,15 +591,13 @@ struct ata_port_operations {
 	 */
 	void (*eng_timeout) (struct ata_port *ap); /* obsolete */
 
-	void (*freeze) (struct ata_port *ap);
-	void (*thaw) (struct ata_port *ap);
+	u8 (*irq_on) (struct ata_port *);
+	u8 (*irq_off) (struct ata_port *);
 	void (*error_handler) (struct ata_port *ap);
 	void (*post_internal_cmd) (struct ata_queued_cmd *qc);
 
 	irq_handler_t irq_handler;
 	void (*irq_clear) (struct ata_port *);
-	u8 (*irq_on) (struct ata_port *);
-	u8 (*irq_off) (struct ata_port *);
 	u8 (*irq_ack) (struct ata_port *ap, unsigned int chk_drq);
 
 	u32 (*scr_read) (struct ata_port *ap, unsigned int sc_reg);

 


