From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] pci-quirks: disable MSI on RS400-200 and RS480
Date: Mon, 16 Apr 2007 13:59:18 +0900
Message-ID: <20070416045918.GI10619@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:33075 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbXDPE71 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Apr 2007 00:59:27 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1414455wra
        for <linux-ide@vger.kernel.org>; Sun, 15 Apr 2007 21:59:26 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gregkh@suse.de, Jeff Garzik <jeff@garzik.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: torresmat@gmail.com, conke.hu@gmail.com

MSI doesn't work on RS400-200 and RS480 requiring pci=nomsi kernel
boot parameter for ahci to work.  This patch disables MSI on those
chips.

  http://thread.gmane.org/gmane.linux.ide/17820
  http://thread.gmane.org/gmane.linux.ide/17516
  https://bugzilla.novell.com/show_bug.cgi?id=263893

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 65d6f23..3300ff1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1761,6 +1761,8 @@ static void __devinit quirk_disable_msi(struct pci_dev *dev)
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_disable_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS400_200, quirk_disable_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS480, quirk_disable_msi);
 
 /* Go through the list of Hypertransport capabilities and
  * return 1 if a HT MSI capability is found and enabled */
