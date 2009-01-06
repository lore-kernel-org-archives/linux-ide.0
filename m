From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/9] sl82c105: remove dead code
Date: Tue, 06 Jan 2009 19:35:26 +0100
Message-ID: <20090106183526.21193.24866.sendpatchset@localhost.localdomain>
References: <20090106183520.21193.63704.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:48965 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788AbZAFSeo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Jan 2009 13:34:44 -0500
In-Reply-To: <20090106183520.21193.63704.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] sl82c105: remove dead code

CONFIG_LOPEC and CONFIG_SANDPOINT config options are gone.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/sl82c105.c |    4 ----
 1 file changed, 4 deletions(-)

Index: b/drivers/ide/sl82c105.c
===================================================================
--- a/drivers/ide/sl82c105.c
+++ b/drivers/ide/sl82c105.c
@@ -310,10 +310,6 @@ static const struct ide_port_info sl82c1
 	.dma_ops	= &sl82c105_dma_ops,
 	.host_flags	= IDE_HFLAG_IO_32BIT |
 			  IDE_HFLAG_UNMASK_IRQS |
-/* FIXME: check for Compatibility mode in generic IDE PCI code */
-#if defined(CONFIG_LOPEC) || defined(CONFIG_SANDPOINT)
-			  IDE_HFLAG_FORCE_LEGACY_IRQS |
-#endif
 			  IDE_HFLAG_SERIALIZE_DMA |
 			  IDE_HFLAG_NO_AUTODMA,
 	.pio_mask	= ATA_PIO5,
