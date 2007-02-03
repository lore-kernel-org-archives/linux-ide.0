From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: reduce ATA command timeout to 7secs
Date: Sat, 03 Feb 2007 14:50:50 -0500
Message-ID: <45C4E79A.9060602@rtr.ca>
References: <20070202063748.GC1625@htj.dyndns.org>	<45C33BCF.2040506@emc.com>	<45C354CF.1020500@gmail.com>	<20070202153929.33f4a806@localhost.localdomain>	<45C41018.1010509@gmail.com> <20070203195930.4dc956dc@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1202 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbXBCTux (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Feb 2007 14:50:53 -0500
In-Reply-To: <20070203195930.4dc956dc@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Ric Wheeler <ric@emc.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>

Alan wrote:
>> So, I agree with Mark here.  We should retry and fail bio-by-bio.  The
>> end effect wouldn't be much worse than block-by-block while taking much
>> less time.
> 
> And perhaps flip the bio list backwards as well 8) ?

Reversing I/O lists might be the thing to do, but it gets really
complex at the low level.  Drives don't have commands to read
sectors in reverse order.  So to reverse the I/O, each single
command would have to be broken out into possibly thousands
of individual reads..

Not something I'd want to implement, but that's why we have Tejun! ;)
