From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] pci: allow multiple calls to pcim_enable_device()
Date: Wed, 30 Jan 2008 18:20:04 +0900
Message-ID: <47A04144.3070106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:15992 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbYA3JUL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jan 2008 04:20:11 -0500
Received: by wa-out-1112.google.com with SMTP id v27so274266wah.23
        for <linux-ide@vger.kernel.org>; Wed, 30 Jan 2008 01:20:10 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

There's no reason not to allow multiple calls to pcim_enable_device().
Calls after the first one can simply be noop.  All PCI resources will
be released when the initial pcim_enable_device() resource is
released.

This allows more flexibility to managed PCI users.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---
This will be used to fix some libata issues.  After Greg's ACK, would
it be okay to push this through libata-dev#upstream?

Thanks.

 drivers/pci/pci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 71d561f..7d4ce90 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -823,7 +823,8 @@ int pcim_enable_device(struct pci_dev *pdev)
 	dr = get_pci_dr(pdev);
 	if (unlikely(!dr))
 		return -ENOMEM;
-	WARN_ON(!!dr->enabled);
+	if (dr->enabled)
+		return 0;
 
 	rc = pci_enable_device(pdev);
 	if (!rc) {
-- 
1.5.2.4

