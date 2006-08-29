From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] HPA resume fix
Date: Tue, 29 Aug 2006 14:32:24 +0200
Message-ID: <20060829123223.GM12257@kernel.dk>
References: <44F40F06.4010408@PicturesInMotion.net> <1156849911.6271.101.camel@localhost.localdomain> <20060829114210.GI12257@kernel.dk> <1156855828.6271.106.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([62.242.22.158]:15936 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751442AbWH2M3k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Aug 2006 08:29:40 -0400
Content-Disposition: inline
In-Reply-To: <1156855828.6271.106.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Trager <Lee@PicturesInMotion.net>, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, bzolnier@gmail.com

On Tue, Aug 29 2006, Alan Cox wrote:
> Ar Maw, 2006-08-29 am 13:42 +0200, ysgrifennodd Jens Axboe:
> > On Tue, Aug 29 2006, Alan Cox wrote:
> > > For -mm only to get more testing
> > > 
> > > Acked-by: Alan Cox <alan@redhat.com>
> > 
> > It should go into the state machine as described imho. Bart?
> 
> If it works then yes it can become an explicit state. Firstly we need to
> find out if it works.

I think Lee tested and verified both this variant and the first one he
had, so I hope that it works :-)

-- 
Jens Axboe

