From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/5] pata_sis: Implement MWDMA for the UDMA 133 capable chips
Date: Tue, 17 Nov 2009 18:57:01 +0100
Message-ID: <200911171857.01805.bzolnier@gmail.com>
References: <20091117144450.15430.83450.stgit@localhost.localdomain> <200911171827.29891.bzolnier@gmail.com> <20091117173823.217b95a7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:40257 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706AbZKQR6L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Nov 2009 12:58:11 -0500
In-Reply-To: <20091117173823.217b95a7@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tuesday 17 November 2009 18:38:23 Alan Cox wrote:
> > > +static int mwdma_clip_to_pio(struct ata_device *adev)
> > > +{
> > > +	const int mwdma_to_pio[3] = {
> > > +		XFER_PIO_0, XFER_PIO_3, XFER_PIO_4
> > > +	};
> > > +	return min(mwdma_to_pio[adev->dma_mode - XFER_MW_DMA_0],
> > > +				adev->pio_mode - XFER_PIO_0);
> > > +}
> > 
> > This wants to be in the generic libata code.
> 
> I'm not convinced because for the majority of drivers the libata timing
> interface handles it. SiS needs it just because it does things by
> precomputed tables. It's a one off interface.

Controllers based on *Intel* PIIX are in the disagreement with the above
paragraph and having generic helper to do conversion (without a clipping)
would bring us a little step closer to killing a needless code duplication
currently present in their ->set_piomode and ->set_dmamode methods.

[ In case somebody wonders: no, 'old' drivers don't have such duplication
  and 'whoever did it didn't port it across' cause said 'whoever'-s were not
  into the development of the square wheels.... ]

-- 
Bartlomiej Zolnierkiewicz
