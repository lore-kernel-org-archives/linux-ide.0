From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: [PATCH]pata_ninja32: Avoid corrupting status flags
Date: Tue, 30 Aug 2016 16:47:02 +0100
Message-ID: <20160830164702.26e5e9b4@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:52086 "EHLO
        lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755906AbcH3PrN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2016 11:47:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org

From: Alan Cox <alan@linux.intel.com>

Ninja32 needs to set some flags to indicate it does 32bit IO. However it currently assigns this which
loses the initializing flag and causes a warning spew. Fix it to use a logical or as is intended.
    
Signed-off-by: Alan Cox <alan@linux.intel.com>
Tested-by: Ellmar Stelnberger <estellnb@elstel.org>

diff --git a/drivers/ata/pata_ninja32.c b/drivers/ata/pata_ninja32.c
index 633aa29..44f97ad 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -144,7 +144,7 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	ap->ioaddr.altstatus_addr = base + 0x1E;
 	ap->ioaddr.bmdma_addr = base;
 	ata_sff_std_ports(&ap->ioaddr);
-	ap->pflags = ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32CHANGE;
+	ap->pflags |= ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32CHANGE;
 
 	ninja32_program(base);
 	/* FIXME: Should we disable them at remove ? */
