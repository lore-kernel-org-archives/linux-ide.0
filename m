From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v6 0/4] SCT Write Same
Date: Thu, 25 Aug 2016 11:28:11 -0400
Message-ID: <20160825152811.GA20479@htj.duckdns.org>
References: <20160822042321.24367-1-shaun@tancheff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34465 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759634AbcHYP2t (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Aug 2016 11:28:49 -0400
Content-Disposition: inline
In-Reply-To: <20160822042321.24367-1-shaun@tancheff.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun@tancheff.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Tom Yan <tom.ty89@gmail.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

Hello,

On Sun, Aug 21, 2016 at 11:23:17PM -0500, Shaun Tancheff wrote:
> At some point the method of issuing Write Same for ATA drives changed.
> Currently write same is commonly available via SCT so expose the SCT
> capabilities and use SCT Write Same when it is available.
> 
> This is useful for zoned based media that prefers to support discard
> with lbprz set, aka discard zeroes data by mapping discard operations to
> reset write pointer operations. Conventional zones that do not support
> reset write pointer can still honor the discard zeroes data by issuing
> a write same over the zone.
> 
> It may also be nice to know if various controllers that currently
> disable WRITE SAME will work with the SCT Write Same code path:
>   aacraid, arcmsr, megaraid, 3w-9xxx, 3w-sas, 3w-xxxx, gdth, hpsa, ips,
>   megaraid, pmcraid, storvsc_drv

Applied 1-4 to libata/for-4.9.

Thanks.

-- 
tejun
