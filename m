From: Brett Russ <russb@emc.com>
Subject: Re: [PATCH libata-dev-2.6 02/05] libata: AHCI error handling fix
Date: Thu, 17 Mar 2005 17:20:11 -0500 (EST)
Message-ID: <20050317221753.47B975B8@lns1032.lss.emc.com>
References: <20050317221753.53957EDF@lns1032.lss.emc.com>
Content-Type: text/plain; charset=US-ASCII
Received: from mailhub.lss.emc.com ([168.159.2.31]:19836 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261212AbVCQWUS
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Mar 2005 17:20:18 -0500
In-Reply-To: <20050317221753.53957EDF@lns1032.lss.emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com

02_libata_ahci-err-int.patch

	(included in libata-2.6) Fixes AHCI bits during handling of
	fatal error int.

Signed-off-by: Brett Russ <russb@emc.com>

 ahci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: libata-dev-2.6/drivers/scsi/ahci.c
===================================================================
--- libata-dev-2.6.orig/drivers/scsi/ahci.c	2005-03-17 17:16:57.000000000 -0500
+++ libata-dev-2.6/drivers/scsi/ahci.c	2005-03-17 17:16:57.000000000 -0500
@@ -548,7 +548,7 @@ static void ahci_intr_error(struct ata_p
 
 	/* stop DMA */
 	tmp = readl(port_mmio + PORT_CMD);
-	tmp &= PORT_CMD_START | PORT_CMD_FIS_RX;
+	tmp &= ~PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 
 	/* wait for engine to stop.  TODO: this could be
@@ -580,7 +580,7 @@ static void ahci_intr_error(struct ata_p
 
 	/* re-start DMA */
 	tmp = readl(port_mmio + PORT_CMD);
-	tmp |= PORT_CMD_START | PORT_CMD_FIS_RX;
+	tmp |= PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
 

