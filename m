From: "Gabor FUNK" <FUNK.Gabor@hunetkft.hu>
Subject: Re: JMicron - hard resetting link
Date: Tue, 12 Feb 2008 15:38:52 +0100
Message-ID: <003801c86d84$fdae0510$4d0fa8c0@M2007>
References: <009401c86d5c$5eb57bf0$4d0fa8c0@M2007> <47B19997.1010404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-2";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.huweb.hu ([62.112.193.37]:59474 "EHLO ns1.huweb.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760157AbYBLOjA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Feb 2008 09:39:00 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

>> I seem to have a bug with JMicron controller in a Gigabyte
>> GA-N680SLI-DQ6 motherboard.
>> http://www.gigabyte.com.tw/Support/Motherboard/BIOS_Model.aspx?ProductID=2460
>>
>> Kernel is 2.6.24.
>> 10 on-board SATA connectors, 2+4*JMicron 20360/20363 + 4*nVidia MCP55
>> 2*200GB disks (System - SW RAID1) on the JMicron controller and
>> 8*500 (Data - SW RAID6) - 4 on the JMicron, 4 on the nVidia controller.
>>
>> Under heavy load the JMicron controller gets exceptions, then eventually
>> "hard resetting link".
>> All 4 disks/connector, one after another. This of course "kills" the RAID
>
> It shouldn't kill the RAID.  Hmmm... The log is truncated.  Can you
> please post full kernel log spanning from boot to array death?

RAID "dies" because controller dies, then it loses 4 disks out of 8...
Actually, the server last time was up and running for 2 months.
Then when it failed the 1st time, I did some tests and it went on for
3 days, including building the raid and heavy test file copy.
The full log from the 1st relevant error message till the death of
the array is here:
http://www.huweb.hu/maques/tmp/jmicron/syslog


> Move half of the drives to the new PSU and see whether the problem goes
> away.

This is a new server, with a Chieftec GPS650AB, 650W PSU in it.
Though AFAIK a harddisk consumes around 10W, and I will try to use
more than one PSU-s.
The main problem is that I can't immediately see if it helps or not.
Even if it will work without this problem for a week, I can't be sure it
still will in 2 months...
Because of this - and because I believe that this problem related to the HW
(motherboard, chipset) - I'd rather just throw away the MB and use an
other one with two extra 4 port SATA cards.

Thanks,
Gabor 

