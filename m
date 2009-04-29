From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-cd: fix REQ_QUIET tests in cdrom_decode_status
Date: Wed, 29 Apr 2009 07:26:00 +0200
Message-ID: <20090429052600.GA3128@liondog.tnic>
References: <9ea470500904270903n720ab411o4a6c47945442bea4@mail.gmail.com> <49F777BE.6010608@gmx.de>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f163.google.com ([209.85.218.163]:47536 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbZD2F0L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Apr 2009 01:26:11 -0400
Received: by bwz7 with SMTP id 7so948781bwz.37
        for <linux-ide@vger.kernel.org>; Tue, 28 Apr 2009 22:26:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49F777BE.6010608@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Helge Deller <deller@gmx.de>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, sshtylyov@ru.mvista.com

On Tue, Apr 28, 2009 at 11:40:14PM +0200, Helge Deller wrote:
> Borislav Petkov wrote:
> > From: Borislav Petkov <petkovbb@gmail.com>
> > Date: Mon, 27 Apr 2009 14:11:32 +0200
> > Subject: [PATCH] ide-cd: fix REQ_QUIET tests in cdrom_decode_status
> > 
> > Original patch (dfa4411cc3a690011cab90e9a536938795366cf9) was buggy.
> > This is a more proper fix which introduces blk_rq_quiet() macro
> > alleviating the need for dumb, too short caching variables.
> > 
> > Thanks to Helge Deller and Bart for debugging this.
> > 
> > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> 
> Thanks a lot Borislav !
> As Sergei already mentioned, the patch below is line-wrapped.
> 
> Anyway, I applied it on top of 2.6.30-rc3, fixed up the rejections manually 
> and can confirm that this patch fixes the problems I reported for the parisc 
> platform.
> 
> You may add my signed-off-by when you resend the fixed patch:

Thanks, but I sent a fixed one exactly two minutes :) before your message.

-- 
Regards/Gruss,
    Boris.
