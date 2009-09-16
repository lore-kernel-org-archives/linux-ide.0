From: Tejun Heo <tj@kernel.org>
Subject: [PATCH] ahci: restore pci_intx() handling
Date: Thu, 17 Sep 2009 00:34:39 +0900
Message-ID: <4AB1058F.3070108@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55674 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbZIPPfS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Sep 2009 11:35:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org, Jeff Garzik <jeff@garzik.org>, Thomas Jarosch <thomas.jarosch@intra2net.com>

Commit a5bfc4714b3f01365aef89a92673f2ceb1ccf246 dropped explicit
pci_intx() manipulation from ahci because it seemed unnecessary and
ahci doesn't seem to be the right place to be tweaking it if it were.
This was largely okay but there are exceptions.  There was one on an
embedded platform which was fixed via firmware and now bko#14124
reports it on a HP DL320.

  http://bugzilla.kernel.org/show_bug.cgi?id=14124

I still think this isn't something libata drivers should be caring
about (the only ones which are calling pci_intx() explicitly are
libata ones and one other driver) but for now reverting the change
seems to be the right thing to do.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Thomas Jarosch <thomas.jarosch@intra2net.com>
---
 drivers/ata/ahci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index d4cd9c2..acd1162 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2930,8 +2930,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ahci_sb600_32bit_only(pdev))
 		hpriv->flags |= AHCI_HFLAG_32BIT_ONLY;

-	if (!(hpriv->flags & AHCI_HFLAG_NO_MSI))
-		pci_enable_msi(pdev);
+	if ((hpriv->flags & AHCI_HFLAG_NO_MSI) || pci_enable_msi(pdev))
+		pci_intx(pdev, 1);

 	/* save initial config */
 	ahci_save_initial_config(pdev, hpriv);
