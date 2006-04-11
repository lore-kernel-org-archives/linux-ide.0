From: Unicorn Chang <uchang@tw.ibm.com>
Subject: [PATCH/RFC] libata: fix can't free irq 14 on legacy mode pata driver
Date: Tue, 11 Apr 2006 17:50:17 +0800
Message-ID: <443B7BD9.4040901@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:63693 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750705AbWDKJun
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Apr 2006 05:50:43 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3B9oYMX005621
	for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 05:50:34 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3B9l6ne124894
	for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 03:47:06 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k3B9oY10012270
	for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 03:50:34 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

-fix can't free irq 14 on legacy mode pata driver
-fix the ata_host_set_remove() memory leak problem

Signed-off-by: Unicorn Chang <uchang@tw.ibm.com>
---

keep all ata_host_set structure for free irq use on legacy mode pata
driver. 
(Patch against upstream branch)

using "rmmod pata_amd" and then "modprobe pata_amd" to produce bug and
same bug report by Krzysztof Halasa:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114122847813360&w=2

--- a/drivers/scsi/libata-core.c	2006-04-10 16:30:46.718750000 +0800
+++ b/drivers/scsi/libata-core.c	2006-04-11 17:02:52.109375000 +0800
@@ -4794,6 +4794,8 @@ int ata_device_add(const struct ata_prob
 		ata_scsi_scan_host(ap);
 	}
 
+	/* don't lose last one, free irq will need it */
+	host_set->host_set_chain = dev_get_drvdata(dev);
 	dev_set_drvdata(dev, host_set);
 
 	VPRINTK("EXIT, returning %u\n", ent->n_ports);
@@ -4826,6 +4828,9 @@ void ata_host_set_remove(struct ata_host
 	struct ata_port *ap;
 	unsigned int i;
 
+	if(host_set->host_set_chain)
+		ata_host_set_remove(host_set->host_set_chain);
+	
 	for (i = 0; i < host_set->n_ports; i++) {
 		ap = host_set->ports[i];
 		scsi_remove_host(ap->host);
--- a/include/linux/libata.h	2006-04-10 16:32:06.656250000 +0800
+++ b/include/linux/libata.h	2006-04-10 17:51:19.812500000 +0800
@@ -304,6 +304,7 @@ struct ata_host_set {
 	int			simplex_claimed;	/* Keep seperate in case we
 							   ever need to do this locked */
 	struct ata_port *	ports[0];
+	struct ata_host_set	*host_set_chain;	/* Keep last host_set */
 };
 
 struct ata_queued_cmd { 


