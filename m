From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 00/11] removing the on-stack struct request
Date: Wed, 23 Apr 2008 09:43:18 +0200
Message-ID: <20080423074318.GZ12774@kernel.dk>
References: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp> <58cb370e0804220214va6b7379tfa5b18acf36fd1a7@mail.gmail.com> <20080423074010.GA8221@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:26292 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbYDWHnW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Apr 2008 03:43:22 -0400
Content-Disposition: inline
In-Reply-To: <20080423074010.GA8221@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org

On Wed, Apr 23 2008, Borislav Petkov wrote:
> On Tue, Apr 22, 2008 at 11:14:28AM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> [..]
> 
> > Looks promising but probably I'll not be able to review it properly
> > this week (I'm busy with my real job) and the next week (I'll be busy
> > with pushing overdue IDE updates).  OTOH I'm hoping that Borislav
> > would be able to take a look in the meantime.
> 
> Yep, they're quite straight-forward and look fine except some
> nitpicking i sent in separate mails. FWIW, this is what we wanted to
> do initially but Jens didn't agree to that at the time. I guess, it's
> because i probably didn't express myself clearly enough then. See
> http://kerneltrap.org/mailarchive/linux-kernel/2008/3/1/1037974 for
> the whole discussion.

The cases that do ide_wait can clearly use __GFP_WAIT, and then there
are no issues. My worry was with current paths that allocate the request
on stack from interrupt context, where you cannot block for mempool
allocation. Perhaps such paths don't exist in ide (anymore?), if not
then there are no objections from me.

-- 
Jens Axboe

