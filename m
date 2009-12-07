From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/6] pata_sis: Implement MWDMA for the UDMA 133 capable chips
Date: Mon, 7 Dec 2009 16:36:31 +0100
Message-ID: <200912071636.32030.bzolnier@gmail.com>
References: <20091130132005.27236.77890.stgit@localhost.localdomain> <4B1D0268.4090508@ru.mvista.com> <200912071605.28364.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:55317 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932689AbZLGPiI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2009 10:38:08 -0500
Received: by ewy19 with SMTP id 19so585855ewy.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Dec 2009 07:38:13 -0800 (PST)
In-Reply-To: <200912071605.28364.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, jeff@garzik.org, davem@davemloft.net

On Monday 07 December 2009 04:05:28 pm Bartlomiej Zolnierkiewicz wrote:
> On Monday 07 December 2009 02:26:00 pm Sergei Shtylyov wrote:
> > Hello.
> > 
> > Alan Cox wrote:
> > 
> > > Bartlomiej pointed out that while this got fixed in the old driver whoever
> > > did it didn't port it across.
> > 
> > > Signed-off-by: Alan Cox <alan@linux.intel.com>
> > 
> > [...]
> > 
> > > +static int mwdma_clip_to_pio(struct ata_device *adev)
> > > +{
> > > +	const int mwdma_to_pio[3] = {
> > > +		XFER_PIO_0, XFER_PIO_3, XFER_PIO_4
> > > +	};
> > > +	return min(mwdma_to_pio[adev->dma_mode - XFER_MW_DMA_0],
> > > +				adev->pio_mode - XFER_PIO_0);
> > > +}
> > 
> >     You call min() on uncomparables, i.e. mwdma_to_pio[] contains XFER_PIO_* 
> > and adev->pio_mode - XFER_PIO_0 yields you a mode number. Thus the second 
> > argument will always "win" as a minimal one.
> 
> There are more issues with the patch related to mwdma_clip_to_pio().
> 
> The function can return values between 0 and 4 which obviously won't work
> well for the new code below for values > 2 (i.e. resulting in out-of-bounds

Fortunately above bugs won't be triggered because the patch forgot to update
MWDMA masks..  ;)

What is even more interesting is that the driver currently also lacks support
for MWDMA modes on UDMA66 chips (though it was implemented in the driver).

static const struct ata_port_info sis_info66 = {
	.flags		= ATA_FLAG_SLAVE_POSS,
	.pio_mask	= ATA_PIO4,
	/* No MWDMA */
	.udma_mask	= ATA_UDMA4,
	.port_ops	= &sis_66_ops,
};
static const struct ata_port_info sis_info100 = {
	.flags		= ATA_FLAG_SLAVE_POSS,
	.pio_mask	= ATA_PIO4,
	/* No MWDMA */
	.udma_mask	= ATA_UDMA5,
	.port_ops	= &sis_100_ops,
};
static const struct ata_port_info sis_info100_early = {
	.flags		= ATA_FLAG_SLAVE_POSS,
	.pio_mask	= ATA_PIO4,
	/* No MWDMA */
	.udma_mask	= ATA_UDMA5,
	.port_ops	= &sis_66_ops,
};
static const struct ata_port_info sis_info133 = {
	.flags		= ATA_FLAG_SLAVE_POSS,
	.pio_mask	= ATA_PIO4,
	/* No MWDMA */
	.udma_mask	= ATA_UDMA6,
	.port_ops	= &sis_133_ops,
};
const struct ata_port_info sis_info133_for_sata = {
	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
	.pio_mask	= ATA_PIO4,
	/* No MWDMA */
	.udma_mask	= ATA_UDMA6,
	.port_ops	= &sis_133_for_sata_ops,
};
static const struct ata_port_info sis_info133_early = {
	.flags		= ATA_FLAG_SLAVE_POSS,
	.pio_mask	= ATA_PIO4,
	/* No MWDMA */
	.udma_mask	= ATA_UDMA6,
	.port_ops	= &sis_133_early_ops,
};

--
Bartlomiej Zolnierkiewicz
