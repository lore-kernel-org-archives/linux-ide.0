From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/6] ata: fixup ATA_PROT_NODATA
Date: Mon, 20 Jun 2016 11:44:26 -0400
Message-ID: <20160620154426.GL3262@mtj.duckdns.org>
References: <1466422756-126637-1-git-send-email-hare@suse.de>
 <1466422756-126637-5-git-send-email-hare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36271 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231AbcFTPo3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2016 11:44:29 -0400
Received: by mail-yw0-f195.google.com with SMTP id f75so2780344ywb.3
        for <linux-ide@vger.kernel.org>; Mon, 20 Jun 2016 08:44:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1466422756-126637-5-git-send-email-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <damien.lemoal@hgst.com>, linux-ide@vger.kernel.org

On Mon, Jun 20, 2016 at 01:39:14PM +0200, Hannes Reinecke wrote:
> The taskfile protocol is a numeric value, and can not be ORed.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/libata-core.c | 4 ++--
>  drivers/ata/libata-eh.c   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e798915..d200102 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1238,7 +1238,7 @@ static int ata_read_native_max_address(struct ata_device *dev, u64 *max_sectors)
>  	} else
>  		tf.command = ATA_CMD_READ_NATIVE_MAX;
>  
> -	tf.protocol |= ATA_PROT_NODATA;
> +	tf.protocol = ATA_PROT_NODATA;
>  	tf.device |= ATA_LBA;

Did the above lead to any actual brekage or was tf.protocol guaranteed
to be zero always?  I wish the patch description described what the
stake of the patch is.

Thanks.

-- 
tejun
