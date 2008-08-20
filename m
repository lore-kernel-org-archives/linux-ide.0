From: Tejun Heo <tj@kernel.org>
Subject: Re: [opensuse] Seeking advice: 4TB external drive
Date: Wed, 20 Aug 2008 17:08:08 +0900
Message-ID: <48ABD0E8.2010104@kernel.org>
References: <48A39DF3.2030105@rhyme.com.au>	 <87f94c370808140605w6d7af3c4nc75de67377cfc3ae@mail.gmail.com>	 <48A44995.2010908@rhyme.com.au>	 <48A45957.6060300@japantest.homelinux.com>	 <48A4F3CB.5060204@rhyme.com.au> <87f94c370808150546rfd6468er8503176bef0cf9b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59804 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbYHTIIs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Aug 2008 04:08:48 -0400
In-Reply-To: <87f94c370808150546rfd6468er8503176bef0cf9b7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, opensuse@opensuse.org

Greg Freemyer wrote:
> On Thu, Aug 14, 2008 at 11:11 PM, Philip Warner <pjw@rhyme.com.au> wrote:
>> Sandy Drobic wrote:
>>> If you really intend to use an external drive larger than 1 TB you
>>> should definitely plan to use at least gigabit ethernet or eSATA.
>>> Anything else doesn't make much sense with storage of that size.
>> Yeah; that was the original plan until I failed to find an eSATA card
>> that would cope with a 4TB external disk. The last one I bought was
>> supposed to be 48bit LBA throughout, but the disk still shows up as the
>> wrong size in the cards internal bios (1.8TB). Using USB frightens me
>> considerably since I have (historically) had a great deal of trouble
>> getting large external USB drived to function reliably under linux. And,
>> as you say, they are slooow.
>>
>> If I go eSATA, it omes back to the hardware question: anyone know of a
>> hardware/software combo that thy know can cope with a single 4TB eSATA
>> drive?
>>
>> Also, maybe this is no longer a SuSE uestion.
> 
> Agreed, not a suse question.  If you are now thinking eSata, you
> should ask on the linux kernel sata list.

If you're not gonna boot off the drive, what the BIOS thinks is
irrelevant although I wonder whether the 1.8TB limit comes from.  1.8TB
doesn't really fall on 2^n boundary.  Although for some reason the BIOS
used 32bit number to address LBAs it will only be able to address upto
2TiB which is sort of kind of in the vicinity of the ballpark if you
stretch it just right. :-P

Anyways, once the system is up and running, I think it should be just
fine.  There definitely isn't a limit in the software stack and most
modern controllers should be fine with it too.  There just isn't much
reason to choke on that boundary.  The BIOS might enable HPA to limit
the drive size to something it can handle but libata.ignore_hpa=1 will
make libata unlock it (which is the default on certain distros including
SUSE).

-- 
tejun
