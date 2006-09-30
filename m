From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] libata: turn off NCQ if queue depth is adjusted to
	1
Date: Sat, 30 Sep 2006 21:51:00 +0100
Message-ID: <1159649460.13029.145.camel@localhost.localdomain>
References: <20060930104439.GP25800@htj.dyndns.org>
	 <20060930104500.GQ25800@htj.dyndns.org>  <20060930180359.GP4163@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29848 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751922AbWI3U1A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Sep 2006 16:27:00 -0400
In-Reply-To: <20060930180359.GP4163@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, ric@emc.com

Ar Sad, 2006-09-30 am 20:04 +0200, ysgrifennodd Jens Axboe:
> On Sat, Sep 30 2006, Tejun Heo wrote:
> > Turn off NCQ if queue depth is adjusted to 1.
> 
> I had thought of that too but discarded it - it would be nicer to have
> an independent way of turning off NCQ. Say you are debugging a weird FIS
> issue, NCQ depth 1 is still a different beast to non-NCQ. I see Jeff
> already applied the patches, but just thought I'd voice my opinion.

I've got a blacklist for NCQ in my work tree but really we need the
vendors to help fill it. So far it has some raptors in it but I am sure
there are more, and I am sure there are cases we should be advising
newer firmware or just tweaking our queue sizes etc.

Alan
