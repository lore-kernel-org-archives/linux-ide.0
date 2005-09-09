From: russb@emc.com (Brett M Russ)
Subject: [PATCH 2.6.13] PCI/libata INTx bug fix
Date: Fri,  9 Sep 2005 09:04:40 -0400 (EDT)
Message-ID: <20050909130440.4E31E271E6@lns1058.lss.emc.com>
References: <20050803204709.8BA0720B06@lns1058.lss.emc.com> <42FBA08C.5040103@pobox.com> <20050812171043.CF61020E8B@lns1058.lss.emc.com> <20050812182253.GA7842@suse.de> <42FD14E9.8060502@pobox.com> <20050812224303.F40A820E94@lns1058.lss.emc.com> <20050815185732.GA15216@kroah.com> <20050815192341.6600220FF7@lns1058.lss.emc.com> <1126218402469@kroah.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub.lss.emc.com ([168.159.2.31]:34870 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751449AbVIINFF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Sep 2005 09:05:05 -0400
In-Reply-To: <20050815192341.6600220FF7@lns1058.lss.emc.com> <1126218402469@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz, Brett Russ <russb@emc.com>

Previous INTx cleanup patch had a bug that was not caught.  I found
this last night during testing and can confirm that it is now 100%
working.

Signed-off-by: Brett Russ <russb@emc.com>


Index: linux-2.6.13/drivers/pci/pci.c
===================================================================
--- linux-2.6.13.orig/drivers/pci/pci.c
+++ linux-2.6.13/drivers/pci/pci.c
@@ -764,7 +764,7 @@ pci_intx(struct pci_dev *pdev, int enabl
 	}
 
 	if (new != pci_command) {
-		pci_write_config_word(pdev, PCI_COMMAND, pci_command);
+		pci_write_config_word(pdev, PCI_COMMAND, new);
 	}
 }
 
