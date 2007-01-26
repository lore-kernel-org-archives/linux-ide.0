From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: use 0x80 as wait stat value instead of 0xff
Date: Fri, 26 Jan 2007 15:37:20 +0900
Message-ID: <20070126063720.GG8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:13671 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030801AbXAZGh1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Jan 2007 01:37:27 -0500
Received: by nz-out-0506.google.com with SMTP id s1so621233nze
        for <linux-ide@vger.kernel.org>; Thu, 25 Jan 2007 22:37:26 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Before hardreset, ahci initialized stat part of received FIS area to
0xff to wait for the first D2H Reg FIS which would change the value to
device ready state.  This used to work but now libata considers status
value of 0xff as device not present making this wait prone to failure.

This patch makes ahci use 0x80 for the wait stat value instead of
0xff to fix the above problem.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/ata/ahci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -915,7 +915,7 @@ static int ahci_hardreset(struct ata_por
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(ap->device, &tf);
-	tf.command = 0xff;
+	tf.command = 0x80;
 	ata_tf_to_fis(&tf, d2h_fis, 0);
 
 	rc = sata_std_hardreset(ap, class);
