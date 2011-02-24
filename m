From: Steven Haigh <netwiz@crc.id.au>
Subject: Re: sata-sil drive detection issues.
Date: Thu, 24 Feb 2011 20:53:15 +1100
Message-ID: <4D662A8B.5050501@crc.id.au>
References: <4D5C92F4.5000906@crc.id.au> <4D5CA2B1.8020905@crc.id.au> <20110217095815.GN19830@htj.dyndns.org> <a9eccac6fe224ef627fc71e819ba30ae@crc.id.au> <20110218091629.GC21209@htj.dyndns.org> <4D65C155.7080902@crc.id.au> <20110224083123.GB7840@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.vm.crc.id.au ([203.56.246.92]:43636 "EHLO
	mail.vm.crc.id.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172Ab1BXJxW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Feb 2011 04:53:22 -0500
In-Reply-To: <20110224083123.GB7840@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On 24/02/2011 7:31 PM, Tejun Heo wrote:
> Well, yeah, IDENTIFY failure is still there.  Controllers behave
> differently and some may have higher tolerance under certain
> circumstances but the setup just seems quite flimsy for whatever
> reason.

Yeah - I noticed that. These things can never be simple, can they?!

>> Could it just be that the cradle is slow to initialise and therefore
>> the sata_sil adapter gives up before the cradle is actually ready?
>>
>> Following this logic, I tried powering up the cradle before
>> connecting the esata cable. I don't see anything in dmesg connecting
>> the esata cable AFTER the cradle has been powered on. Maybe the
>> cradle disables the esata connection if theres no cable connected on
>> powerup?
>
> Is the cradle an active device or is it just power supply +
> eSATA->SATA gender?  Oh, right, you said it also had USB connection,
> so it's an active device.  Can you open it up and see which chip is
> there?

Of course I can crack it open - thats what makes life fun!

The top side of the internal PCB is fairly plain with just the SATA 
power & data sockets on it and the various USB ports and card sockets on 
the front.

On the rear, we have a 30Mhz and a 12Mhz oscillator and 3 main CPU type 
chips.

Near the card readers:
GL826 / MX2AE08G08 / 842H35518 - I assume this is the IDE / CF / card IO 
chip.

Near the rear:
JMB352 / 0834 LGBA1 A / 370JF3011 - This looks to be hooked up via some 
capacitors to the DATA data lines on both sockets. If I haven't 
mentioned before, this is a 2 x SATA drive bay cradle.

A third tiny chip near the JMB352 is:
GL850A / MN2FA01G11 / 911SK03111 - Not 100% sure of the function of this 
chip by following the tracks, but it looks like it might be some kind of 
a clock source. That is a wild guess though!

If you need photos, let me know and I'll make some up.

-- 
Steven Haigh

Email: netwiz@crc.id.au
Web: http://www.crc.id.au
Phone: (03) 9001 6090 - 0412 935 897
Fax: (03) 8338 0299
