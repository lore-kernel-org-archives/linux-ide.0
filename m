From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-floppy: use scatterlists for pio transfers
Date: Wed, 6 Aug 2008 18:05:00 +0200
Message-ID: <200808061805.01126.bzolnier@gmail.com>
References: <20080805051113.GA15834@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:16883 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759319AbYHFQn1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Aug 2008 12:43:27 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1535fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 06 Aug 2008 09:43:25 -0700 (PDT)
In-Reply-To: <20080805051113.GA15834@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Tuesday 05 August 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> here's my first stab at using scatterlists in ide-floppy. I've adapted your
> ide-scsi version to fit in here. The change here is that i use pc->b_count as
> a sort-of completion counter to know when i'm at the end of the sg element and
> be able to switch to the next/finish transfer. I've tested the patch with the
> Iomega ZIP drive i have here - it works. We should do some more testing first
> though, before sending it upstream.

[...]

> @@ -569,7 +577,7 @@ static void idefloppy_create_rw_cmd(idefloppy_floppy_t *floppy,
>  	memcpy(rq->cmd, pc->c, 12);
>  
>  	pc->rq = rq;
> -	pc->b_count = cmd == READ ? 0 : rq->bio->bi_size;
> +	pc->b_count = 0;
>  	if (rq->cmd_flags & REQ_RW)
>  		pc->flags |= PC_FLAG_WRITING;
>  	pc->buf = NULL;

Don't we also need to zero pc->b_count in idefloppy_blockpc_cmd()?

[ idefloppy_init_pc() clears whole pc so ->b_count assignment
  to zero is not strictly necessary ]

Except that it looks all good, thanks for working on it.
