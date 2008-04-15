From: Tejun Heo <htejun@gmail.com>
Subject: Re: sda
Date: Wed, 16 Apr 2008 08:36:20 +0900
Message-ID: <48053BF4.8060809@gmail.com>
References: <dd18b0c30804021244k1d44a48hc05ea88552104a71@mail.gmail.com>	 <48016F54.5070405@gmail.com> <dd18b0c30804122117hc0cd548v6cbef5d2c0c0ce5e@mail.gmail.com> <48041E2A.9000602@gmail.com> <4804B388.5090509@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.247]:32503 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761569AbYDOXg0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2008 19:36:26 -0400
Received: by rv-out-0506.google.com with SMTP id k29so994494rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2008 16:36:25 -0700 (PDT)
In-Reply-To: <4804B388.5090509@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Justin Mattock <justinmattock@gmail.com>, linux-ide@vger.kernel.org

Hello,

Mark Lord wrote:
> What I did back in 2007 was, implement hot plug/unplug for ICH5,
> done by polling the PCS bits.
> 
> It works, and is reportedly quite reliable, even though there is still a
> tiny theoretical loophole where the chipset could lock up.
> 
> The glitch on ICH5, at least, is that the PCS bits work fine for detecting
> drive insertions, but not drive removals.  To detect a drive removal,
> one has to first toggle the enable line (1..0..1) in PCS, and then wait
> for the PHY to try and sync up afterwards (microseconds).

Having hardreset around is helpful whether hotplugging works or not. 
Can you please tell me more about the theoretical loophole?

> The code didn't go upstream because it conflicted somewhat with the pending
> hotplug polling framework you had in development at the time.  :)
> 
> What's the scoop with that now, anyways?  The sata_mv driver will 
> eventually
> want hotplug polling to deal with port multiplier ports -- it cannot use 
> AN.

Heh... That was blocked on sysfs nodes and as time goes by it went down 
through the rabbit hole.  MV can't do AN?  Have you taken a look at how 
ahci implements AN?  It doesn't really support AN.  It just looks at 
what FIS it received and tries to emulate the notification, which BTW 
isn't 100% accurate as the receive area can be overwritten 
asynchronously but it works good enough.  Maybe MV can do similar?

-- 
tejun
