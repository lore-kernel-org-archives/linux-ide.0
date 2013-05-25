From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 1/4] libata: add R-Car SATA driver
Date: Sun, 26 May 2013 08:23:07 +0900
Message-ID: <20130525232301.GB11304@mtj.dyndns.org>
References: <201302202310.30443.sergei.shtylyov@cogentembedded.com>
 <519FF3D6.2090202@cogentembedded.com>
 <51A14665.3070508@cogentembedded.com>
 <20130525232024.GA11304@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:57081 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758177Ab3EYXXL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 May 2013 19:23:11 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf10so4564376pab.10
        for <linux-ide@vger.kernel.org>; Sat, 25 May 2013 16:23:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130525232024.GA11304@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, vladimir.barinov@cogentembedded.com

On Sun, May 26, 2013 at 08:20:24AM +0900, Tejun Heo wrote:
> Hey,
> 
> On Sun, May 26, 2013 at 03:16:53AM +0400, Sergei Shtylyov wrote:
> > >   This value should have been put into the 'dma_boundary' field of the
> > >'struct scsi_host_template', IIUC. Tejun, if I do it, do I need
> > >this check at all?
> > 
> >    You haven't replied, so I went and searched an answer myself. Indeed,
> > it's enough to specify the right 'dma_boundary' and stop bothering about it.
> > Expect two patches to the driver. I think the correct branch for
> > them will be
> > 'for-3.11'.
> 
> I was just about to reply.  Yes, it should be enough.  Both block
> layer and the dma machniery honors the DMA boundary and segment size,
> which are configured from __scsi_alloc_queue().

But I'm a bit confused about ata_bmdma_fill_sg().  ATA_BMDMA_SHT sets
the DMA boundary to 0xffff, so I have no idea why it's explicitly
checking the DMA boundary in the function again.  What am I missing?

-- 
tejun
