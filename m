From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 1/4] libata: add R-Car SATA driver
Date: Sun, 26 May 2013 08:20:24 +0900
Message-ID: <20130525232024.GA11304@mtj.dyndns.org>
References: <201302202310.30443.sergei.shtylyov@cogentembedded.com>
 <519FF3D6.2090202@cogentembedded.com>
 <51A14665.3070508@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:61253 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758177Ab3EYXU2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 May 2013 19:20:28 -0400
Received: by mail-pa0-f45.google.com with SMTP id tj12so613700pac.4
        for <linux-ide@vger.kernel.org>; Sat, 25 May 2013 16:20:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51A14665.3070508@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, vladimir.barinov@cogentembedded.com

Hey,

On Sun, May 26, 2013 at 03:16:53AM +0400, Sergei Shtylyov wrote:
> >   This value should have been put into the 'dma_boundary' field of the
> >'struct scsi_host_template', IIUC. Tejun, if I do it, do I need
> >this check at all?
> 
>    You haven't replied, so I went and searched an answer myself. Indeed,
> it's enough to specify the right 'dma_boundary' and stop bothering about it.
> Expect two patches to the driver. I think the correct branch for
> them will be
> 'for-3.11'.

I was just about to reply.  Yes, it should be enough.  Both block
layer and the dma machniery honors the DMA boundary and segment size,
which are configured from __scsi_alloc_queue().

Thanks!

-- 
tejun
