From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 2/4] Add support for SCT Write Same
Date: Mon, 22 Aug 2016 08:27:30 +0200
Message-ID: <ab0f30e9-4f6d-843c-5675-ce7c77e1034e@suse.de>
References: <20160822042321.24367-1-shaun@tancheff.com>
 <20160822042321.24367-3-shaun@tancheff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbcHVG1d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 22 Aug 2016 02:27:33 -0400
In-Reply-To: <20160822042321.24367-3-shaun@tancheff.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, Tom Yan <tom.ty89@gmail.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>, Shaun Tancheff <shaun.tancheff@seagate.com>

On 08/22/2016 06:23 AM, Shaun Tancheff wrote:
> SATA drives may support write same via SCT. This is useful
> for setting the drive contents to a specific pattern (0's).
> 
> Translate a SCSI WRITE SAME 16 command to be either a DSM TRIM
> command or an SCT Write Same command.
> 
> Based on the UNMAP flag:
>   - When set translate to DSM TRIM
>   - When not set translate to SCT Write Same
> 
> Signed-off-by: Shaun Tancheff <shaun.tancheff@seagate.com>
> ---
> v6:
>  - Change to use sg_copy_from_buffer as per Christoph Hellwig <hch@lst.de>
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
>  drivers/ata/libata-scsi.c | 199 +++++++++++++++++++++++++++++++++++++++-------
>  include/linux/ata.h       |  43 ++++++++++
>  2 files changed, 213 insertions(+), 29 deletions(-)
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
