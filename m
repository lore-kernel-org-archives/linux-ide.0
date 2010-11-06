From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] IDE: ide-floppy, remove unnecessary NULL check
Date: Sat, 6 Nov 2010 13:10:14 +0100
Message-ID: <20101106121014.GA25287@liondog.tnic>
References: <1289034412-24278-1-git-send-email-jslaby@suse.cz>
 <1289034412-24278-3-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1289034412-24278-3-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: jirislaby@gmail.com, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, Nov 06, 2010 at 10:06:51AM +0100, Jiri Slaby wrote:
> Stanse founf that rq in ide_floppy_callback cannot be NULL, because it
> is dereferenced all around. So remove the superfluous check.
> 
> This appeared after blk_* macors removal.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-ide@vger.kernel.org
> ---
>  drivers/ide/ide-floppy.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
> index 5406b6e..536ff68 100644
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c
> @@ -73,7 +73,7 @@ static int ide_floppy_callback(ide_drive_t *drive, int dsc)
>  		drive->failed_pc = NULL;
>  
>  	if (pc->c[0] == GPCMD_READ_10 || pc->c[0] == GPCMD_WRITE_10 ||
> -	    (rq && rq->cmd_type == REQ_TYPE_BLOCK_PC))
> +	    rq->cmd_type == REQ_TYPE_BLOCK_PC)
>  		uptodate = 1; /* FIXME */
>  	else if (pc->c[0] == GPCMD_REQUEST_SENSE) {

If this isn't a fix for a real bug, then there's no need for it since
IDE is deprecated and thus in bugfix mode only.

-- 
Regards/Gruss,
    Boris.
