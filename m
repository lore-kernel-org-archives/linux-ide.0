From: Harald Dunkel <harald.dunkel@t-online.de>
Subject: Re: [PATCH] Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
Date: Fri, 04 May 2007 19:32:47 +0200
Message-ID: <463B6E3F.5000300@t-online.de>
References: <46362672.7080103@gmx.net> <4636EA85.40809@t-online.de> <46371628.9060905@gmail.com> <46379CA1.601@t-online.de> <463AEAF9.3000103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout08.sul.t-online.com ([194.25.134.20]:38180 "EHLO
	mailout08.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031448AbXEDRxE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 May 2007 13:53:04 -0400
In-Reply-To: <463AEAF9.3000103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, Daniel Beichl <daniel_beichl@gmx.net>

Hi folks,

Tejun Heo suggested to post my problem here.

If I enter a movie DVD into my drive (Samsung SH-S183A, SATA)
and run xine dvd:/dev/scd0 immediately (while the drive's LED
is still blinking), then there is some timeout problem.
kern.log says:


May  4 19:10:17 pluto kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
May  4 19:10:17 pluto kernel: ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0xa4 data 8 in
May  4 19:10:17 pluto kernel:          res 40/00:02:00:04:08/00:00:00:00:00/a0 Emask 0x4 (timeout)
May  4 19:10:17 pluto kernel: ata2: soft resetting port
May  4 19:10:24 pluto kernel: ata2: port is slow to respond, please be patient (Status 0xf8)
May  4 19:10:47 pluto kernel: ata2: port failed to respond (30 secs, Status 0xf8)
May  4 19:10:47 pluto kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
May  4 19:10:47 pluto kernel: ATA: abnormal status 0xF8 on port 0xffffc2000001a0c7
May  4 19:10:47 pluto last message repeated 5 times
May  4 19:11:17 pluto kernel: ata2.00: qc timeout (cmd 0xa1)
May  4 19:11:17 pluto kernel: ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
May  4 19:11:17 pluto kernel: ata2.00: revalidation failed (errno=-5)
May  4 19:11:17 pluto kernel: ata2: failed to recover some devices, retrying in 5 secs
May  4 19:11:22 pluto kernel: ata2: hard resetting port
May  4 19:11:23 pluto kernel: CLASSIFY TF 00/01:01:01:14:eb/a0 <6>ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
May  4 19:11:23 pluto kernel: ata2.00: XXX: IDENTIFY
May  4 19:11:23 pluto kernel: 00: 85c0 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: 08: 0000 0000 2020 2020  2020 2020 2020 2020
May  4 19:11:23 pluto kernel: 10: 2020 2020 2020 2020  0000 0000 0000 5342
May  4 19:11:23 pluto kernel: 18: 3032 2020 2020 5453  5354 636f 7270 4344
May  4 19:11:23 pluto kernel: 20: 2f44 5644 5720 5348  2d53 3138 3341 2020
May  4 19:11:23 pluto kernel: 28: 2020 2020 2020 2020  2020 2020 2020 0000
May  4 19:11:23 pluto kernel: 30: 0000 0f00 0000 0200  0200 0006 0000 0000
May  4 19:11:23 pluto kernel: 38: 0000 0000 0000 0000  0000 0000 0000 0007
May  4 19:11:23 pluto kernel: 40: 0003 0078 0078 0078  0078 0000 0000 0000
May  4 19:11:23 pluto kernel: 48: 0000 0000 0000 0000  0602 0000 0068 0040
May  4 19:11:23 pluto kernel: 50: 0000 0000 0000 4000  4000 0000 0000 4000
May  4 19:11:23 pluto kernel: 58: 0407 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: 60: 0000 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: 68: 0000 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: 70: 0000 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: 78: 0000 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: 80: 0000 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: 88: 0000 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: 90: 0000 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: 98: 0000 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: a0: 0000 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: a8: 0000 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: b0: 0000 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: b8: 0000 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: c0: 0000 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: c8: 0000 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: d0: 0000 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: d8: 0000 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: e0: 0000 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: e8: 0000 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: f0: 0000 0000 0000 0000  0000 0000 0000 0000
May  4 19:11:23 pluto kernel: f8: 0000 0000 0000 0000  0000 0000 0000 9ca5
May  4 19:11:23 pluto kernel: ata2.00: configured for UDMA/33
May  4 19:11:23 pluto kernel: ata2: EH complete


Its pretty much reproducible. For the example above the DVD played
at the end, but sometimes the DVD drive dies, and I have to reboot.

If I enter a data DVD and try to mount it without waiting, then I get

% mount /cdrom
mount: /dev/scd0 already mounted or /cdrom busy
% mount /cdrom
%

There is no message in kern.log in this case. On the second try it
succeeds, as shown above.

If I enter a data DVD without running anything, then it takes
about 15 seconds till the LED goes off. Movie DVDs are a little
bit faster: 12 secs. But I am sure this depends.

Any help would be highly appreciated. Please keep me on CC:; I haven't
subscribed this ML.


Regards

Harri
==========================================================================
Tejun Heo wrote:
> Harald Dunkel wrote:
>> Hi Tejun,
>>
>> Tejun Heo wrote:
>>> The timeout is normal.  As the drive is still trying to recognize the
>>> dvd, it doesn't respond to commands in the time specified by xine or
>>> whatever. 
>> I never saw this before with any other drive.
>>
>>> Interestingly, the drive reports illegal device type after
>>> such event.  Can you please apply the attached patch and report the
>>> dmesg after such failure?
>>>
>>>
>> Here it is:
>>
>> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>> ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0xad data
>> 2052 in
>>          res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
>> ata2: soft resetting port
>> CLASSIFY TF 00/01:01:01:14:eb/a0 <6>ata2: SATA link up 1.5 Gbps (SStatus
>> 113 SControl 310)
>> ata2.00: failed to IDENTIFY (device reports illegal type, err_mask=0x0)
>> ata2.00: revalidation failed (errno=-22)
>> ata2.00: disabled
>> ata2: EH complete
> 
> Thanks.
> 
> Can you please apply the attached patch and report this problem to
> linux-ide@vger.kernel.org with the resulting dmesg?   It seems your
> drive reports incorrect IDENTIFY data (maybe due to unflushed FIFO)
> after such timeout event.  I think the timeout itself is probably okay.
>  The drive might just take a tad bit longer than other drives (how long
> do you have to wait?).
> 
> Thanks.
> 
> 

