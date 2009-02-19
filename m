From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] fix dma_unmap_sg misuse
Date: Thu, 19 Feb 2009 17:06:46 +0100
Message-ID: <200902191706.46661.bzolnier@gmail.com>
References: <20090217133432M.fujita.tomonori@lab.ntt.co.jp> <200902182159.49980.bzolnier@gmail.com> <20090219220401T.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:11791 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558AbZBSRVM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Feb 2009 12:21:12 -0500
Received: by mu-out-0910.google.com with SMTP id i10so364026mue.1
        for <linux-ide@vger.kernel.org>; Thu, 19 Feb 2009 09:21:10 -0800 (PST)
In-Reply-To: <20090219220401T.fujita.tomonori@lab.ntt.co.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-ide@vger.kernel.org

On Thursday 19 February 2009, FUJITA Tomonori wrote:
> On Wed, 18 Feb 2009 21:59:49 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > On Tuesday 17 February 2009, FUJITA Tomonori wrote:
> > > Looks like that libata misuses dma_unmap_sg though I'm not familiar
> > > with libata so I might completely misunderstand something.
> > > 
> > > =
> > > From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> > > Subject: [PATCH] fix dma_unmap_sg misuse
> > > 
> > > DMA-mapping.txt says:
> > > 
> > > To unmap a scatterlist, just call:
> > > 
> > > 	pci_unmap_sg(pdev, sglist, nents, direction);
> > > 
> > > Again, make sure DMA activity has already finished.
> > > 
> > > PLEASE NOTE:  The 'nents' argument to the pci_unmap_sg call must be
> > >               the _same_ one you passed into the pci_map_sg call,
> > > 	      it should _NOT_ be the 'count' value _returned_ from the
> > >               pci_map_sg call.
> > 
> > This is correct and other subsystems (SCSI, IDE) are compliant with it.
> > 
> > > Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> > 
> > Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Thanks,
> 
> I guess that the ide stack has the same problem (I guess that you
> already knew that though).
> 
> Looks like that the ide stack in linux-next has more serious problem
> about handling dma_map_sg?
> 
> In linux-next, the ide doesn't save the returned value of dma_map_sg
> and assumes that dma_map_sg returns the same value to the 'nents'
> argument of dma_map_sg?
> 
> Again I'm not familiar with the ide stack at all so I might completely
> misunderstand something.
> 
> =
> From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Date: Thu, 19 Feb 2009 21:51:17 +0900
> Subject: [PATCH] ide: save the returned value of dma_map_sg
> 
> dma_map_sg could return a value different to 'nents' argument of
> dma_map_sg so the ide stack needs to save it for the later usage
> (e.g. for_each_sg).
> 
> The ide stack also needs to save the original sg_nents value for
> pci_unmap_sg.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

applied, thanks!
