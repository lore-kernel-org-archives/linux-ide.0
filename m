From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv & pmp support
Date: Tue, 15 Apr 2008 22:03:40 -0400
Message-ID: <48055E7C.1060004@rtr.ca>
References: <47FA4AFF.2010209@gmail.com> <48003C04.4040508@garzik.org> <48023462.1050305@rtr.ca> <4803C429.6070201@rtr.ca> <4803C850.9010901@rtr.ca> <48040DC8.1050907@gmail.com> <48050904.1040808@rtr.ca> <48050CA1.5010800@rtr.ca> <48052E08.5040306@gmail.com> <480531DB.3020602@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4324 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752951AbYDPCDl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Apr 2008 22:03:41 -0400
In-Reply-To: <480531DB.3020602@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
>
> Yeah, I'm happy now.  :)
> 
> It seems very rock solid, actually, at least on the one PM I have that works.
> The Fed-Ex guy is due tomorrow with a fresh Marvell PM for me,
> but I might send some stuff out for #upstream in the interim.
> 
> Still gotta reboot/retest with a 60x1 chipset first, though.
..

Both command-based and FIS-based switching seem to work just fine.
But there is a problem, maybe you could help with ?

I've just noticed that, if I unplug/replug the host-side SATA cable
on the Sil3726 PM, and *then* "insmod sata_mv", the PM is not found.

If I then simply do "rmmod sata_mv ; insmod sata_mv", then the PM is found.

This happens with the original hardreset code from Jeff,
as well as the updated sata_mv code that I've posted earlier.
So it is not anything I've broken (recently :) ).

Very strange.. I wonder if it also happens with the Marvell PM,
except I don't have one here to test with at the moment.

Ever heard of anything strange like that?

??
