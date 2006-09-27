From: Tejun Heo <htejun@gmail.com>
Subject: Re: dvd-r detection problem with port multiplier
Date: Wed, 27 Sep 2006 11:37:24 +0900
Message-ID: <20060927023724.GE25800@htj.dyndns.org>
References: <KMS--2047072133-2724@mail.norwalkdist.com> <4519D585.5010604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:38336 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750817AbWI0Ch3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Sep 2006 22:37:29 -0400
Received: by wx-out-0506.google.com with SMTP id s14so48218wxc
        for <linux-ide@vger.kernel.org>; Tue, 26 Sep 2006 19:37:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4519D585.5010604@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Trent George <trent@norwalkdist.com>
Cc: linux-ide@vger.kernel.org

Can you please test the following patch?  The spec says that clearing
PMP status should be followed by port initialization and I missed that
before.

Index: work1/drivers/scsi/sata_sil24.c
===================================================================
--- work1.orig/drivers/scsi/sata_sil24.c	2006-09-27 11:35:00.000000000 +0900
+++ work1/drivers/scsi/sata_sil24.c	2006-09-27 11:35:04.000000000 +0900
@@ -594,15 +594,17 @@ static int sil24_init_port(struct ata_po
 	struct sil24_port_priv *pp = ap->private_data;
 	u32 tmp;
 
+	if (ap->nr_pmp_links) {
+		/* clear PMP error status */
+		sil24_clear_pmp(ap);
+	}
+
 	writel(PORT_CS_INIT, port + PORT_CTRL_STAT);
 	ata_wait_register(port + PORT_CTRL_STAT,
 			  PORT_CS_INIT, PORT_CS_INIT, 10, 100);
 	tmp = ata_wait_register(port + PORT_CTRL_STAT,
 				PORT_CS_RDY, 0, 10, 100);
 
-	/* clear PMP error status */
-	sil24_clear_pmp(ap);
-
 	if ((tmp & (PORT_CS_INIT | PORT_CS_RDY)) != PORT_CS_RDY) {
 		pp->do_port_rst = 1;
 		ap->link.eh_context.i.action |= ATA_EH_HARDRESET;
@@ -916,12 +918,12 @@ static void sil24_irq_clear(struct ata_p
 static void sil24_pmp_attach(struct ata_port *ap)
 {
 	sil24_config_pmp(ap, 1);
-	sil24_clear_pmp(ap);
+	sil24_init_port(ap);
 }
 
 static void sil24_pmp_detach(struct ata_port *ap)
 {
-	sil24_clear_pmp(ap);
+	sil24_init_port(ap);
 	sil24_config_pmp(ap, 0);
 }
 

