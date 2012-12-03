From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] libata: fix ata_dma_enabled
Date: Mon, 3 Dec 2012 09:35:49 +0800
Message-ID: <20121203013548.GA1396@mint-spring.sh.intel.com>
References: <50BBFA94.2070105@intel.com>
 <20121203012225.00e0c121@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30847 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218Ab2LCBfw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Dec 2012 20:35:52 -0500
Content-Disposition: inline
In-Reply-To: <20121203012225.00e0c121@pyramind.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Borislav Petkov <bp@alien8.de>, Dutra Julio <dutra.julio@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>, Tejun Heo <tj@kernel.org>, Szymon Janc <szymon@janc.net.pl>, Bernd Buschinski <b.buschinski@googlemail.com>, linux-ide@vger.kernel.org

On Mon, Dec 03, 2012 at 01:22:25AM +0000, Alan Cox wrote:
> On Mon, 03 Dec 2012 09:04:20 +0800
> Aaron Lu <aaron.lu@intel.com> wrote:
> 
> > 
> > ata_dma_enabled should check if device is either using multi word DMA
> > or ultra DMA instead of checking 0xff, as dma_mode 0 is not a valid dma
> > mode either.
> > 
> > This patch fixes the following bug:
> > https://bugzilla.kernel.org/show_bug.cgi?id=49151
> 
> NAK
> 
> dma_mode should *NEVER* be zero. If it's getting set to zero you have
> another bug and that needs fixing instead

The ata_dev->dma_mode is initialized as zero after we allocate the
ata_device structure, and we did not set this field until the set mode
function.

If you think it should _never_ be zero, probably my previous patch did
the job: it sets ata_dev->dma_mode to 0xff in the reset operation:

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 9426423..d772d66 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2657,6 +2657,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		 * bus as we may be talking too fast.
 		 */
 		dev->pio_mode = XFER_PIO_0;
+		dev->dma_mode = 0xff;
 
 		/* If the controller has a pio mode setup function
 		 * then use it to set the chipset to rights. Don't


So do you prefer this?

Thanks,
Aaron

> 
> Alan
