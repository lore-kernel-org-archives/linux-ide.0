From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] libata: Cleanup ata_read_log_page()
Date: Mon, 10 Jul 2017 09:10:19 +0200
Message-ID: <28f1969c-7422-ce34-fdfb-b00691eea055@suse.de>
References: <20170710054520.24213-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48996 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751124AbdGJHKV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 10 Jul 2017 03:10:21 -0400
In-Reply-To: <20170710054520.24213-1-damien.lemoal@wdc.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

On 07/10/2017 07:45 AM, Damien Le Moal wrote:
> The warning message "READ LOG DMA EXT failed, trying unqueued" in
> ata_read_log_page() as well as the macro name ATA_HORKAGE_NO_NCQ_LOG
> are confusing: the command READ LOG DMA EXT is not an queued NCQ command
> unless it is encapsulated in a RECEIVE FPDMA QUEUED command.
> From ACS-4 READ LOG DMA EXT description:
> 
> "The device processes the READ LOG DMA EXT command in the NCQ feature
> set environment (see 4.13.6) if the READ LOG DMA EXT command is
> encapsulated in a RECEIVE FPDMA QUEUED command (see 7.30) with the
> inputs encapsulated as shown in 7.23.6."
> 
> To avoid confusion, fix the warning messsage to mention switching to PIO and
> not "unqueued" and rename the macro ATA_HORKAGE_NO_NCQ_LOG to
> ATA_HORKAGE_NO_DMA_LOG.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  drivers/ata/libata-eh.c | 6 +++---
>  include/linux/libata.h  | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
You are correct.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
