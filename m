From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH] pata-qdi: fix le32 in data_xfer
Date: Mon, 09 Oct 2006 09:53:09 +0200
Message-ID: <87hcyej57e.fsf@slug.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from astra.telenet-ops.be ([195.130.132.58]:39569 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S932325AbWJIHxX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Oct 2006 03:53:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@redhat.com
Cc: linux-ide@vger.kernel.org

Hi,

The following tiny patch fixes a typo in qdi_data_xfer (le32 instead
of le16).

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

diff -urpN linux-2.6.19-rc1.orig/drivers/ata/pata_qdi.c linux-2.6.19-rc1/drivers/ata/pata_qdi.c
--- linux-2.6.19-rc1.orig/drivers/ata/pata_qdi.c	2006-10-09 09:34:28.000000000 +0200
+++ linux-2.6.19-rc1/drivers/ata/pata_qdi.c	2006-10-09 09:38:07.000000000 +0200
@@ -141,7 +141,7 @@ static void qdi_data_xfer(struct ata_dev
 				memcpy(&pad, buf + buflen - slop, slop);
 				outl(le32_to_cpu(pad), ap->ioaddr.data_addr);
 			} else {
-				pad = cpu_to_le16(inl(ap->ioaddr.data_addr));
+				pad = cpu_to_le32(inl(ap->ioaddr.data_addr));
 				memcpy(buf + buflen - slop, &pad, slop);
 			}
 		}

-- 
Bye, Peter Korsgaard
