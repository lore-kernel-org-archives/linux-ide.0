From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH] fix dma_unmap_sg misuse
Date: Thu, 19 Feb 2009 22:09:03 +0900
Message-ID: <20090219220553P.fujita.tomonori@lab.ntt.co.jp>
References: <20090217133432M.fujita.tomonori@lab.ntt.co.jp>
	<20090218171235.721d241a@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:55111 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113AbZBSNJX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Feb 2009 08:09:23 -0500
In-Reply-To: <20090218171235.721d241a@dhcp-100-2-144.bos.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: cebbert@redhat.com
Cc: fujita.tomonori@lab.ntt.co.jp, linux-ide@vger.kernel.org

On Wed, 18 Feb 2009 17:12:35 -0500
Chuck Ebbert <cebbert@redhat.com> wrote:

> On Tue, 17 Feb 2009 13:35:27 +0900
> FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:
> 
> > From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> > Subject: [PATCH] fix dma_unmap_sg misuse
> > 
> > DMA-mapping.txt says:
> > 
> > To unmap a scatterlist, just call:
> > 
> > 	pci_unmap_sg(pdev, sglist, nents, direction);
> > 
> > Again, make sure DMA activity has already finished.
> > 
> > PLEASE NOTE:  The 'nents' argument to the pci_unmap_sg call must be
> >               the _same_ one you passed into the pci_map_sg call,
> > 	      it should _NOT_ be the 'count' value _returned_ from the
> >               pci_map_sg call.
> > 
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> > ---
> >  drivers/ata/libata-core.c |    4 ++--
> >  include/linux/libata.h    |    1 +
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index 9fbf059..5e324ce 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -4612,7 +4612,7 @@ void ata_sg_clean(struct ata_queued_cmd *qc)
> >  	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
> >  
> >  	if (qc->n_elem)
> 
> 	if (qc->orig_n_elem)
> ?

Either is fine because when n_elem is not zero, qc->orig_n_elem is not
zero.

> 
> > -		dma_unmap_sg(ap->dev, sg, qc->n_elem, dir);
> > +		dma_unmap_sg(ap->dev, sg, qc->orig_n_elem, dir);
> >  
> >  	qc->flags &= ~ATA_QCFLAG_DMAMAP;
> >  	qc->sg = NULL;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
