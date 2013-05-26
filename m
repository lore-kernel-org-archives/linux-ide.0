From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 1/4] libata: add R-Car SATA driver
Date: Sun, 26 May 2013 09:23:11 +0900
Message-ID: <20130526002311.GA11809@mtj.dyndns.org>
References: <201302202310.30443.sergei.shtylyov@cogentembedded.com>
 <519FF3D6.2090202@cogentembedded.com>
 <51A14665.3070508@cogentembedded.com>
 <20130525232024.GA11304@mtj.dyndns.org>
 <20130525232301.GB11304@mtj.dyndns.org>
 <51A14A9E.5060605@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:61464 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758367Ab3EZAXP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 May 2013 20:23:15 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so4169170pde.32
        for <linux-ide@vger.kernel.org>; Sat, 25 May 2013 17:23:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51A14A9E.5060605@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, vladimir.barinov@cogentembedded.com

Hello, Sergei.

On Sun, May 26, 2013 at 03:34:54AM +0400, Sergei Shtylyov wrote:
>    Because with SFF-8038i  (BMIDE) controllers transfer can't cross
> 64KiB address boundaries. This function has to break up those S/G
> entries that do cross them. I.e. the PRD length is actually additionally
> limited by an offset of its start within 64KiB memory segment.
> Does this make sense? Or does the block layer already care about this?
> Hm, I'm not confident now, should revisit this after some sleep.

Yeah, that's exactly where I'm confused.  ATA_DMA_BOUNDARY is 64k
which becomes both queue_segment_boundary and dma seg_boundary.
AFAICS, both __blk_segment_map_sg() and dma mapping won't merge across
seg_boundary and as each bvec is a single page at most, we shouldn't
need to worry about getting sg's which cross 64k boundaries in bmdma
controllers.  Hmmmmm...... I gotta be missing something.  What am I
missing here?

Thanks.

-- 
tejun
