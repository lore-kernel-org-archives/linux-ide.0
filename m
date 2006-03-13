From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/4] libata: add per-dev pio/mwdma/udma_mask
Date: Mon, 13 Mar 2006 18:30:52 +0900
Message-ID: <20060313093052.GB2091@htj.dyndns.org>
References: <11421469551000-git-send-email-htejun@gmail.com> <44152D64.6000903@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:12433 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932388AbWCMJa6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 04:30:58 -0500
Received: by zproxy.gmail.com with SMTP id 14so1240740nzn
        for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 01:30:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <44152D64.6000903@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On Mon, Mar 13, 2006 at 03:29:24AM -0500, Jeff Garzik wrote:
> Tejun Heo wrote:
> >Add per-dev pio/mwdma/udma_mask.  All transfer mode limits used to be
> >applied to ap->*_mask which unnecessarily restricted other devices
> >sharing the port.  This change will also benefit later EH speed down
> >and hotplug.
> >
> >Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> I don't see much value in the separation.  Rather than 3 separate masks, 
> it seems like this patch would be simplified if you simply added 
> dev->xfer_mask.
> 

The thing is that ap->*_mask's are separated the same way and all
masking constants are defined as such.  e.g.

	ap->udma_mask &= ATA_UDMA5;
or
	ap->udma_mask &= ATA_UDMA_MASK_40C;

Making dev->*_mask's the same enables share those constants and code
convention.  So, things to consider here are...

1. Port xfer masks are defined as three separate masks.

2. All the constants are defined according to that.

3. Three separate masks are easier to deal with for LLDD's.

I'm okay either way but using different approach for port and device
doesn't sound too hot.

-- 
tejun
