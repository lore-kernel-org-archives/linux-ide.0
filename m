From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/2] libata: kill SCSI devices before detaching ata_host
Date: Fri, 07 Mar 2008 12:11:50 +0900
Message-ID: <47D0B276.1010301@gmail.com>
References: <20080222200951.GI16995@parisc-linux.org>	 <47BF3E54.9050609@rtr.ca>  <47CFA9A6.2040506@gmail.com>	 <1204817301.3062.3.camel@localhost.localdomain>	 <47D08478.8010700@gmail.com>	 <1204848119.3062.94.camel@localhost.localdomain>	 <47D08892.3080209@gmail.com>	 <1204849353.3062.107.camel@localhost.localdomain>	 <47D08C32.8060907@gmail.com> <1204850398.3062.111.camel@localhost.localdomain> <47D08FAA.7070001@gmail.com> <47D0B1A4.2040104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.191]:51706 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861AbYCGDL6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 22:11:58 -0500
Received: by rn-out-0910.google.com with SMTP id v46so477335rnb.15
        for <linux-ide@vger.kernel.org>; Thu, 06 Mar 2008 19:11:57 -0800 (PST)
In-Reply-To: <47D0B1A4.2040104@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Mark Lord <liml@rtr.ca>, Matthew Wilcox <matthew@wil.cx>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Kill SCSI devices before detaching port.  This makes drives properly
shut down on driver unload.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: work1/drivers/ata/libata-core.c
===================================================================
--- work1.orig/drivers/ata/libata-core.c
+++ work1/drivers/ata/libata-core.c
@@ -7236,6 +7236,14 @@ static void ata_port_detach(struct ata_p
 	if (!ap->ops->error_handler)
 		goto skip_eh;
 
+	/* First, tell all SCSI devices that we're going down.  Note
+	 * that there's a small race window here.  Devices which get
+	 * hotplugged after forget_host but before EH is killed won't
+	 * get shut down by SCSI layer properly and will miss cache
+	 * flush and spin down.
+	 */
+	scsi_forget_host(ap->scsi_host);
+
 	/* tell EH we're leaving & flush EH */
 	spin_lock_irqsave(ap->lock, flags);
 	ap->pflags |= ATA_PFLAG_UNLOADING;
