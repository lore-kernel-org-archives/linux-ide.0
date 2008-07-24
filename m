From: Ben Dooks <ben-linux@fluff.org>
Subject: LIBATA: pata_ali.c misplaced pci_dev_put()
Date: Thu, 24 Jul 2008 16:38:06 +0100
Message-ID: <20080724153806.633927699@fluff.org.uk>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:49446 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750744AbYGXPiI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 11:38:08 -0400
Content-Disposition: inline; filename=simtec/simtec-libata-stop-pci-get-leak.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>

The ali_init_one() function does a search for an isa_bridge,
but then fails to release it if the revision information was
not correctly found.

the problem comes from:
	isa_bridge = pci_get_device(...);
	if (isa_bridge && ...) {
		pci_dev_put(isa_bridge);
	}

where the pci_dev_put() is never called if isa_bridge
was valid but the extra checks on the chip-revision
fail to match.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-quilt4/drivers/ata/pata_ali.c
===================================================================
--- linux-2.6.26-quilt4.orig/drivers/ata/pata_ali.c	2008-07-24 16:26:43.000000000 +0100
+++ linux-2.6.26-quilt4/drivers/ata/pata_ali.c	2008-07-24 16:27:24.000000000 +0100
@@ -550,8 +550,9 @@ static int ali_init_one(struct pci_dev *
 		pci_read_config_byte(isa_bridge, 0x5E, &tmp);
 		if ((tmp & 0x1E) == 0x12)
 	        	ppi[0] = &info_20_udma;
-		pci_dev_put(isa_bridge);
 	}
+	pci_dev_put(isa_bridge);
+
 	return ata_pci_sff_init_one(pdev, ppi, &ali_sht, NULL);
 }
 

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
