From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH libata-dev-2.6] ata_scsi_verify_xlat() fix
Date: Fri, 25 Feb 2005 12:58:22 +0800
Message-ID: <421EB06E.5040504@tw.ibm.com>
References: <421D7E5A.80702@tw.ibm.com> <421D85C2.6050103@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:41965 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262485AbVBYE6b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Feb 2005 23:58:31 -0500
In-Reply-To: <421D85C2.6050103@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>



Jeff Garzik wrote:
> 
> Patch looks OK, but does not appear to be diff'd against
> 
>     linux-2.6.11-rc4 + CHS support patches
> 
> When I try to apply your patch, I get
> 
> drivers/scsi/libata-scsi.c 1.68: 1661 lines
> drivers/scsi/libata-scsi.c 1.68 -> 1.69: 1661 lines
> 2 out of 2 hunks FAILED -- saving rejects to file 
> drivers/scsi/libata-scsi.c.rej
> 
> 
Jeff,

Thanks for the explanation.

I've rediff'ed the patch against 2.6.11-rc5 + C/H/S patches.
Attached please find the revised patch for your review.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
============================================================================================
--- linux-2.6.11-rc5-chs/drivers/scsi/libata-scsi.c	2005-02-25 11:48:23.000000000 +0800
+++ linux-2.6.11-rc5-mod/drivers/scsi/libata-scsi.c	2005-02-25 12:40:05.000000000 +0800
@@ -529,6 +529,7 @@
  		if ((cyl >> 16) || (head >> 4) || (sect >> 8) || (!sect))
  			return 1;
  		
+		tf->command = ATA_CMD_VERIFY;
  		tf->nsect = n_block & 0xff; /* Sector count 0 means 256 sectors */
  		tf->lbal = sect;
  		tf->lbam = cyl;
@@ -619,7 +620,7 @@

  	/* Check and compose ATA command */
  	if (!n_block)
-		/* In ATA, sector count 0 are 256 or 65536 sectors, not 0 sectors. */
+		/* In ATA, sector count 0 means 256 or 65536 sectors, not 0 sectors. */
  		return 1;

  	if (lba) {



