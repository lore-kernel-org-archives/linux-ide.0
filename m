From: Joe Perches <joe@perches.com>
Subject: [PATCH] drivers/ata/sata_via.c - Eliminate "may be used
	uninitialized" warning
Date: Sun, 06 Apr 2008 14:45:20 -0700
Message-ID: <1207518320.1803.52.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 136-022.dsl.labridge.com ([206.117.136.22]:1927 "EHLO
	mail.perches.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754275AbYDFVpx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Apr 2008 17:45:53 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Called by svia_init_one with a temporary,
so there's no effective code change.

Signed-off-by: Joe Perches <joe@perches.com>

 drivers/ata/sata_via.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 0d03f44..e01d2b1 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -406,10 +406,9 @@ static int vt6420_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
 	struct ata_host *host;
 	int rc;
 
-	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
+	rc = ata_pci_prepare_sff_host(pdev, ppi, r_host);
 	if (rc)
 		return rc;
-	*r_host = host;
 
 	rc = pcim_iomap_regions(pdev, 1 << 5, DRV_NAME);
 	if (rc) {
@@ -417,6 +416,7 @@ static int vt6420_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
 		return rc;
 	}
 
+	host = *r_host;
 	host->ports[0]->ioaddr.scr_addr = svia_scr_addr(host->iomap[5], 0);
 	host->ports[1]->ioaddr.scr_addr = svia_scr_addr(host->iomap[5], 1);
 


