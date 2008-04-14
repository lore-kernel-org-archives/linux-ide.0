From: "Gabor FUNK" <FUNK.Gabor@hunetkft.hu>
Subject: Re: sata_sil24 stability and performance
Date: Mon, 14 Apr 2008 12:55:43 +0200
Message-ID: <01ee01c89e1e$4c488e10$4d0fa8c0@M2007>
References: <20080306065513.GE7150@denix.org> <47CF9880.4080900@gmail.com> <20080315214347.GA1511@denix.org> <47DDE0ED.6040304@rtr.ca> <20080318001513.GA2389@denix.org> <47DF4070.3040507@gmail.com> <20080318045316.GA3959@denix.org> <47DF63C1.5090205@gmail.com> <20080320223736.GA19940@denix.org> <47E2FECB.3080602@gmail.com> <20080414011913.GA19751@denix.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.huweb.hu ([62.112.193.37]:49338 "EHLO ns1.huweb.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282AbYDNK5j (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Apr 2008 06:57:39 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denys Dmytriyenko <denis@denix.org>, Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>, Richard Bland <r.bland@espo.org>

Since you brought it up, several days ago I got informed,
that the "original problem" (exception/hard resetting port)
could be related to kernel option IRQBALANCE.
See more at:
http://forums.gentoo.org:80/viewtopic-t-641372-highlight-.html

As Dmytri and me as well both replaced the MB finally which
now runs fine, we will probably not going to "play" again with
this, but if anyone runs into this in the near future, this can be a
thing to try. I can imagine that this could've helped, as in my
case failing was purely limited one controller [*4 disks] at the
time, eg. no other disk on other controller, nor just only one
or some disk on a controller, but all disks on only 1 controller.

And if anyone have any theoretical imagination why it could be
the cause - and where to fix :-] - don't hesitate to write...

Cheers,

G.



----- Original Message ----- 
From: "Denys Dmytriyenko" <denis@denix.org>
To: "Tejun Heo" <htejun@gmail.com>
Cc: "Mark Lord" <liml@rtr.ca>; "Gabor FUNK" <FUNK.Gabor@hunetkft.hu>; 
<linux-ide@vger.kernel.org>; "Jim Paris" <jim@jtan.com>
Sent: Monday, April 14, 2008 3:19 AM
Subject: Re: sata_sil24 stability and performance


> Tejun et al,
>
> I wanted to thank you all for the support you provided. I ended up 
> replacing
> MoBo+CPU to Intel based ones (and previously mentioned single-rail PSU) 
> and
> now everything works rock solid for over a week now! Thanks again.
>
>> > BTW, issuing "smartctl -a" on a drive in standby, throws this 
>> > exception:
>> >
>> > Mar 20 18:16:53 [kernel] ata10.00: exception Emask 0x0 SAct 0x0 SErr 
>> > 0x0 action 0x2 frozen
>> > Mar 20 18:16:53 [kernel] ata10.00: cmd 
>> > b0/da:00:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 0
>> > Mar 20 18:16:53 [kernel]          res 
>> > 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
>> > Mar 20 18:16:53 [kernel] ata10: soft resetting port
>> > Mar 20 18:16:54 [kernel] ata10: SATA link up 3.0 Gbps (SStatus 123 
>> > SControl 300)
>> > Mar 20 18:16:54 [kernel] ata10.00: configured for UDMA/100
>> > Mar 20 18:16:54 [kernel] ata10: EH complete
>> > Mar 20 18:16:54 [kernel] sd 9:0:0:0: [sdj] 976773168 512-byte hardware 
>> > sectors (500108 MB)
>> > Mar 20 18:16:54 [kernel] sd 9:0:0:0: [sdj] Write Protect is off
>> > Mar 20 18:16:54 [kernel] sd 9:0:0:0: [sdj] Mode Sense: 00 3a 00 00
>> > Mar 20 18:16:54 [kernel] sd 9:0:0:0: [sdj] Write cache: enabled, read 
>> > cache: enabled, doesn't support DPO or FUA
>>
>> Which kernel version and how did you put the drive into sleep?
>
> This timeout exception is still there - 2.6.24.4, drive goes to sleep on
> timeout of 30 minutes (hdpram -S 241)
>
> -- 
> Denys
> 

