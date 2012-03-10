From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] sata_mv: silence an uninitialized variable warning
Date: Sat, 10 Mar 2012 12:00:05 +0300
Message-ID: <20120310090005.GE4647@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:44908 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637Ab2CJJAY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2012 04:00:24 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Michael Walle <michael@walle.cc>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, kernel-janitors@vger.kernel.org

Gcc version 4.6.2-12 complains that if we can't find the "nr-ports"
property in of_property_read_u32_array() then "n_ports" is used
uninitialized.  Let's set it to zero in that case.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index ebd0d24..3d8d5c6 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4026,7 +4026,8 @@ static int mv_platform_probe(struct platform_device *pdev)
 	struct ata_host *host;
 	struct mv_host_priv *hpriv;
 	struct resource *res;
-	int n_ports, rc;
+	int n_ports = 0;
+	int rc;
 
 	ata_print_version_once(&pdev->dev, DRV_VERSION);
 
