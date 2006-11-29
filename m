From: Tejun Heo <htejun@gmail.com>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Wed, 29 Nov 2006 10:12:25 +0900
Message-ID: <456CDE79.10709@gmail.com>
References: <20061114150454.GA11900@havoc.gtf.org> <Pine.LNX.4.64.0611280908320.4244@woody.osdl.org> <456C73D8.3050803@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:32286 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1758557AbWK2BMf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Nov 2006 20:12:35 -0500
Received: by nz-out-0102.google.com with SMTP id s1so994391nze
        for <linux-ide@vger.kernel.org>; Tue, 28 Nov 2006 17:12:35 -0800 (PST)
In-Reply-To: <456C73D8.3050803@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Linus Torvalds wrote:
>> [ You may or may not have gotten my previous email. The kernel stayed 
>>   working, but due to the IO errors the filesystem got re-mounted   
>> read-only, and I'm not sure that the email I sent out in that state   
>> actually ever made it out. I suspect it didn't. ]
>>
>> Jeff,
>>  I just had a scary thing on my nice new Intel i965 box (all Intel 
>> chipsets apart from some strange Marvell IDE interface that I'm not 
>> using and that no driver even detected, and a TI firewire thing that 
>> I'm similarly not using).
>>
>> The machine basically froze for about a minute or so (well, things 
>> worked surprisingly well, considering that apparently no disk IO 
>> happened - I initially thought it was just firefox that had frozen up, 
>> since my mail session seemed to be fine), and after it came back the 
>> filesystem was mounted read-only and nothing really worked any more..
>>
>> I have no idea what status 0xD0 means: it looks like ATA_BUSY + 
>> ATA_DRDY + "bit#4", but what is bit#4?
> 
> Bit #4, when actually implemented, is a rotational seek indicator,
> which can be used for timing purposes.
> 
> But when BUSY (bit #7) is set, the rest are generally nonsense.
> 
>> And clearly, the soft-reset isn't doing squat.

I dunno.  My first suspect is transient transmission error and yeah they 
do occur from time to time even on otherwise stable setup.  For example, 
my machine is nvidia ck804 which has pretty weak error handling (at 
least used to) and stays up 24/7 and I've seen such unrecovered 
transmission error just once during last 6+ months.

My experience is that if something is weird (say, power fluctuation or 
electro-magnetic interference), SATA is the first thing to give out and 
that's why we need good EH w/ SATA much more than we do with PATA.

Drives (controllers too) sometimes fall into weird state after such 
errors and softreset is often not enough, so we need hardreset.  ICH8 
can do hardreset even in ata_piix mode.  I'll work on it.

Linus, I'll follow up with Jonas as his problem seems reproducible but 
I'm a bit skeptical about it being a driver issue.  Even w/ all its 
kinks, ata_piix is just a sff IDE controller and libata has been doing 
it for a long time.  I would be really surprised if the driver or 
controller has any such issue in the usual r/w path.  AHCI should be 
able to recover from most error conditions unless drive firmware is 
completely stuck requiring physical power off.

-- 
tejun
