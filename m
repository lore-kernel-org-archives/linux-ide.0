From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Mon, 20 Oct 2008 08:07:03 +0200
Message-ID: <20081020060703.GA4266@gollum.tnic>
References: <20081018180747.GA29577@gollum.tnic> <20081020112039W.fujita.tomonori@lab.ntt.co.jp>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:33037 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbYJTGHM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Oct 2008 02:07:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1287774fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 19 Oct 2008 23:07:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081020112039W.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: valerio.p@libero.it, linux-ide@vger.kernel.org

On Mon, Oct 20, 2008 at 11:20:49AM +0900, FUJITA Tomonori wrote:
> On Sat, 18 Oct 2008 20:07:47 +0200
> Borislav Petkov <petkovbb@googlemail.com> wrote:
> 
> > would you please take a look at this bug caused by
> > 
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=e5318b531b008c79d2a0c0df06a7b8628da38e2f
> 
> Did he confirm that this patch causes this bug?
> 
> But, yes, this patch might be the cause.
> 
> Using the dma safe check for all the non fs commands is the right
> thing. But blk_queue_update_dma_pad() has side effects. It might be
> the cause (but I'm not sure about it since I don't know how the ide
> code completes requests).

Well, imho and judging from __ide_end_request(), which wraps around
__blk_end_request(), it reenables dma for 3 times (3 being random magic) and
after that remains in pio.

-- 
Regards/Gruss,
    Boris.
