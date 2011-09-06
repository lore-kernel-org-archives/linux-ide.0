From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: clear PIO pad area
Date: Tue, 6 Sep 2011 13:09:05 +0900
Message-ID: <20110906040905.GD18425@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43265 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab1IFEJL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2011 00:09:11 -0400
Received: by iabu26 with SMTP id u26so7086730iab.19
        for <linux-ide@vger.kernel.org>; Mon, 05 Sep 2011 21:09:11 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, tom.leiming@gmail.com

ata_sff_data_xfer[32]() use pad area if the transfer size isn't
multiple of transfer size; however, this area wasn't cleared and
garbage data in pad area could be transferred to the device.  Make
sure the pad area is cleared.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lei Ming <tom.leiming@gmail.com>
---
 drivers/ata/libata-sff.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index c24127d..2487ea7 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -569,7 +569,7 @@ unsigned int ata_sff_data_xfer(struct ata_device *dev, unsigned char *buf,
 
 	/* Transfer trailing byte, if any. */
 	if (unlikely(buflen & 0x01)) {
-		unsigned char pad[2];
+		unsigned char pad[2] = { };
 
 		/* Point buf to the tail of buffer */
 		buf += buflen - 1;
@@ -628,7 +628,7 @@ unsigned int ata_sff_data_xfer32(struct ata_device *dev, unsigned char *buf,
 
 	/* Transfer trailing bytes, if any */
 	if (unlikely(slop)) {
-		unsigned char pad[4];
+		unsigned char pad[4] = { };
 
 		/* Point buf to the tail of buffer */
 		buf += buflen - slop;
