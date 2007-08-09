From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: SATA open bugs
Date: Thu, 9 Aug 2007 07:44:58 +0200
Message-ID: <20070809054457.GY5245@kernel.dk>
References: <32209efe0708081531o4215bac5teac2113c3518c743@mail.gmail.com> <46BA9101.6080407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:28188 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761014AbXHIFpB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Aug 2007 01:45:01 -0400
Content-Disposition: inline
In-Reply-To: <46BA9101.6080407@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Alan <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, petero2@telia.com

On Thu, Aug 09 2007, Tejun Heo wrote:
> > http://bugzilla.kernel.org/show_bug.cgi?id=7805 tejun is pinging
> > pktcdvd maintainer (?)
> 
> Not a libata bug.  This is caused by pktcdvd holding onto the device
> thus preventing it from being revalidated.  Didn't get pong for my ping
> yet.  Jens, any ideas?
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=7547 tejun is asking " and Jens
> 
> This one is pktcdvd too.  Jens?

Ask Peter, I haven't worked on pktcdvd in ~5 years or so :-). CC'ed.

-- 
Jens Axboe

