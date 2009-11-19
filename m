From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Thu, 19 Nov 2009 18:38:11 +0100
Message-ID: <200911191838.11791.bzolnier@gmail.com>
References: <20091117144450.15430.83450.stgit@localhost.localdomain> <200911191645.29885.bzolnier@gmail.com> <20091119162738.7e8e5665@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:6290 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbZKSRip (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2009 12:38:45 -0500
In-Reply-To: <20091119162738.7e8e5665@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Thursday 19 November 2009 17:27:38 Alan Cox wrote:
> > > > already have a buggy cable detection (since ->pre_reset ignores the mandatory
> > > 
> > > Wrong.
> > 
> > You cannot know it unless you know how chip operates internally.  That's it.
> 
> Read the code. How the chip operates is irrelevant.

lol, there is a genuine cable detection bug in pata_hpt3x2n on closer look...

Jeff, please apply the patch below.


From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_hpt3x2n: fix cable detection

The detection was reversed between primary and secondary ports.

Fix it to match hpt366 and the vendor driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_hpt3x2n.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_hpt3x2n.c
===================================================================
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -133,7 +133,7 @@ static int hpt3x2n_cable_detect(struct a
 	/* Restore state */
 	pci_write_config_byte(pdev, 0x5B, scr2);
 
-	if (ata66 & (1 << ap->port_no))
+	if (ata66 & (2 >> ap->port_no))
 		return ATA_CBL_PATA40;
 	else
 		return ATA_CBL_PATA80;
