From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 1/4] libata: add R-Car SATA driver
Date: Tue, 28 May 2013 16:19:26 +0400
Message-ID: <51A4A0CE.9030203@cogentembedded.com>
References: <201302202310.30443.sergei.shtylyov@cogentembedded.com> <519FF3D6.2090202@cogentembedded.com> <51A14665.3070508@cogentembedded.com> <20130525232024.GA11304@mtj.dyndns.org> <20130525232301.GB11304@mtj.dyndns.org> <51A14A9E.5060605@cogentembedded.com> <20130526002311.GA11809@mtj.dyndns.org> <51A3C2E4.6070904@cogentembedded.com> <20130528000901.GA18219@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:65171 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933730Ab3E1MT2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 May 2013 08:19:28 -0400
Received: by mail-lb0-f178.google.com with SMTP id w10so7535364lbi.23
        for <linux-ide@vger.kernel.org>; Tue, 28 May 2013 05:19:26 -0700 (PDT)
In-Reply-To: <20130528000901.GA18219@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, vladimir.barinov@cogentembedded.com

On 28-05-2013 4:09, Tejun Heo wrote:

>>> Yeah, that's exactly where I'm confused.  ATA_DMA_BOUNDARY is 64k
>>> which becomes both queue_segment_boundary and dma seg_boundary.
>>> AFAICS, both __blk_segment_map_sg() and dma mapping won't merge across
>>> seg_boundary and as each bvec is a single page at most, we shouldn't
>>> need to worry about getting sg's which cross 64k boundaries in bmdma
>>> controllers.  Hmmmmm...... I gotta be missing something.  What am I
>>> missing here?

>>      Probably nothing... maybe Jeff just copied that from ATADRVR
>> (which was his inspiration IIRC).

    Maybe we should ask him instead of guessing. :-)

> Yeah, maybe.  I can't find any reason why ata_bmdma_fill_sg() would
> need to worry about 64k boundary.  The dumb variant is putting an
> extra restriction on it but the plain one doesn't seem to be adding
> anything.  Would you be interested in submitting a patch to remove
> those?

    Hm, at least not right now. I'm too busy.

>>     BTW, I've just done some experimentation with my R-Car target
>> and ATA_DEBUG/ATA_VERBOSE_DEBUG #define'd and it turned out
>> that block layer didn't merge any segments at all... :-/

> Even the ones with contiguous physical addresses?

     Exactly. All DMA segments were 4K in size, regardless of whether 
the addresses were adjacent or not.

> It could just be
> that the physical pages are disjoint as we don't really do anything to
> allocate pages contiguously and iommus don't kick in / merge unless
> necessary (it's not like modern hardware struggle with sglists
> anyway), so it could just be that there's nothing to merge.

    There were mergeable segments, for sure.

> Thanks.

MBR, Sergei

