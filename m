From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [PATCH] PA-RISC update to 87415
Date: Wed, 3 Nov 2004 16:19:21 -0700
Message-ID: <20041103231921.GC23415@colo.lackof.org>
References: <20041103200059.GC17672@colo.lackof.org> <58cb370e04110312215ee851e4@mail.gmail.com> <20041103213351.GB23415@colo.lackof.org> <58cb370e041103140121017ea1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:59298 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261987AbUKCXT2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Nov 2004 18:19:28 -0500
Content-Disposition: inline
In-Reply-To: <58cb370e041103140121017ea1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Grant Grundler <grundler@parisc-linux.org>, matthew@wil.cx, linux-ide@vger.kernel.org

On Wed, Nov 03, 2004 at 11:01:58PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Please make a separate patch+changelog if this is not a problem.

ide_hwif_setup_dma() calls pci_set_master() if necessary.
pci_set_master() (indirectly via pcibios_set_master() sets
PCI_LATENCY_TIMER to a "reasonable" value.

Signed-off-by: Grant Grundler <grundler@parisc-linux.org>


Index: linux-2.6/drivers/ide/pci/ns87415.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/ide/pci/ns87415.c,v
retrieving revision 1.17
retrieving revision 1.18
diff -u -p -r1.17 -r1.18
--- linux-2.6/drivers/ide/pci/ns87415.c	13 Sep 2004 15:23:04 -0000	1.17
+++ linux-2.6/drivers/ide/pci/ns87415.c	28 Sep 2004 17:07:01 -0000	1.18
@@ -153,10 +223,6 @@ static void __init init_hwif_ns87415 (id
 	hwif->autodma = 0;
 	hwif->selectproc = &ns87415_selectproc;
 
-	/* Set a good latency timer and cache line size value. */
-	(void) pci_write_config_byte(dev, PCI_LATENCY_TIMER, 64);
-	/* FIXME: use pci_set_master() to ensure good latency timer value */
-
 	/*
 	 * We cannot probe for IRQ: both ports share common IRQ on INTA.
 	 * Also, leave IRQ masked during drive probing, to prevent infinite
