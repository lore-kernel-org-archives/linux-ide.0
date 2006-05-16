From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Date: Tue, 16 May 2006 19:34:41 -0400
Message-ID: <446A6191.8080307@garzik.org>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:63129 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932278AbWEPXes (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2006 19:34:48 -0400
In-Reply-To: <4469EEC0.4060907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Ric Wheeler <ric@emc.com>, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

Tejun Heo wrote:
> * can we make tags int and use -1 for invalid tag?  ATA_TAG_POISON looks 
> horrible when printed.

print with %x :)


> * it would be nice to have some framework to determine whether the 
> controller is receiving too many consecutive spurious interrupts.  Say, 
> 32 irqs in a row without intervening valid interrupts is a good reason 
> to be suspicious about stuck IRQ.  Freezing & resetting will resolve the 
> situation in most cases.

well, there is a screaming interrupt detector in the kernel...  Ideally 
  we should strive to make sure that only happens in debug scenarios :)


> * With NCQ, some drives generate spurious D2H FISes with I bit set as if 
> it were executing non-NCQ commands.  So, regardless of controller, we're 
> likely to see similar problems (but sil24 does all the protocol handling 
> and ignores such FISes by itself).  This can be combined with the above 
> freeze on too many spurious, I guess.

Interesting

	Jeff


