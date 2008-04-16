From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_mv & pmp support
Date: Wed, 16 Apr 2008 11:10:30 +0900
Message-ID: <48056016.6020900@gmail.com>
References: <47FA4AFF.2010209@gmail.com> <48003C04.4040508@garzik.org> <48023462.1050305@rtr.ca> <4803C429.6070201@rtr.ca> <4803C850.9010901@rtr.ca> <48040DC8.1050907@gmail.com> <48050904.1040808@rtr.ca> <48050CA1.5010800@rtr.ca> <48052E08.5040306@gmail.com> <480531DB.3020602@rtr.ca> <48055E7C.1060004@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:36660 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445AbYDPCKg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2008 22:10:36 -0400
Received: by wa-out-1112.google.com with SMTP id m16so3557129waf.23
        for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2008 19:10:35 -0700 (PDT)
In-Reply-To: <48055E7C.1060004@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Mark Lord wrote:
>>
>> Yeah, I'm happy now.  :)
>>
>> It seems very rock solid, actually, at least on the one PM I have that 
>> works.
>> The Fed-Ex guy is due tomorrow with a fresh Marvell PM for me,
>> but I might send some stuff out for #upstream in the interim.
>>
>> Still gotta reboot/retest with a 60x1 chipset first, though.
> ..
> 
> Both command-based and FIS-based switching seem to work just fine.
> But there is a problem, maybe you could help with ?
> 
> I've just noticed that, if I unplug/replug the host-side SATA cable
> on the Sil3726 PM, and *then* "insmod sata_mv", the PM is not found.
> 
> If I then simply do "rmmod sata_mv ; insmod sata_mv", then the PM is found.
> 
> This happens with the original hardreset code from Jeff,
> as well as the updated sata_mv code that I've posted earlier.
> So it is not anything I've broken (recently :) ).
> 
> Very strange.. I wonder if it also happens with the Marvell PM,
> except I don't have one here to test with at the moment.
> 
> Ever heard of anything strange like that?

IIRC, ICH8 ahci + 4726 fails the initial reset sequence because the PMP 
comes up after the hardreset code times out, which triggers another EH 
iteration which works out fine.  If the problem is caused by the PMP not 
responding fast enough, it should cause a hotplug event afterwards. 
Maybe there's a race condition where hotplug events can be lost?

-- 
tejun
