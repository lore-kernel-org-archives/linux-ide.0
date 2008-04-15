From: Mark Lord <liml@rtr.ca>
Subject: Re: sda
Date: Tue, 15 Apr 2008 09:54:16 -0400
Message-ID: <4804B388.5090509@rtr.ca>
References: <dd18b0c30804021244k1d44a48hc05ea88552104a71@mail.gmail.com>	 <48016F54.5070405@gmail.com> <dd18b0c30804122117hc0cd548v6cbef5d2c0c0ce5e@mail.gmail.com> <48041E2A.9000602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2168 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757071AbYDONyR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Apr 2008 09:54:17 -0400
In-Reply-To: <48041E2A.9000602@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Justin Mattock <justinmattock@gmail.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Justin Mattock wrote:
>>>  Can you please post the result of "lspci -nn".  The error per-se is 
>>> okay.
>>> The drive failed to respond to IDENTIFY at the first try but on 
>>> retrial it
>>> responded okay.
>>
>> Hello; Thank you for the response.
>> I guess you can say I have a tendancy to freak out or panic with
>> little things like that,
>> below is lspci -nn.
> 
> Hmm... ICH7.  I recently had a different bug report on < ICH7 (don't 
> remember whether it was 4, 5 or 6).  In that case, the drive went 
> completely offline after resume.  It never came back after retries.  It 
> seemed like the device needed hardreset after waking up from sleep which 
> we currently only support for >= ICH8).
> 
> Mark, you played with the hardreset bits in PCS (right?) register.  What 
> do you think about adding it?  Last time I played with it, the presence 
> detection seemed unreliable so hotplug might not work too well but as 
> long as the hardreset itself works we can augment it with follow up srst 
> for cases like this.
..

What I did back in 2007 was, implement hot plug/unplug for ICH5,
done by polling the PCS bits.

It works, and is reportedly quite reliable, even though there is still a
tiny theoretical loophole where the chipset could lock up.

The glitch on ICH5, at least, is that the PCS bits work fine for detecting
drive insertions, but not drive removals.  To detect a drive removal,
one has to first toggle the enable line (1..0..1) in PCS, and then wait
for the PHY to try and sync up afterwards (microseconds).

The code didn't go upstream because it conflicted somewhat with the pending
hotplug polling framework you had in development at the time.  :)

What's the scoop with that now, anyways?  The sata_mv driver will eventually
want hotplug polling to deal with port multiplier ports -- it cannot use AN.

Cheers 

