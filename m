From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv & pmp support
Date: Tue, 15 Apr 2008 18:53:15 -0400
Message-ID: <480531DB.3020602@rtr.ca>
References: <47FA4AFF.2010209@gmail.com> <48003C04.4040508@garzik.org> <48023462.1050305@rtr.ca> <4803C429.6070201@rtr.ca> <4803C850.9010901@rtr.ca> <48040DC8.1050907@gmail.com> <48050904.1040808@rtr.ca> <48050CA1.5010800@rtr.ca> <48052E08.5040306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4758 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932AbYDOWxQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Apr 2008 18:53:16 -0400
In-Reply-To: <48052E08.5040306@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
>> Heh.  Okay, apparently it now needs a .pmp_hardreset function,
>> which was never there before.  So I've now added one that does this:
> 
> Ah... right.  That's something changed while changing libata EH to favor 
> hardreset over softreset.  With the change, resuming link on PMP fan out 
> ports became hardreset's responsibility, which BTW is necessary anyway 
> for certain PMPs (marvell ones).  So, one way or another, you need 
> pmp_hardreset.
> 
>>     mv_pmp_select(link->ap, sata_srst_pmp(link));
>>        return sata_std_hardreset(link, class, deadline);
>>
>> And it seems to be working now with that function supplied, at least 
>> for port-0.
>> Anything else new that it should have?  I'll scan through libata-pmp.c 
>> and see.
> 
> The hardreset thing was the only behavior change if I didn't screw up. 
> It wasn't supposed to cause any actual behavior change tho as all PMP 
> supporting PMPs are supposed to have SCR access on fan-out ports and 
> thus the capability to hardreset them.
> 
>> Time to clean out the debug cruft and test a few things a bit more.
> 
> Great. :-)
..

Yeah, I'm happy now.  :)

It seems very rock solid, actually, at least on the one PM I have that works.
The Fed-Ex guy is due tomorrow with a fresh Marvell PM for me,
but I might send some stuff out for #upstream in the interim.

Still gotta reboot/retest with a 60x1 chipset first, though.

 

