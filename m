From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Mon, 22 Jun 2009 23:35:06 +0200
Message-ID: <200906222335.06700.bzolnier@gmail.com>
References: <200906211446.38598.elendil@planet.nl> <200906221938.27574.bzolnier@gmail.com> <200906222101.38586.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <200906222101.38586.elendil@planet.nl>
Content-Disposition: inline
Sender: sparclinux-owner@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Monday 22 June 2009 21:01:37 Frans Pop wrote:
> On Monday 22 June 2009, Bartlomiej Zolnierkiewicz wrote:
> > On Monday 22 June 2009 17:16:04 Frans Pop wrote:
> > Thanks.  Please notice 0701 0701 words above -- it means that this
> > device reports both SWDMA0 and MWDMA0 enabled at once (which results
> > in IDE layer failing DMA tuning).
> >
> > The patch below should fix it
> 
> Yes, this gives back MWDMA2 for hdd.

Cool.

> > and it would be quite interesting to try 
> > it on vanilla kernel to see if it helps with unexpected IRQ problem.
> 
> Will do later.
> 
> > However this still doesn't explain the regression fully -- we had
> > ide_id_dma_bug() checks since Dec 2007 (and equivalent
> > ide_dma_verbose() ones since almost forever) while 2.6.26 (which works
> > fine) is much younger than that.  I suspect that there are some other
> > kernel changes coming into the picture (Power Management?).  Would it
> > be possible to try 2.6.2[78] and/or bisect this problem further?
> 
> I suspect commit 8d64fcd9 "ide: identify data word 53 bit 1 doesn't cover 
> words 62 and 63 (take 3)":
> @@ -396,15 +393,14 @@ int ide_id_dma_bug(ide_drive_t *drive)
>  
>  	if (id[ATA_ID_FIELD_VALID] & 4) {
>  		if ((id[ATA_ID_UDMA_MODES] >> 8) &&
>  		    (id[ATA_ID_MWDMA_MODES] >> 8))
>  			goto err_out;
> -	} else if (id[ATA_ID_FIELD_VALID] & 2) {
> -		if ((id[ATA_ID_MWDMA_MODES] >> 8) &&
> -		    (id[ATA_ID_SWDMA_MODES] >> 8))
> -			goto err_out;
> -	}
> +	} else if ((id[ATA_ID_MWDMA_MODES] >> 8) &&
> +		   (id[ATA_ID_SWDMA_MODES] >> 8))
> +		goto err_out;
> 
> 
> The logs I posted were from 2.6.30. I also tried 2.6.29 and that did *not* 

This breaks my beautiful theory about the root cause of unexpected IRQs.. ;(

> yet have the DMA problem. The commit above is from the 2.6.30 development 
> cycle, so that fits. I expect you can verify it from the identify data.

I had the same idea initially, unfortunately bit 1 is set for word 53 so this
must be something else...

> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] ide: relax DMA info validity checking
> >
> > There are some broken devices that report multiple DMA xfer modes
> > enabled at once (ATA spec doesn't allow it) but otherwise work fine
> > with DMA so just delete ide_id_dma_bug().
> 
> The question is maybe: are there other devices that currently have dma 
> disabled because of the (old) code and would stop working with 
> ide_id_dma_bug() completely removed? The conservative thing to do I guess 
> would be to reverse 8d64fcd9.

This is quite unlikely given that libata has never had such checks..

> There is one thing I should mention here. I have been seeing the following 
> error with this CD drive:
> ide-cd: hdd: weird block size 2352
> ide-cd: hdd: default to 2kb block size
> 
> This was present with 2.6.26 and also now with 2.6.31; not sure about 
> older kernels. I initially saw it with a self-burned Debian installation 
> CD. I also now see it with an audio CD. It does not seem to affect 
> reading the disks: installations go fine and the audio CD plays without 
> any problems.
> 
> Any risk this may be related to something we've been discussing so far, or 
> is this a separate issue?

This is just a harmless warning coming from enabling of the workaround for
weird ATAPI devices (the one you have in this sparc machine seems to score
really high on the weirdness scale ;) introduced by commit e8e7b9e.
