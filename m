From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Tue, 21 Feb 2017 17:18:01 -0500
Message-ID: <20170221221801.GE8260@htj.duckdns.org>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com>
 <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
 <CAMuHMdWX-PT_8a==rqAvc5Hx_1PNWPwvLGPeERUXvsMcEarziQ@mail.gmail.com>
 <1548730.TDiBKU8UQt@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548730.TDiBKU8UQt@amdc3058>
Sender: linux-m68k-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitzmic@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
List-Id: linux-ide@vger.kernel.org

On Mon, Feb 20, 2017 at 07:15:34PM +0100, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Subject: [PATCH] pata_falcon: build fix for block layer changes
> 
> commit aebf526b53ae ("block: fold cmd_type into the REQ_OP_
> space") from the block tree removes cmd_type so pata_falcon
> needs the following trivial update to make it build again.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> Tejun, I guess that you may need to fold this fix into
> your pull request for 4.11 (block layer pull request has
> been already sent by Jens so it will be most likely merged
> first).
> 
>  drivers/ata/pata_falcon.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: b/drivers/ata/pata_falcon.c
> ===================================================================
> --- a/drivers/ata/pata_falcon.c	2017-02-20 18:40:04.174989455 +0100
> +++ b/drivers/ata/pata_falcon.c	2017-02-20 18:42:59.482993870 +0100
> @@ -54,7 +54,7 @@ static unsigned int pata_falcon_data_xfe
>  	bool swap = 1;
>  
>  	if (dev->class == ATA_DEV_ATA && cmd && cmd->request &&
> -	    cmd->request->cmd_type == REQ_TYPE_FS)
> +	    !blk_rq_is_passthrough(cmd->request))

Sent it along with the pull request.

Thanks.

-- 
tejun
