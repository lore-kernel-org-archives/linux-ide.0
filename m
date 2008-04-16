From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv & pmp support
Date: Wed, 16 Apr 2008 08:45:26 -0400
Message-ID: <4805F4E6.7020903@rtr.ca>
References: <47FA4AFF.2010209@gmail.com> <48003C04.4040508@garzik.org> <48023462.1050305@rtr.ca> <4803C429.6070201@rtr.ca> <4803C850.9010901@rtr.ca> <48040DC8.1050907@gmail.com> <48050904.1040808@rtr.ca> <48050CA1.5010800@rtr.ca> <48052E08.5040306@gmail.com> <480531DB.3020602@rtr.ca> <48055E7C.1060004@rtr.ca> <48056016.6020900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2271 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756438AbYDPMpa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Apr 2008 08:45:30 -0400
In-Reply-To: <48056016.6020900@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
..
>> I've just noticed that, if I unplug/replug the host-side SATA cable
>> on the Sil3726 PM, and *then* "insmod sata_mv", the PM is not found.
>>
>> If I then simply do "rmmod sata_mv ; insmod sata_mv", then the PM is 
>> found.
>>
>> This happens with the original hardreset code from Jeff,
>> as well as the updated sata_mv code that I've posted earlier.
>> So it is not anything I've broken (recently :) ).
>>
>> Very strange.. I wonder if it also happens with the Marvell PM,
>> except I don't have one here to test with at the moment.
>>
>> Ever heard of anything strange like that?
> 
> IIRC, ICH8 ahci + 4726 fails the initial reset sequence because the PMP 
> comes up after the hardreset code times out, which triggers another EH 
> iteration which works out fine.  If the problem is caused by the PMP not 
> responding fast enough, it should cause a hotplug event afterwards. 
..

So I ought to be able to insert (for debug purposes only) a msleep(3000)
at an appropriate location in the code, and suddenly see this problem go away?

Not for upstream -- the eventual hotplug support in sata_mv is the real solution.
But just to confirm that this is indeed the issue.

Cheers

