From: Justin Fletcher <gerph@gerph.org>
Subject: Re: Problems with >3 drives on an eSATA portmultiplier
Date: Fri, 3 Apr 2009 22:06:21 +0100 (BST)
Message-ID: <Pine.LNX.4.63.0904032140500.3742@buttercup.gerph.org>
References: <Pine.LNX.4.63.0904011454020.3947@buttercup.gerph.org>
 <da824cf30904010945i5a33f049v15745c79293d22ad@mail.gmail.com>
 <Pine.LNX.4.63.0904011801160.3947@buttercup.gerph.org>
 <da824cf30904011046x46da9b69u28f00472a49ebc20@mail.gmail.com>
 <49D406BE.3080103@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56818 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897AbZDCVGY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Apr 2009 17:06:24 -0400
In-Reply-To: <49D406BE.3080103@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Grant Grundler <grundler@google.com>, linux-ide@vger.kernel.org

On Thu, 2 Apr 2009, Tejun Heo wrote:

> Grant Grundler wrote:
>>> I could drop down to 2.6.26 and rebuild my kernel with support for that
>>> controller - I hadn't done this before because I cannot then use my DVB-S
>>> card, but... I could live without that for the test.
>>
>> If someone could comment on  2.6.28 or 2.6.29, you could avoid running
>> this test.
>
> Hmmm... I don't really remember changing much, so it should be fine.
> Can you please give a shot at 2.6.26 anyway?  Also, kernel logs with
> JMB controller would be helpful too as ahci tends to better show what's
> really going on and failing during reset.

I tried the JMB controller again with 2.6.26, and with drives 1,2,3 
connected. This was different to what had happened previously - there are 
two lights on the bridgeboard, green and red. Most of the time they're 
both on. When the JMB controller was connected (even in the BIOS screen) 
these lights flashed on and off about once a second. Occassionally they'd 
settle into the on state. The log of booting into 2.6.26 is here:

http://usenet.gerph.org/SATA/sata-123-2.6.26-jmb-kern.log

and mostly consists of:

Apr  3 20:33:43 buttercup kernel: ata1: exception Emask 0x10 SAct 0x0 SErr 0x4000000 action 0xe frozen
Apr  3 20:33:43 buttercup kernel: ata1: irq_stat 0x00000040, connection status changed
Apr  3 20:33:43 buttercup kernel: ata1: SError: { DevExch }
Apr  3 20:33:43 buttercup kernel: ata1: hard resetting link
Apr  3 20:33:44 buttercup kernel: ata1: SATA link down (SStatus 0 SControl 300)
Apr  3 20:33:44 buttercup kernel: ata1: EH complete

repeated over and over whilst the light was flashing (not in time with 
it).

An interesting (?) thing here is that at 20:34:27 in the log the light 
stayed on for a bit and we managed to read details from the drives. Then 
the light went back to flashing regularly again.

I also booted into 2.6.29 with this configuration (but with drives 3,4,5) 
and got a similar effect, except for the constant light:

http://usenet.gerph.org/SATA/sata-345-2.6.29-jmb-kern.log

I don't think it's particularly surprising that this exhibits the same 
results, given that even during the BIOS the light flashes in the same 
way.

I removed and re-fitted the JMB card as part of these tests, in case it 
was not seated properly in the slot (unlikely, as it was detected, but 
just to be sure, I did this anyhow). I also exchanged the eSATA cables to 
try to eliminate them. No change in behaviour was observed.

Having tried this, I reinserted the SiI card and rebuilt 2.6.26 with 
support for it (and increased the debug buffer). Whilst in the BIOS and 
after booting normally, the bridge board lights are almost constantly on. 
They only seem to go off when the link is reset. Booting with drives 
1,2,3,4 connected (which should be a failure, or only partially detect the 
drives according to the 2.6.29 results) gave me:

http://usenet.gerph.org/SATA/sata-1234-2.6.26-sil-kern.log

which did many resets during the initialisation and never detected any 
drives. Turning the external box off and on again did not cause it to 
re-detect the drives (as if it was just completely ignoring the interface 
now).

Repeating the test with drives 3,4,5 and the 2.6.26 kernel and the sil 
card gave me the following log:

http://usenet.gerph.org/SATA/sata-345-2.6.26-sil-kern.log

This managed to identify 2 of the 3 drives during initialisation. When the 
box was turned off and on again it only detected 2 of the 3.

>>> I've replaced the PSU once already - it was replaced on 6th Feb, with a
>>> Sumvision 450W 20+4pin SATA PSU. Those 5 drives + the bridge board and fan
>>> are the only things being powered by that PSU. I should have thought that
>>> even during drive initialisation 5 drives wouldn't exceed 450W. Anyhow, this
>>> was one of my first thoughts. I could get another PSU (I think I might be
>>> able to find one around here), but having replaced it so recently, I'm
>>> uncomfortable doing so.
>>>
>>> Is a 450W PSU going to be able to supply enough power for those drives ?
>>
>> It's not just about how many watts. Both 12v and 5v "rails" need to
>> provide enough power.  But if this worked before, I would assume the
>> replacement is working too.
>>
>> And in general, yes, a 450W should be plenty for 5 drives plus PMP
>> board. Especially if the OS is "staggering" the spinup so only one
>> or two drives are spinning up at the same time.  I know I've had to
>> fix "staggered spinup" in the past (2.6.18) but don't recall if it's
>> fixed in current 2.6.28 or .29 kernels.
>
> libata never had proper provision for staggered spin up.  If it works,
> it's just because they're being probed sequentially.  :-)
>
> Anyways, 3132 + 3726 should work.  Both 3726 and 4726 pretty much
> require its first port to be always occupied (or it's fake config
> drive jumps arounds and freaks out) and hotplug is often flaky but
> other than that it should generally work.

So my using ports 3,4,5 only probably isn't all that useful for it ?

Even still, I'm not sure that the behaviour that I'm seeing is down to a 
driver issue now. I'd appreciate any other thoughts based on the extra 
info I've given. I may just bite the bullet and try a replacement bridge 
board and see if that helps.

-- 
Gerph <http://gerph.org/>
[ All information, speculation, opinion or data within, or attached to,
   this email is private and confidential. Such content may not be
   disclosed to third parties, or a public forum, without explicit
   permission being granted. ]
