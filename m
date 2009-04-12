From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Implementing NVMHCI...
Date: Sat, 11 Apr 2009 20:13:10 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904112006580.4583@localhost.localdomain>
References: <49E0D47B.9070205@garzik.org> <20090411203246.513a0892@lxorguk.ukuu.org.uk> <alpine.LFD.2.00.0904111250370.4583@localhost.localdomain> <da824cf30904111449y5cb7c178ldf5291506ad6b393@mail.gmail.com> <20090412002527.631a5a89@lxorguk.ukuu.org.uk>
 <alpine.DEB.1.10.0904111810360.28893@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56788 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754519AbZDLDT2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Apr 2009 23:19:28 -0400
In-Reply-To: <alpine.DEB.1.10.0904111810360.28893@asgard.lang.hm>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: david@lang.hm
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Grant Grundler <grundler@google.com>, Jeff Garzik <jeff@garzik.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>



On Sat, 11 Apr 2009, david@lang.hm wrote:
> 
> gaining this sort of ability would not be a bad thing.

.. and if my house was built of gold, that wouldn't be a bad thing either.

What's your point?

Are you going to create the magical patches that make that happen? Are you 
going to maintain the added complexity that comes from suddenly having 
multiple dirty bits per "page"? Are you going to create the mythical 
filesystems that magically start doing tail packing in order to not waste 
tons of disk-space with small files, even if they have a 32kB block-size?

In other words, your whole argument is built in "wouldn't it be nice".

And I'm just the grumpy old guy who tells you that there's this small 
thing called REALITY that comes and bites you in the *ss. And I'm sorry, 
but the very nature of "reality" is that it doesn't care one whit whether 
you believe me or not.

The fact is, >4kB sectors just aren't realistic right now, and I don't 
think you have any _clue_ about the pain of trying to make them so. You're 
just throwing pennies down a wishing well.

			Linus
