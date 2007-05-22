From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: use_clustering (sht) bit set to 0 in AHCI ?
Date: Tue, 22 May 2007 09:45:39 +0200
Message-ID: <20070522074538.GP4705@kernel.dk>
References: <35f686220704252249y6d4fe0c3y1a772119c7b6657f@mail.gmail.com> <20070521121726.GT14746@kernel.dk> <46520C68.7090105@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([80.160.20.94]:5430 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755626AbXEVHsG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 May 2007 03:48:06 -0400
Content-Disposition: inline
In-Reply-To: <46520C68.7090105@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alok kataria <alokkataria1@gmail.com>, linux-ide@vger.kernel.org

On Mon, May 21 2007, Jeff Garzik wrote:
> Jens Axboe wrote:
> >ahci has always had clustering disabled, perhaps Jeff can expand on why?
> 
> 
> Just historical reasons.  libata had clustering disabled by default in 
> the beginning, for all drivers.  Then we enabled it globally by changing 
> the value of ATA_SHT_USE_CLUSTERING...  but apparently forgot to change 
> drivers which use their own value rather than ATA_SHT_USE_CLUSTERING.
> 
> Feel free to submit a patch turning it on...

The below works for me, but it's only lightly tested. I booted it up and
ran some large IO tests, I've verified really large IO sizes as well
(using blktrace, I've verified ios up to 9216KiB being accepted and
completed by the drive).

-----

From: Jens Axboe <jens.axboe@oracle.com>

ahci: enable sg segment clustering

The specification states that ahci supports segments up to 4MiB in size,
so enable clustering.

Signed-off-by: Jens Axboe <jens.axboe@oracle.com>

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index e00e1b9..bfcd8ec 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -54,7 +54,7 @@ enum {
 	AHCI_MAX_PORTS		= 32,
 	AHCI_MAX_SG		= 168, /* hardware max is 64K */
 	AHCI_DMA_BOUNDARY	= 0xffffffff,
-	AHCI_USE_CLUSTERING	= 0,
+	AHCI_USE_CLUSTERING	= 1,
 	AHCI_MAX_CMDS		= 32,
 	AHCI_CMD_SZ		= 32,
 	AHCI_CMD_SLOT_SZ	= AHCI_MAX_CMDS * AHCI_CMD_SZ,

-- 
Jens Axboe

