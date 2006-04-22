From: Mogens Valentin <mogensv@vip.cybercity.dk>
Subject: Re: data corruption with DMA enabled on K7VT4A PRO (VIA KT400A)
Date: Sat, 22 Apr 2006 10:08:10 +0200
Message-ID: <4449E46A.1060207@vip.cybercity.dk>
References: <7285a92f0604122257k2d3578b5re29699c91beeefe8@mail.gmail.com> <7285a92f0604170706l6e8786a2x8eb72ed75910b6ae@mail.gmail.com> <44483F09.3020605@dtbb.net>
Reply-To: mogensv@vip.cybercity.dk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:54429 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750782AbWDVRwb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Apr 2006 13:52:31 -0400
Received: from cicero1.cybercity.dk (cicero1.cybercity.dk [212.242.40.4])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3M87iDQ029065
	for <linux-ide@vger.kernel.org>; Sat, 22 Apr 2006 08:07:45 GMT
In-Reply-To: <44483F09.3020605@dtbb.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tyler <pml@dtbb.net>
Cc: fpn@pobox.com, linux-ide@vger.kernel.org

Tyler wrote:
> Florian Nierhaus wrote:
> 
>> I currently have data corruption when I md5sum large files on both my
>> SATA as well as my PATA drive. When I turn off DMA on the PATA drive
>> it is slow, but no data corruption - I havent figured out to turn off
>> DMA for the SATA.
>>
>>  If it helps, when I diff -u it looks like it is large blocks that are
>> missing/mixed up whatever, but not a bit here or there.
>>
>> This is the second board (but the same model) and still have the same 
>> issue.
>>  The board seems to have a VIA KT400A as well as a VT8237.
>>
> 
> I would suggest swapping your ram out for known tested-good chips, 
> and/or even a different brand/model.  I had similar corruption on an 
> Nforce4 system, transferring large files across the network, and it only 
> stopped once I swapped out the ram (in my case, I removed the 512mb 
> stick, and put a 256mb stick I had laying around).  I'm guessing that 
> NOT using DMA may just be hiding a RAM issue.  There were no other 
> symptoms, no crashes, etc, just screwed up files after transfers.
> 
> You could also try raising the VDIMM voltage to 2.6 or 2.65 if your 
> motherboard supports that option in the bios, it may be enough to make 
> the ram stable.  I had another system that was having random oopses, and 
> raising the VDIMM voltage cured it with two generic Samsung 512mb DDR 
> chips running in dual-channel.

If bad ram is the problem, running a loop building kernel and modules 
usually results in sig11 errors as a good indicator, i.e.
   script make-test
   for i in 1 2 3 4 5; do
       make clean; make -j11 bzImage; make -j1 modules;
   done

Anyways, you're easily right about ram quality. WRT raising voltage, 
most BIOSs use .1volt incrementals, and I've yet to see a ram stick 
having problems vith 2.7volt, so try that.
However, as a first step, ras-to-cas and Trp (cycle time) settings are 
often the problematic ones. Try setting those a bit slower than default.
More than often, the SPD (prom on the stick with timings) has been 
inadequately programmed, so read the ram specs and set them manually.
Sites like arstechnica and tomshardware has some good article/guides to 
ram definitions and timings..

-- 
Kind regards,
Mogens Valentin

