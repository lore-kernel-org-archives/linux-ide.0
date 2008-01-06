From: Tejun Heo <htejun@gmail.com>
Subject: pata_ixp4xx_cf: fix compilation introduced by ata_port_desc() conversion
Date: Sun, 06 Jan 2008 10:05:28 +0900
Message-ID: <47802958.4080602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:47567 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146AbYAFBFf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jan 2008 20:05:35 -0500
Received: by rv-out-0910.google.com with SMTP id k20so6616763rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 05 Jan 2008 17:05:34 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, rod@whitby.id.au

From: Rod Whitby <rod@whitby.id.au>

Fixes a compilation error caused by ata_port_desc() conversion
(cbcdd87593a1d85c5c4b259945a3a09eee12814d).

Signed-off-by: Rod Whitby <rod@whitby.id.au>
Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/pata_ixp4xx_cf.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index fcd532a..120b5bf 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -130,10 +130,11 @@ static struct ata_port_operations ixp4xx_port_ops = {
 	.port_start		= ata_port_start,
 };
 
-static void ixp4xx_setup_port(struct ata_ioports *ioaddr,
+static void ixp4xx_setup_port(struct ata_port *ap,
 			      struct ixp4xx_pata_data *data,
 			      unsigned long raw_cs0, unsigned long raw_cs1)
 {
+	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned long raw_cmd = raw_cs0;
 	unsigned long raw_ctl = raw_cs1 + 0x06;
 
