From: Mark Lord <lkml@rtr.ca>
Subject: Re: Linux 2.6.29
Date: Wed, 01 Apr 2009 14:34:33 -0400
Message-ID: <49D3B3B9.1070409@rtr.ca>
References: <20090324093245.GA22483@elte.hu> <20090324101011.6555a0b9@lxorguk.ukuu.org.uk> <20090324103111.GA26691@elte.hu> <20090324132032.GK5814@mit.edu> <alpine.LFD.2.00.0903241053200.3032@localhost.localdomain> <20090324184549.GE32307@mit.edu> <alpine.LFD.2.00.0903241218130.3032@localhost.localdomain> <49C93AB0.6070300@garzik.org> <20090325093913.GJ27476@kernel.dk> <49CA86BD.6060205@garzik.org> <20090325194341.GB27476@kernel.dk> <49D281D8.8030203@garzik.org> <49D2930A.5030905@redhat.com> <49D29797.80200@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:42301 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755202AbZDASeg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Apr 2009 14:34:36 -0400
In-Reply-To: <49D29797.80200@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Ric Wheeler <rwheeler@redhat.com>, Jens Axboe <jens.axboe@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, Theodore Tso <tytso@mit.edu>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Mark Lord <liml@rtr.ca>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Ric Wheeler wrote:
>> Jeff Garzik wrote:
>>> Jens Axboe wrote:
..
>>> IMO we could look at this too, or perhaps come up with an alternate 
>>> proposal like FLUSH CACHE RANGE(s).
> 
>> I agree that it is worth getting better mechanisms in place - the 
>> cache flush is really primitive. Now we just need a victim to sit in 
>> on T13/T10 standards meetings :-)
> 
> 
> Heck, we could even do a prototype implementation with the help of Mark 
> Lord's sata_mv target mode support...
..

Speaking of which.. you probably won't see the preliminary rev
of sata_mv + target_mode until sometime this weekend.

It's going to be something quite simple for 2.6.30,
and we can expand on that in later kernels.

Cheers
