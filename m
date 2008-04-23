From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH 00/11] removing the on-stack struct request
Date: Wed, 23 Apr 2008 17:25:15 +0900
Message-ID: <20080423172500J.tomof@acm.org>
References: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<58cb370e0804220214va6b7379tfa5b18acf36fd1a7@mail.gmail.com>
	<20080423074010.GA8221@gollum.tnic>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo11.iij4u.or.jp ([210.138.174.79]:59357 "EHLO mo11.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509AbYDWIZa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Apr 2008 04:25:30 -0400
In-Reply-To: <20080423074010.GA8221@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: bzolnier@gmail.com, fujita.tomonori@lab.ntt.co.jp, linux-ide@vger.kernel.org, jens.axboe@oracle.com

On Wed, 23 Apr 2008 09:40:11 +0200
Borislav Petkov <petkovbb@googlemail.com> wrote:

> On Tue, Apr 22, 2008 at 11:14:28AM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> [..]
> 
> > Looks promising but probably I'll not be able to review it properly
> > this week (I'm busy with my real job) and the next week (I'll be busy
> > with pushing overdue IDE updates).  OTOH I'm hoping that Borislav
> > would be able to take a look in the meantime.
> 
> Yep, they're quite straight-forward and look fine except some nitpicking i sent
> in separate mails.

Thanks for reviewing,

Yeah, these patches are pretty straightforward mainly because they are
against the paths where we can use __GFP_WAIT.


> FWIW, this is what we wanted to do initially but Jens didn't
> agree to that at the time. I guess, it's because i probably didn't express
> myself clearly enough then. See http://kerneltrap.org/mailarchive/linux-kernel/2008/3/1/1037974
> for the whole discussion.

I think that IDE uses request struct from interrupt context at some
places. In such places, I don't think that converting requests on the
stack and a pre-allocated fixed number of requests to
kmalloc/blk_get_request with GFP_ATOMIC is an good idea. It's better
to remove such code (allocating requests from interrupt context).


