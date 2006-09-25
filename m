From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patch] libata fix
Date: Mon, 25 Sep 2006 16:08:45 -0400
Message-ID: <4518374D.9060206@garzik.org>
References: <20060925193511.GA6129@havoc.gtf.org> <1159216257.11049.137.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56015 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750840AbWIYUIu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Sep 2006 16:08:50 -0400
In-Reply-To: <1159216257.11049.137.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Alan Cox wrote:
> Ar Llu, 2006-09-25 am 15:35 -0400, ysgrifennodd Jeff Garzik:
>> [hey Linus, your git summary hint helped, thanks]
>>
>> Please pull from 'upstream-linus' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus
> 
> Btw this one doesn't actually solve the FRV case. That's going to need
> some more work and thinking. Look for patches tomorrow.

It gets FRV to where it was at the point of 2.6.18 release.  Whether it 
worked on FRV at the time of 2.6.18 is quite a different question...

This recent push merely exposed _existing_ arch dependencies.  They 
aren't new by any stretch of the imagination.

As we see, the push has spurred relevant people into taking the correct 
action ;-)

	Jeff



