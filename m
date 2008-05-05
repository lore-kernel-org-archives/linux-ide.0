From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] ide: set REQ_NOMERGE request flag in ide_do_drive_cmd()
Date: Mon, 5 May 2008 18:31:11 +0200
Message-ID: <200805051831.12574.bzolnier@gmail.com>
References: <200805031514.24727.bzolnier@gmail.com> <20080505204334P.tomof@acm.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:12024 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbYEEQdB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 May 2008 12:33:01 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1107897nfc.21
        for <linux-ide@vger.kernel.org>; Mon, 05 May 2008 09:32:59 -0700 (PDT)
In-Reply-To: <20080505204334P.tomof@acm.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, petkovbb@gmail.com, jens.axboe@oracle.com

On Monday 05 May 2008, FUJITA Tomonori wrote:
> On Sat, 3 May 2008 15:14:24 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > This is a preparation for converting IDE to use blk_execute_rq().
> > 
> > There should be no functional changes caused by this patch.
> > 
> > Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> > Cc: Borislav Petkov <petkovbb@gmail.com>
> > Cc: Jens Axboe <jens.axboe@oracle.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  drivers/ide/ide-io.c |    2 ++
> >  1 file changed, 2 insertions(+)
> 
> I think that you can drop this since the block layer doesn't check
> REQ_NOMERGE with the way ide_do_drive_cmd queues requests.

Yeah, I see now that REQ_NOMERGE only matters for fs requests.

Dropped.
