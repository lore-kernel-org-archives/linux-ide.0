From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: libata FUA revisited
Date: Wed, 21 Feb 2007 08:06:07 -0600
Message-ID: <45DC51CF.7090202@shaw.ca>
References: <fa.S80SRyQbD/hm4SxliPUKU88BaCo@ifi.uio.no>
 <fa.Q/csgyCHkAsD84yi+bN78H1WNNM@ifi.uio.no> <45D104F3.7040602@shaw.ca>
 <45D1D72D.9020509@gmail.com> <45D252CD.5010303@shaw.ca>
 <45D25CF2.5030508@gmail.com> <20070215180023.GA4438@kernel.dk>
 <45D9FE7B.60909@shaw.ca> <45DC04DF.8040002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:20999 "EHLO
	pd2mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161248AbXBUOHJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Feb 2007 09:07:09 -0500
In-reply-to: <45DC04DF.8040002@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, edmudama@gmail.com, Nicolas.Mailhot@LaPoste.net, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <mlord@pobox.com>, Ric Wheeler <ric@emc.com>, Dongjun Shin <d.j.shin@samsung.com>, Hannes Reinecke <hare@suse.de>

Tejun Heo wrote:
>> Aside from the issue above, as I mentioned elsewhere, lots of NCQ drives
>> don't support non-NCQ FUA writes..
> 
> To me, using the NCQ FUA bit on such drives doesn't seem to be a good
> idea.  Maybe I'm just too chicken but it's not like we can gain a lot
> from doing FUA at this point.  Are there a lot of drives which support
> NCQ but not FUA opcodes?

Well, it's hard to say whether "lots" have this issue, but the ones I 
have in my machine, Seagate 7200.7 NCQ 160GB (ST3160827AS) and 7200.10 
320GB (ST3320620AS), both support NCQ and don't support non-NCQ FUA, and 
those (especially the latter) seem to be very popular models.

Likely Seagate didn't implement that command since they figured nobody 
would use that if they had NCQ..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

