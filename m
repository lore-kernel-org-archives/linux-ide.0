From: Tejun Heo <tj@kernel.org>
Subject: [RFC PATCH #upstream-fixes] libata: don't use 32bit PIO for small
 transfers
Date: Tue, 6 Sep 2011 13:21:01 +0900
Message-ID: <20110906042101.GE18425@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36759 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab1IFEVH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2011 00:21:07 -0400
Received: by iabu26 with SMTP id u26so7096711iab.19
        for <linux-ide@vger.kernel.org>; Mon, 05 Sep 2011 21:21:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, tom.leiming@gmail.com

Some configurations have problems with using 32bit PIO on ATAPI cdb
transfers.  The most likely cause is different division of payload
across FISes but hasn't been confirmed.  There isn't much to be gained
by using 32bit PIO for small transfers.  Play it safe and use 16bit
PIO for transfers smaller than 512 bytes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-and-Tested-by: Lei Ming <tom.leiming@gmail.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=40592
Cc: Alan Cox <alan@linux.intel.com>
Cc: stable@kernel.org
---
 drivers/ata/libata-sff.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

This fixes the problem but I'm slightly uneasy about it as I don't
know what's going on for sure.  However, given that we've been using
16bit PIO for far longer time and haven't seen much problem, this
seems like a sensible thing to do.  Alan, Jeff, what do you guys
think?

Thanks.

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index c24127d..60e3bac 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -617,7 +617,15 @@ unsigned int ata_sff_data_xfer32(struct ata_device *dev, unsigned char *buf,
 	unsigned int words = buflen >> 2;
 	int slop = buflen & 3;
 
-	if (!(ap->pflags & ATA_PFLAG_PIO32))
+	/*
+	 * Some configurations have problem with 32bit PIO on ATAPI cdb
+	 * transfers and there isn't much to be gained by using 32bit PIO
+	 * for small transfers anyway.  Fall back to 16bit if 32bit isn't
+	 * enabled or transfer size is smaller than ATA_SECT_SIZE.
+	 *
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=40592
+	 */
+	if (!(ap->pflags & ATA_PFLAG_PIO32) || buflen < ATA_SECT_SIZE)
 		return ata_sff_data_xfer(dev, buf, buflen, rw);
 
 	/* Transfer multiple of 4 bytes */
