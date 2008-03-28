From: Mark Lord <liml@rtr.ca>
Subject: Re: Need help understanding SATA error message.
Date: Fri, 28 Mar 2008 11:59:14 -0400
Message-ID: <47ED15D2.3080403@rtr.ca>
References: <Pine.LNX.4.61.0803271554050.5510@envy.nxs.se> <47ED136F.9010501@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2916 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752889AbYC1P7Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Mar 2008 11:59:16 -0400
In-Reply-To: <47ED136F.9010501@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomas Lund <tlund@nxs.se>
Cc: linux-ide@vger.kernel.org

Mark Lord wrote:
> Tomas Lund wrote:
>> Hello,
>>
>> I have a SuperMicro X7SBi with ICH9R SATA running 64bit linux 
>> 2.6.24.4. I have 4 1TB disks connected to the motherboard, and one of 
>> the disks is logging an error message. Everything is brand new, and 
>> hooked up just a few weeks ago.
> ..
>> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
>> ata2.00: irq_stat 0x40000001
>> ata2.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
>>          res 51/04:00:0a:24:f9/00:00:00:00:00/a9 Emask 0x1 (device error)
>> ata2.00: status: { DRDY ERR }
>> ata2.00: error: { ABRT }
> ..
>>   Commands leading to the command that caused the error were:
>>   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
>>   -- -- -- -- -- -- -- --  ----------------  --------------------
>>   ea 00 00 00 00 00 00 08      03:56:15.157  FLUSH CACHE EXIT
>>   61 08 00 3f 59 70 74 08      03:56:15.157  [RESERVED FOR SERIAL ATA]
>>   ea 00 00 00 00 00 00 08      03:56:15.157  FLUSH CACHE EXIT
>>   ea 00 00 00 00 00 00 08      03:56:00.377  FLUSH CACHE EXIT
>>   61 08 00 3f 59 70 74 08      03:56:00.377  [RESERVED FOR SERIAL ATA]
> ..
> 
> The SMART log shows that 0xea was a "FLUSH CACHE EXT" (not "EXIT", duh..)
> command, which is what libata issues when it wants to ensure that all
> cached data has been written to the drive.
> 
> This particular drive is reporting that it doesn't understand the command.
..

Duh..  actually, we were just discussing this very error in another thread.
The drive is really telling us that it hit an unrecoverable WRITE error
at sector 0a:24:f9 on the drive.  Bad sector.

There are patches queued up for 2.6.26 to automatically resume the cache
flush after the failed sector, but you'll still lose data at that sector.

Time for a low-level reformat, if the manufacturer has a utility for that.
Otherwise, RMA it.

Cheers
