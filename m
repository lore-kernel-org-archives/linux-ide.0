From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] jmicron: update quirk for JMB361/3/5/6
Date: Tue, 23 Oct 2007 15:27:31 +0900
Message-ID: <20071023062731.GC18322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:55301 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbXJWG1i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Oct 2007 02:27:38 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1402633rvb
        for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2007 23:27:37 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, ethanhsiao@jmicron.com

Set bits 0, 4, 5 and 7 of PCI configuration register 0x40 in the
quirk.  This has the following effects and is recommended by the
vendor.

* Force enable of IDE channels (used to be left alone as BIOS
  configured)

* Change initial phase behavior of PIO cycle such that the host pulls
  down the bus instead of tristating it.  Vendor recommends this
  setting.

The above settings are better for the current generation of
controllers and needed for the upcoming next generation.

Tested on JMB363.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Ethan Hsiao <ethanhsiao@jmicron.com>
---
 drivers/pci/quirks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/pci/quirks.c
===================================================================
--- work.orig/drivers/pci/quirks.c
+++ work/drivers/pci/quirks.c
@@ -1230,7 +1230,7 @@ static void quirk_jmicron_ata(struct pci
 	case PCI_DEVICE_ID_JMICRON_JMB363:
 		/* Enable dual function mode, AHCI on fn 0, IDE fn1 */
 		/* Set the class codes correctly and then direct IDE 0 */
-		conf1 |= 0x00C2A102; /* Set 1, 8, 13, 15, 17, 22, 23 */
+		conf1 |= 0x00C2A1B3; /* Set 0, 1, 4, 5, 7, 8, 13, 15, 17, 22, 23 */
 		break;
 
 	case PCI_DEVICE_ID_JMICRON_JMB368:
