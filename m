From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCH] 2.6.x libata oops fix
Date: Fri, 28 Jan 2005 23:10:34 -0500
Message-ID: <41FB0CBA.1040409@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000006070606040202070402"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58304 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262847AbVA2EKw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Jan 2005 23:10:52 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000006070606040202070402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

BK info and patch attached.

--------------000006070606040202070402
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/libata-scsi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

through these ChangeSets:

<mkrikis@yahoo.com> (05/01/28 1.1987)
   [PATCH] fix an oops in ata_to_sense_error
   
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>


--------------000006070606040202070402
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2005-01-28 23:08:06 -05:00
+++ b/drivers/scsi/libata-scsi.c	2005-01-28 23:08:06 -05:00
@@ -282,7 +282,8 @@
 	/* No immediate match */
 	if(err)
 		printk(KERN_DEBUG "ata%u: no sense translation for 0x%02x\n", qc->ap->id, err);
-	
+
+	i = 0;
 	/* Fall back to interpreting status bits */
 	while(stat_table[i][0] != 0xFF)
 	{

--------------000006070606040202070402--
