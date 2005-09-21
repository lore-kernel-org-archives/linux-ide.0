From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [PATCH libata-dev-2.6:passthru] passthru fixes
Date: Wed, 21 Sep 2005 10:32:23 -0400
Message-ID: <20050921143221.GB23290@tuxdriver.com>
References: <20050913142636.GB5679@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ra.tuxdriver.com ([24.172.12.4]:52492 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751000AbVIUOcg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Sep 2005 10:32:36 -0400
Content-Disposition: inline
In-Reply-To: <20050913142636.GB5679@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Raubitschek <jhr@google.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Tue, Sep 13, 2005 at 07:26:36AM -0700, Jeff Raubitschek wrote:
> Fix a few problems seen with the passthru branch:
> 
> - leaked scsi_request on buffer allocate failure
> - passthru sense routines were refering to tf->command
>   which is not read in tf_read, instead use drv_stat for
>   status register.
> - passthru sense passed back to user on ata_task_ioctl
> 
> Patch is against the current libata-dev passthru branch.
> 
> Signed-off-by: Jeff Raubitschek <jhr@google.com>

Acked-by: John W. Linville <linville@tuxdriver.com>

The first hunk, in particular, looks like it could explain the
mysterious lockups/failures when using smartctl/smartd w/ libata.

> diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
> --- a/drivers/scsi/libata-scsi.c
> +++ b/drivers/scsi/libata-scsi.c
> @@ -116,8 +116,10 @@ int ata_cmd_ioctl(struct scsi_device *sc
>  	if (args[3]) {
>  		argsize = SECTOR_SIZE * args[3];
>  		argbuf = kmalloc(argsize, GFP_KERNEL);
> -		if (argbuf == NULL)
> -			return -ENOMEM;
> +		if (argbuf == NULL) {
> +			rc = -ENOMEM;
> +			goto error;
> +		}
>  
>  		scsi_cmd[1]  = (4 << 1); /* PIO Data-in */
>  		scsi_cmd[2]  = 0x0e;     /* no off.line or cc, read from dev,

-- 
John W. Linville
linville@tuxdriver.com
