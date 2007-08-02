From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] Add a PCI ID for santa rosa's PATA controller.
Date: Thu, 2 Aug 2007 15:36:50 +0900
Message-ID: <20070802063650.GK13674@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:23036 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbXHBGg6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 02:36:58 -0400
Received: by rv-out-0910.google.com with SMTP id k20so340208rvb
        for <linux-ide@vger.kernel.org>; Wed, 01 Aug 2007 23:36:57 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: stable@kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

From: Christian Lamparter <chunkeey@web.de>

Signed-off-by: Christian Lamparter <chunkeey@web.de>
Signed-off-by: Jeff Garzik <jeff@garzik.org>
---
This is commit c1e6f28cc5de37dcd113b9668a185c0b9334ba8a which is
merged during 23-rc1 window.  Considering the popularity of these
chips, I think including it in -stable release would be good idea.

Thanks.

 drivers/ata/ata_piix.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 924e447..76cbdf0 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -200,6 +200,8 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	/* ICH7/7-R (i945, i975) UDMA 100*/
 	{ 0x8086, 0x27DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_133 },
 	{ 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
+	/* ICH8 Mobile PATA Controller */
+	{ 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 
 	/* NOTE: The following PCI ids must be kept in sync with the
 	 * list in drivers/pci/quirks.c.
-- 
1.5.0.3

