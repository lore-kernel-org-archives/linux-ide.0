From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 1/4] libata: add R-Car SATA driver
Date: Tue, 28 May 2013 09:09:01 +0900
Message-ID: <20130528000901.GA18219@mtj.dyndns.org>
References: <201302202310.30443.sergei.shtylyov@cogentembedded.com>
 <519FF3D6.2090202@cogentembedded.com>
 <51A14665.3070508@cogentembedded.com>
 <20130525232024.GA11304@mtj.dyndns.org>
 <20130525232301.GB11304@mtj.dyndns.org>
 <51A14A9E.5060605@cogentembedded.com>
 <20130526002311.GA11809@mtj.dyndns.org>
 <51A3C2E4.6070904@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:58130 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758258Ab3E1AJI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 May 2013 20:09:08 -0400
Received: by mail-pb0-f43.google.com with SMTP id ma3so7270548pbc.16
        for <linux-ide@vger.kernel.org>; Mon, 27 May 2013 17:09:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51A3C2E4.6070904@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, vladimir.barinov@cogentembedded.com

Hello, Sergei.

On Tue, May 28, 2013 at 12:32:36AM +0400, Sergei Shtylyov wrote:
> >Yeah, that's exactly where I'm confused.  ATA_DMA_BOUNDARY is 64k
> >which becomes both queue_segment_boundary and dma seg_boundary.
> >AFAICS, both __blk_segment_map_sg() and dma mapping won't merge across
> >seg_boundary and as each bvec is a single page at most, we shouldn't
> >need to worry about getting sg's which cross 64k boundaries in bmdma
> >controllers.  Hmmmmm...... I gotta be missing something.  What am I
> >missing here?
> 
>     Probably nothing... maybe Jeff just copied that from ATADRVR
> (which was his inspiration IIRC).

Yeah, maybe.  I can't find any reason why ata_bmdma_fill_sg() would
need to worry about 64k boundary.  The dumb variant is putting an
extra restriction on it but the plain one doesn't seem to be adding
anything.  Would you be interested in submitting a patch to remove
those?

>    BTW, I've just done some experimentation with my R-Car target
> and ATA_DEBUG/ATA_VERBOSE_DEBUG #define'd and it turned out
> that block layer didn't merge any segments at all... :-/

Even the ones with contiguous physical addresses?  It could just be
that the physical pages are disjoint as we don't really do anything to
allocate pages contiguously and iommus don't kick in / merge unless
necessary (it's not like modern hardware struggle with sglists
anyway), so it could just be that there's nothing to merge.

Thanks.

-- 
tejun
