From: Brad Campbell <brad@wasp.net.au>
Subject: Re: libata oops 2.6.11-rc4 yesterdays BK
Date: Sat, 19 Feb 2005 08:14:08 +0400
Message-ID: <4216BD10.2070008@wasp.net.au>
References: <4212CBD6.7020703@wasp.net.au> <42132803.2080701@wasp.net.au> <4213821D.1030203@pobox.com> <4213B2F8.2070800@wasp.net.au> <20050216154033.I10699@florence.linkmargin.com> <42158774.9030406@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from wasp.net.au ([203.190.192.17]:50151 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S261629AbVBSEON (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2005 23:14:13 -0500
In-Reply-To: <42158774.9030406@wasp.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: Andy Warner <andyw@pobox.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Brad Campbell wrote:
> Andy Warner wrote:
> 
>> Brad Campbell wrote:
>>
>>> [...]
>>> Actually, I'm not sure without the libata dev patch as that removes 
>>> SMART support, and I'm not convinced that my smartd polling every 20 
>>> minutes does not have something to do with it. All I know is the 
>>> older kernel seems to cope. We'll see. 320 minutes left on this 
>>> rebuild. I expect it will be done in the morning if all goes 
>>> according to plan. (With the 2.6.11 kernel it never survived past 
>>> about 25% rebuilt)
>>
>>
>>
>> Can you find time to try it without smartd active ?
>> You report running a uni-processor system, and I have only
>> seen PIO problems with (fast) SMP systems in my testing,
>> but I am forming the opinion that libata-PIO functions
>> are in need of a minor overhaul.

Have been unable to hit the bug with SMART disabled (Kernel unchanged). So...... Pass through (or 
SMART in particular) is not really safe on UP either, you just have to work really hard at it to hit 
the corner cases.

I can now reproduce it quite reliably with a nasty while ; do loop in bash if anyone has anything 
that want's testing.

I'm planning on burning in this box for a while before I put it into production, so I'm not adverse 
to blowing it up a little in the mean time.

Regards,
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
