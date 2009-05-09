From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 01/14] ide-tape: fix potential fs requests bug
Date: Sat, 9 May 2009 10:02:45 +0200
Message-ID: <20090509080245.GB22617@uranus.ravnborg.org>
References: <1241855134-4984-1-git-send-email-petkovbb@gmail.com> <1241855134-4984-2-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753946AbZEIIAq@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1241855134-4984-2-git-send-email-petkovbb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, May 09, 2009 at 09:45:21AM +0200, Borislav Petkov wrote:
> ide-tape had a potential bug for fs requests when preparing the command
> packet: it was writing the transfer length as a number of fixed blocks.
> However, the block layer implies 512 byte blocks and ide-tape can have
> other block sizes so account for that too.
> 
> ide-floppy does this calculation properly with the block size factor
> (floppy->bs_factor).
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  drivers/ide/ide-tape.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index e166045..fc79cf4 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -586,7 +586,7 @@ static void ide_tape_create_rw_cmd(idetape_tape_t *tape,
>  				   struct ide_atapi_pc *pc, struct request *rq,
>  				   u8 opcode)
>  {
> -	unsigned int length = blk_rq_sectors(rq);
> +	unsigned int length = blk_rq_sectors(rq) / (tape->blk_size >> 9);

If tape->blk_size equals 256 or less then we get a divide-by-zero.

	Sam
