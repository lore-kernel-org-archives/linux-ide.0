From: Mark Lord <lkml@rtr.ca>
Subject: Re: 2.6.20 libata cdrom
Date: Tue, 01 May 2007 09:41:45 -0400
Message-ID: <46374399.8030602@rtr.ca>
References: <20070427175205.GD7809@electro-mechanical.com> <4635C35D.1020807@gmail.com> <20070430202107.GF5942@electro-mechanical.com> <4636C2C7.8090206@gmail.com> <46373873.6060704@rtr.ca> <463738BD.2090308@rtr.ca> <46374161.3020801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4399 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423449AbXEANlt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 May 2007 09:41:49 -0400
In-Reply-To: <46374161.3020801@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, William Thompson <wt@electro-mechanical.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com

Tejun Heo wrote:
> Mark Lord wrote:
>> And this is the second one today where it would be very useful
>> to see a tf dump.  It's time to add one to that code patch, methinks.
> 
> Yeah, we have all these fancy ata_msg_() thingies which can be used to
> provide a lot of debugging info without affecting hot path.  We're just
> too lazy to actually use it. :-( Putting it on my ever growing to-do list.

The thing about failures is, we're lucky enough to ever see even a single
end-user error log.  So when we do get the *one* error log from grandma,
it had better contain sufficient info for us to at least guess at the
solution, because grandma has gone back to OS/X in the meanwhile.  ;)

It's a good thing that failure paths are not normally "hot".
We can load those up with a little extra info, so long as they
cannot normally be trigged from userspace to generate a Denial-Of-Service
style of attack.

I think libata drive probing is a pretty safe area to show lots
of information (by default) when something goes wrong.

Cheers!
