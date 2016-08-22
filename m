From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 1/4] libata: Safely overwrite attached page in WRITE
 SAME xlat
Date: Mon, 22 Aug 2016 08:27:50 +0200
Message-ID: <6d0c8773-dbf8-ea21-f3ca-dc1d05f52890@suse.de>
References: <20160822042321.24367-1-shaun@tancheff.com>
 <20160822042321.24367-2-shaun@tancheff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39879 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752810AbcHVG1w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 22 Aug 2016 02:27:52 -0400
In-Reply-To: <20160822042321.24367-2-shaun@tancheff.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, Tom Yan <tom.ty89@gmail.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>, Shaun Tancheff <shaun.tancheff@seagate.com>

On 08/22/2016 06:23 AM, Shaun Tancheff wrote:
> Safely overwriting the attached page to ATA format from the SCSI formatted
> variant.
> 
> Signed-off-by: Shaun Tancheff <shaun.tancheff@seagate.com>
> ---
> v6:
>  - Fix bisect bug reported by Tom Yan <tom.ty89@gmail.com>
>  - Change to use sg_copy_from_buffer as per Christoph Hellwig <hch@lst.de>
> v5:
>  - Added prep patch to work with non-page aligned scatterlist pages
>    and use kmap_atomic() to lock page during modification.
> 
>  drivers/ata/libata-scsi.c | 56 ++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/ata.h       | 26 ----------------------
>  2 files changed, 51 insertions(+), 31 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
