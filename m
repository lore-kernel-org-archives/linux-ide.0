From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] HPA resume fix
Date: Tue, 29 Aug 2006 13:42:10 +0200
Message-ID: <20060829114210.GI12257@kernel.dk>
References: <44F40F06.4010408@PicturesInMotion.net> <1156849911.6271.101.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([62.242.22.158]:53869 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S964946AbWH2Lj1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Aug 2006 07:39:27 -0400
Content-Disposition: inline
In-Reply-To: <1156849911.6271.101.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Trager <Lee@PicturesInMotion.net>, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, bzolnier@gmail.com

On Tue, Aug 29 2006, Alan Cox wrote:
> Ar Maw, 2006-08-29 am 05:55 -0400, ysgrifennodd Lee Trager:
> > This patch fixes a problem with computers that have HPA on their hard
> > drive and not being able to come out of resume from RAM or disk. This is
> > my first patch to the kernel and third time submitting it, hopefully I
> > got it right this time.
> > 
> > Signed-off-by: Lee Trager <Lee@PicturesInMotion.net>
> 
> For -mm only to get more testing
> 
> Acked-by: Alan Cox <alan@redhat.com>

It should go into the state machine as described imho. Bart?

-- 
Jens Axboe

