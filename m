From: "Gabor FUNK" <FUNK.Gabor@hunetkft.hu>
Subject: Re: JMicron - hard resetting link
Date: Fri, 15 Feb 2008 00:02:32 +0100
Message-ID: <005c01c86f5d$b050b4e0$4d0fa8c0@M2007>
References: <009401c86d5c$5eb57bf0$4d0fa8c0@M2007> <47B19997.1010404@gmail.com> <003801c86d84$fdae0510$4d0fa8c0@M2007> <47B1B299.3010208@gmail.com> <002f01c86d9c$94542f50$4d0fa8c0@M2007> <47B230CA.9060506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-2";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.huweb.hu ([62.112.193.37]:55603 "EHLO ns1.huweb.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754813AbYBNXCp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Feb 2008 18:02:45 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

To be honest, I didn't believe that doing anything with the PSU
would do something.
However, seemingly it did.
I have also updated the BIOS, but I guess this has not much
to do with it.
So a different brand PSU was additionally installed, and this
one got the motherboard and the 4 disk which were failing.
The "old" PSU got the second 4 hdds and the 2 other system
HDDs.
Test was started yesterday (Feb 13) about 16:30 CET including
array building up and file copies. About today (14) 20:22 the
problem appeared, but seemingly "moved" with the PSU to the
other 4 disks bunch (on nvidia controller) - more precisely, only
2 of them (array is still operational).

Feb 14 20:22:32 storage1 kernel: ata10.00: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x2 frozen
Feb 14 20:22:32 storage1 kernel: ata10.00: cmd 
c8/00:00:c3:d5:3b/00:00:00:00:00/e2 tag 0 dma 131072 in
Feb 14 20:22:32 storage1 kernel:          res 
40/00:01:09:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Feb 14 20:22:32 storage1 kernel: ata10.00: status: { DRDY }
Feb 14 20:22:32 storage1 kernel: ata9.00: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x2 frozen
Feb 14 20:22:32 storage1 kernel: ata9.00: cmd 
c8/00:00:c3:d5:3b/00:00:00:00:00/e2 tag 0 dma 131072 in
Feb 14 20:22:32 storage1 kernel:          res 
40/00:01:09:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Feb 14 20:22:32 storage1 kernel: ata9.00: status: { DRDY }
Feb 14 20:22:33 storage1 kernel: ata10: soft resetting link
Feb 14 20:22:33 storage1 kernel: ata9: soft resetting link
Feb 14 20:22:33 storage1 kernel: ata10: SATA link up 3.0 Gbps (SStatus 123 
SControl 300)
Feb 14 20:22:33 storage1 kernel: ata9: SATA link up 3.0 Gbps (SStatus 123 
SControl 300)
Feb 14 20:23:03 storage1 kernel: ata9.00: qc timeout (cmd 0x27)
Feb 14 20:23:03 storage1 kernel: ata9.00: failed to read native max address 
(err_mask=0x4)
Feb 14 20:23:03 storage1 kernel: ata9.00: HPA support seems broken, will 
skip HPA handling
Feb 14 20:23:03 storage1 kernel: ata9.00: revalidation failed (errno=-5)
Feb 14 20:23:03 storage1 kernel: ata9: failed to recover some devices, 
retrying in 5 secs
Feb 14 20:23:03 storage1 kernel: ata10.00: qc timeout (cmd 0x27)
Feb 14 20:23:03 storage1 kernel: ata10.00: failed to read native max address 
(err_mask=0x4)
Feb 14 20:23:03 storage1 kernel: ata10.00: HPA support seems broken, will 
skip HPA handling
Feb 14 20:23:03 storage1 kernel: ata10.00: revalidation failed (errno=-5)
Feb 14 20:23:03 storage1 kernel: ata10: failed to recover some devices, 
retrying in 5 secs
Feb 14 20:23:08 storage1 kernel: ata9: hard resetting link
Feb 14 20:23:08 storage1 kernel: ata10: hard resetting link
...

Full kern.log is at:
http://www.huweb.hu/maques/tmp/jmicron/kern0214.log

So it seems that there is definitely something with the "old" PSU.

Also, I tried to mount the failed drives, without success.

Thought I let you know.
Now I will try with the only one, "new" PSU to see what happens...

G.


----- Original Message ----- 
From: "Tejun Heo" <htejun@gmail.com>
To: "Gabor FUNK" <FUNK.Gabor@hunetkft.hu>
Cc: "IDE/ATA development list" <linux-ide@vger.kernel.org>
Sent: Wednesday, February 13, 2008 12:50 AM
Subject: Re: JMicron - hard resetting link


> Hello,
>
> Gabor FUNK wrote:
>>> What I said was that timeouts occurring due to transmission errors
>>> should be recoverable.  It seems like IRQ delivery didn't work probably
>>> due to screaming IRQ.  I need to see the messages before the first
>>> relevant error message.  It's always a good idea to post full kernel log
>>> from boot till failure.  Things which don't seem relevant are often
>>> relevant.
>> Naturally. Full kern.log with boot:
>> http://www.huweb.hu/maques/tmp/jmicron/kern.log
>> (no edits, there are really only those 2 lines between Feb 6 and Feb 9's
>> 1st exception)
>
> Hmmm... Indeed.  This is the first time this mode of failure is reported.
>
>> Previously there was kernel 2.6.23.9 and I noticed the following in
>> syslog by then:
>> Feb  6 19:10:19 storage1 kernel: ata4: D2H reg with I during NCQ, this
>> message won't be printed again
>> Feb  6 19:10:20 storage1 kernel: ata1: D2H reg with I during NCQ, this
>> message won't be printed again
>> Feb  6 19:10:20 storage1 kernel: ata2: D2H reg with I during NCQ, this
>> message won't be printed again
>> Feb  6 19:10:21 storage1 kernel: ata3: D2H reg with I during NCQ, this
>> message won't be printed again
>>
>> I googled and saw that there was some fixes related to this (maybe it
>> was you), so that's why we hoped that 2.6.24 will fix this. Actually the
>> above error messages were gone, but...
>
> Yeap, those are gone.
>
>>> Till now, none of this kind of problem has been tracked down to MB or
>>> the controller while 90% of hardware problems turned out to be power
>>> related.
>> I'll put a brand new, probably different PSU in the case and put the MB
>> and the 4 disks of the problematic controller on it, and put the 2 system
>> and other 4 disks to this one (or even another one).
>
> Yeap, please keep me posted.
>
>> Meanwhile I'd welcome if you have any suggestion why controller reset
>> causing a "fatal error"...
>> BTW, the drives were accessible after the array broke (when I got there).
>
> What do you mean by 'drives were accessible'?  /dev/sdX nodes were
> accessible?
>
> -- 
> tejun
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

