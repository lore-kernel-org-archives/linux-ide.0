From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH libata-dev-2.6] ata_scsi_verify_xlat() fix
Date: Thu, 24 Feb 2005 15:12:26 +0800
Message-ID: <421D7E5A.80702@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:46078 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261878AbVBXHMe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Feb 2005 02:12:34 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

Jeff,

Attached please find the split ata_scsi_verify_xlat() fix.

Change:
  - Fix uninitialized tf->command bug in ata_scsi_verify_xlat(), introduced by my previous CHS support patch.
    (This is similar to http://marc.theaimsgroup.com/?l=linux-ide&m=110735039505617&w=2)
  - Fix comment wording.

The patch is against libata-dev-2.6 tree for your review.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
=============================================================================================
--- libata-dev-2.6/drivers/scsi/libata-scsi.c	2005-02-21 17:23:03.000000000 +0800
+++ libata-dev-2.6-mod/drivers/scsi/libata-scsi.c	2005-02-22 18:32:19.000000000 +0800
@@ -785,6 +785,7 @@
  		if ((cyl >> 16) || (head >> 4) || (sect >> 8) || (!sect))
  			return 1;
  		
+		tf->command = ATA_CMD_VERIFY;
  		tf->nsect = n_block & 0xff; /* Sector count 0 means 256 sectors */
  		tf->lbal = sect;
  		tf->lbam = cyl;
@@ -875,7 +876,7 @@

  	/* Check and compose ATA command */
  	if (!n_block)
-		/* In ATA, sector count 0 are 256 or 65536 sectors, not 0 sectors. */
+		/* In ATA, sector count 0 means 256 or 65536 sectors, not 0 sectors. */
  		return 1;

  	if (lba) {



