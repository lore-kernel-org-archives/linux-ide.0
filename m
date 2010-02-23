From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: bad performance with SSD since kernel version 2.6.32
Date: Tue, 23 Feb 2010 07:22:18 +0100
Message-ID: <20100223062218.GH1025@kernel.dk>
References: <20100220142826.62dd5989@pluto-lenny.milky.way> <4B802B54.1080009@gmail.com> <20100221022613.1096fd12@uranus> <51f3faa71002210922i542c37f0j9e0e4a84d0977f90@mail.gmail.com> <20100221225544.5a9ded51@pluto-lenny.milky.way> <51f3faa71002211400u2177660ei1c0dc3d9306b146e@mail.gmail.com> <20100222141802.2bcbf607@pluto-lenny.milky.way> <20100222190522.GD1025@kernel.dk> <20100222212528.13775145@pluto-lenny.milky.way>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 0122700014.0.fullrate.dk ([95.166.99.235]:56111 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab0BWGWT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Feb 2010 01:22:19 -0500
Content-Disposition: inline
In-Reply-To: <20100222212528.13775145@pluto-lenny.milky.way>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Benjamin S." <sbenni@gmx.de>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Mon, Feb 22 2010, Benjamin S. wrote:
> On Mon, 22 Feb 2010 20:05:22 +0100
> Jens Axboe <jens.axboe@oracle.com> wrote:
> 
> > On Mon, Feb 22 2010, Benjamin S. wrote:
> > > 
> > > Without that patch my SSD (Super Talent Ultradrive GX MLC 64GB)
> > > reaches about 200MB/s sequentiell read. After applying the patch it
> > > reaches only 70MB/s.
> > 
> > That's not good. Can you send me the dmesg snippet that includes the
> > drive detection?
> 
> [    0.819456] libata version 3.00 loaded.

[snip]

OK, thanks. I'll revert the commit for 2.6.33.

-- 
Jens Axboe

