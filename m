From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Linux v2.6.22-rc3
Date: Fri, 01 Jun 2007 13:35:52 -0400
Message-ID: <466058F8.4050107@pobox.com>
References: <alpine.LFD.0.98.0705252008210.26602@woody.linux-foundation.org> <9d2cd630705270801m2826be60p3f802c502b26c531@mail.gmail.com>  <46599E6B.1000209@pobox.com>  <9d2cd630705270907y4722653cpf79f073fa8f12f08@mail.gmail.com> <alpine.LFD.0.98.0705270922030.26602@woody.linux-foundation.org>  <9d2cd630705271315x7030c91ew2f175c921c022880@mail.gmail.com>  <465AA536.6080608@gmail.com> <9d2cd630705280707h4921900fxc93a07a87f0bdf66@mail.gmail.com> <465BF244.5080200@gmail.com> <alpine.LFD.0.98.0705290924350.26602@woody.linux-foundation.org> <465F6F48.8080804@gmail.com> <alpine.LFD.0.98.0705311830360.26602@woody.linux-foundation.org> <465F8230.2040105@gmail.com> <46604E62.1000105@pobox.com> <alpine.LFD.0.98.0706010955390.3957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53943 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759939AbXFARgA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Jun 2007 13:36:00 -0400
In-Reply-To: <alpine.LFD.0.98.0706010955390.3957@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <htejun@gmail.com>, Gregor Jasny <gjasny@googlemail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Linus Torvalds wrote:
> 
> On Fri, 1 Jun 2007, Jeff Garzik wrote:
>> I'm about to dive into some heads-down RHEL backporting (whee), so I cannot
>> look at the code in depth this weekend, but here are my basic thoughts:
>>
>> * We knew there would be fallout from the new reset-sequence code, and this is
>> clearly in that category.
>>
>> * It worked before #reset-seq merge AFAICT, which implies the old method of
>> probing -- which included SRST -- worked.
> 
> Well, I don't think it really "worked" before. It apparently always had a 
> bad 30-second timeout (probably because the reset just didn't work at 
> all). It's just that the old code didn't care, and since the identify then 
> worked, it was all good.

<reviews thread again>  Ah, indeed.  I certainly prefer the old result 
to the new one.

With these old PATA devices, device reset is "six of one, half-dozen of 
the other."  Using SRST is the only way to kick some ATAPI devices into 
working: http://suif.stanford.edu/~csapuntz/blackmagic.html#reset

I'm mainly interested in hearing feedback from Fedora 7 damage, before 
making a major decision about the probing code.  If this is a single 
dain bramaged device, we should avoid punishing the majority.  But if 
this is a trend, it warrants careful reconsideration.

The current code already has the IDENTIFY retry stuff, so it sounds like 
restoring the "don't care" part should be enough to restore the older 
behavior.

	Jeff


