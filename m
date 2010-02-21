From: "Benjamin S." <sbenni@gmx.de>
Subject: Re: bad performance with SSD since kernel version 2.6.32
Date: Sun, 21 Feb 2010 02:26:13 +0100
Message-ID: <20100221022613.1096fd12@uranus>
References: <20100220142826.62dd5989@pluto-lenny.milky.way>
	<4B802B54.1080009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:40888 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755730Ab0BUB0a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Feb 2010 20:26:30 -0500
In-Reply-To: <4B802B54.1080009@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


> > Does somebody have an idea what I can test before I have to bisect
> > it?
> 
> Could be some kind of block layer or IO scheduler behavior change.. you 
> could try testing after doing:
> 
> echo noop > /sys/block/sda/queue/scheduler
> 
> or
> 
> echo deadline > /sys/block/sda/queue/scheduler

Thanks for your reply. I have already tested both schedulers. 
Unfortunately it does not make any difference which of them is
used.
