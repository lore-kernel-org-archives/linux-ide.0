From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 2/2] block: Add iocontext priority to request
Date: Thu, 6 Oct 2016 08:24:54 +0200
Message-ID: <5e96d531-8636-8e63-0ea8-e134676109c2@suse.de>
References: <1475694007-11999-1-git-send-email-adam.manzanares@hgst.com>
 <1475694007-11999-3-git-send-email-adam.manzanares@hgst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49293 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751711AbcJFGY4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 6 Oct 2016 02:24:56 -0400
In-Reply-To: <1475694007-11999-3-git-send-email-adam.manzanares@hgst.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adam Manzanares <adam.manzanares@hgst.com>, axboe@kernel.dk, tj@kernel.org
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org

On 10/05/2016 09:00 PM, Adam Manzanares wrote:
> Patch adds an association between iocontext ioprio and the ioprio of
> a request. This feature is only enabled if a queue flag is set to
> indicate that requests should have ioprio associated with them. The
> queue flag is exposed as the req_prio queue sysfs entry.
>
> Signed-off-by: Adam Mananzanares <adam.manzanares@hgst.com>
> ---
>  block/blk-core.c       |  8 +++++++-
>  block/blk-sysfs.c      | 32 ++++++++++++++++++++++++++++++++
>  include/linux/blkdev.h |  2 ++
>  3 files changed, 41 insertions(+), 1 deletion(-)
>
As the previous patch depends on this one it should actually be the 
first in the series.

But other than that:

Reviewed-by: Hannes Reinecke <hare@xuse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: J. Hawn, J. Guild, F. Imendörffer, HRB 16746 (AG Nürnberg)
