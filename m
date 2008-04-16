From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_mv & pmp support
Date: Thu, 17 Apr 2008 07:19:43 +0900
Message-ID: <48067B7F.1030702@gmail.com>
References: <47FA4AFF.2010209@gmail.com> <48003C04.4040508@garzik.org> <48023462.1050305@rtr.ca> <4803C429.6070201@rtr.ca> <4803C850.9010901@rtr.ca> <48040DC8.1050907@gmail.com> <48050904.1040808@rtr.ca> <48050CA1.5010800@rtr.ca> <48052E08.5040306@gmail.com> <480531DB.3020602@rtr.ca> <48055E7C.1060004@rtr.ca> <48056016.6020900@gmail.com> <4805F4E6.7020903@rtr.ca> <48061E10.4000604@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:39452 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbYDPWTt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2008 18:19:49 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2581617wff.4
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2008 15:19:49 -0700 (PDT)
In-Reply-To: <48061E10.4000604@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
>> So I ought to be able to insert (for debug purposes only) a msleep(3000)
>> at an appropriate location in the code, and suddenly see this problem 
>> go away?
>>
>> Not for upstream -- the eventual hotplug support in sata_mv is the 
>> real solution.
>> But just to confirm that this is indeed the issue.
> ..
> 
> Heh.. darned near exactly 3 seconds does it, alright.

Heh... 3 secs sounds right.  Yeah, that was the slowest I've ever seen. 
  Maybe we need to extend reset timings.

> Okay, I won't fuss over this for now -- it works if the PM is plugged in
> at boot (because the BIOS fiddles it first), and it works when warmplugged
> so long as sata_mv is unloaded and reloaded.
> 
> This will get fixed completely with the hotplug support fixes coming 
> later this week.

Great.

-- 
tejun
