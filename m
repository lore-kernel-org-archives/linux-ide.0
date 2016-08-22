From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 0/4] SCT Write Same
Date: Mon, 22 Aug 2016 08:32:15 +0200
Message-ID: <a1cd7eaf-4fd2-7aba-be57-c3defa3d1a1c@suse.de>
References: <20160822042321.24367-1-shaun@tancheff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40029 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751541AbcHVGcQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 22 Aug 2016 02:32:16 -0400
In-Reply-To: <20160822042321.24367-1-shaun@tancheff.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, Tom Yan <tom.ty89@gmail.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

On 08/22/2016 06:23 AM, Shaun Tancheff wrote:
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
> 
> This patch against v4.8-rc2 is also at
>     https://github.com/stancheff/linux/tree/v4.8-rc2%2Bbiof.v9
> 
>     git@github.com:stancheff/linux.git v4.8-rc2+biof.v9
> 
> v6:
>  - Fix bisect bug reported by Tom Yan <tom.ty89@gmail.com>
>  - Change to use sg_copy_from_buffer as per Christoph Hellwig <hch@lst.de>
>  - Added support for a sector_size descriptor other than 512 bytes.
> v5:
>  - Addressed review comments
>  - Report support for ZBC only for zoned devices.
>  - kmap page during rewrite
>  - Fix unmap set to require trim or error, if not unmap then sct write
>    same or error.
> v4:
>  - Added partial MAINTENANCE_IN opcode simulation
>  - Dropped all changes in drivers/scsi/*
>  - Changed to honor the UNMAP flag -> TRIM, no UNMAP -> SCT.
> v3:
>  - Demux UNMAP/TRIM from WRITE SAME
> v2:
>  - Remove fugly ata hacking from sd.c
> 
> Shaun Tancheff (4):
>   libata: Safely overwrite attached page in WRITE SAME xlat
>   Add support for SCT Write Same
>   SCT Write Same / DSM Trim
>   SCT Write Same handle ATA_DFLAG_PIO
> 
>  drivers/ata/libata-scsi.c | 280 +++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/ata.h       |  69 +++++++-----
>  2 files changed, 292 insertions(+), 57 deletions(-)
> 
Thanks for doing this.
It has been on my To-Do list for a long time, and it's good to see the
UNMAP/TRIM SATL cleaned up finally.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
