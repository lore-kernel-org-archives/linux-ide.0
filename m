From: Tejun Heo <htejun@gmail.com>
Subject: Re: JMicron - hard resetting link
Date: Tue, 12 Feb 2008 23:52:09 +0900
Message-ID: <47B1B299.3010208@gmail.com>
References: <009401c86d5c$5eb57bf0$4d0fa8c0@M2007> <47B19997.1010404@gmail.com> <003801c86d84$fdae0510$4d0fa8c0@M2007>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.176]:42481 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754615AbYBLOwR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 09:52:17 -0500
Received: by el-out-1112.google.com with SMTP id v27so1985247ele.23
        for <linux-ide@vger.kernel.org>; Tue, 12 Feb 2008 06:52:16 -0800 (PST)
In-Reply-To: <003801c86d84$fdae0510$4d0fa8c0@M2007>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gabor FUNK <FUNK.Gabor@hunetkft.hu>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Gabor FUNK wrote:
>> It shouldn't kill the RAID.  Hmmm... The log is truncated.  Can you
>> please post full kernel log spanning from boot to array death?
> 
> RAID "dies" because controller dies, then it loses 4 disks out of 8...
> Actually, the server last time was up and running for 2 months.
> Then when it failed the 1st time, I did some tests and it went on for
> 3 days, including building the raid and heavy test file copy.
> The full log from the 1st relevant error message till the death of
> the array is here:
> http://www.huweb.hu/maques/tmp/jmicron/syslog

What I said was that timeouts occurring due to transmission errors
should be recoverable.  It seems like IRQ delivery didn't work probably
due to screaming IRQ.  I need to see the messages before the first
relevant error message.  It's always a good idea to post full kernel log
from boot till failure.  Things which don't seem relevant are often
relevant.

>> Move half of the drives to the new PSU and see whether the problem goes
>> away.
> 
> This is a new server, with a Chieftec GPS650AB, 650W PSU in it.
> Though AFAIK a harddisk consumes around 10W, and I will try to use
> more than one PSU-s.

I've recently tracked down IO problems a server product line from a
major (really, one of the top three) vendor to malfunctioning PSU, so
don't trust the labeling too much.

> The main problem is that I can't immediately see if it helps or not.
> Even if it will work without this problem for a week, I can't be sure it
> still will in 2 months...
> Because of this - and because I believe that this problem related to the HW
> (motherboard, chipset) - I'd rather just throw away the MB and use an
> other one with two extra 4 port SATA cards.

Till now, none of this kind of problem has been tracked down to MB or
the controller while 90% of hardware problems turned out to be power
related.

Thanks.

-- 
tejun
