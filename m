From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] HPA resume fix
Date: Tue, 29 Aug 2006 13:50:27 +0100
Message-ID: <1156855828.6271.106.camel@localhost.localdomain>
References: <44F40F06.4010408@PicturesInMotion.net>
	 <1156849911.6271.101.camel@localhost.localdomain>
	 <20060829114210.GI12257@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32477 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751440AbWH2M24 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Aug 2006 08:28:56 -0400
In-Reply-To: <20060829114210.GI12257@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Lee Trager <Lee@PicturesInMotion.net>, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, bzolnier@gmail.com

Ar Maw, 2006-08-29 am 13:42 +0200, ysgrifennodd Jens Axboe:
> On Tue, Aug 29 2006, Alan Cox wrote:
> > For -mm only to get more testing
> > 
> > Acked-by: Alan Cox <alan@redhat.com>
> 
> It should go into the state machine as described imho. Bart?

If it works then yes it can become an explicit state. Firstly we need to
find out if it works.

