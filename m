From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide-cd: fix REQ_QUIET tests in cdrom_decode_status
Date: Tue, 28 Apr 2009 14:37:04 +0400
Message-ID: <49F6DC50.7000106@ru.mvista.com>
References: <9ea470500904270903n720ab411o4a6c47945442bea4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:65429 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758762AbZD1Kfx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Apr 2009 06:35:53 -0400
In-Reply-To: <9ea470500904270903n720ab411o4a6c47945442bea4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Helge Deller <deller@gmx.de>, Jens Axboe <jens.axboe@oracle.com>

Borislav Petkov wrote:

> Original patch (dfa4411cc3a690011cab90e9a536938795366cf9) was buggy.
> This is a more proper fix which introduces blk_rq_quiet() macro
> alleviating the need for dumb, too short caching variables.

> Thanks to Helge Deller and Bart for debugging this.

> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ba54c83..6f841fb 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -598,6 +598,7 @@ enum {
>  				 blk_failfast_transport(rq) ||	\
>  				 blk_failfast_driver(rq))
>  #define blk_rq_started(rq)	((rq)->cmd_flags & REQ_STARTED)
> +#define blk_rq_quiet(rq)	((rq)->cmd_flags & REQ_QUIET)
> 
>  #define blk_account_rq(rq)	(blk_rq_started(rq) && (blk_fs_request(rq)
> || blk_discard_rq(rq)))

    The patch looks like-wrapped...

MBR, Sergei
