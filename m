From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 02/14] ide-atapi: switch to blk_rq_bytes() on do_request() path
Date: Sun, 10 May 2009 23:32:29 +0200
Message-ID: <200905102332.29839.bzolnier@gmail.com>
References: <1241855134-4984-1-git-send-email-petkovbb@gmail.com> <1241855134-4984-3-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:60750 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbZEJVf7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 May 2009 17:35:59 -0400
In-Reply-To: <1241855134-4984-3-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 09 May 2009 09:45:22 Borislav Petkov wrote:
> After the recent struct request cleanups, blk_rq_bytes() is guaranteed
> to be valid and is the current total length of the rq's bio. Use that
> instead of pc->req_xfer in the do_request() path after the command has
> been queued.
> 
> The remaining usage of pc->req_xfer now is only until we map the rq to a
> bio.
> 
> While at it:
> 
> - remove local caching of rq completion length in ide_tape_issue_pc()
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  drivers/ide/ide-atapi.c  |   12 +++++++-----
>  drivers/ide/ide-floppy.c |    8 ++++----
>  drivers/ide/ide-tape.c   |   12 ++++++------
>  3 files changed, 17 insertions(+), 15 deletions(-)

[...]

> @@ -592,8 +593,7 @@ static void ide_tape_create_rw_cmd(idetape_tape_t *tape,
>  	put_unaligned(cpu_to_be32(length), (unsigned int *) &pc->c[1]);
>  	pc->c[1] = 1;
>  	pc->buf = NULL;
> -	pc->buf_size = length * tape->blk_size;
> -	pc->req_xfer = pc->buf_size;
> +	pc->buf_size = blk_rq_bytes(rq);
>  	if (pc->req_xfer == tape->buffer_size)

Seems like this chunk also needs s/pc->req_xfer/pc->buf_size/ fixup.
