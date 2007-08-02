From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] pata_isapnp: use MODULE_DEVICE_TABLE()
Date: Thu, 2 Aug 2007 07:06:07 -0400
Message-ID: <20070802110606.GA26087@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:52112 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753436AbXHBLGI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Aug 2007 07:06:08 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>


I found this while doing ISDN PCI API conversions...  I presume this
omission was not intentional?

Signed-off-by: Jeff Garzik <jeff@garzik.org>


diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 5525518..91a396f 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -139,6 +139,8 @@ static struct pnp_device_id isapnp_devices[] = {
 	{.id = ""}
 };
 
+MODULE_DEVICE_TABLE(pnp, isapnp_devices);
+
 static struct pnp_driver isapnp_driver = {
 	.name		= DRV_NAME,
 	.id_table	= isapnp_devices,
