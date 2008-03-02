From: "Gabor FUNK" <FUNK.Gabor@hunetkft.hu>
Subject: Re: sata_sil24 stability and performance
Date: Sun, 2 Mar 2008 10:39:29 +0100
Message-ID: <005d01c87c4c$0d01f550$4d0fa8c0@M2007>
References: <20080219020916.GA29902@denix.org> <20080219043659.GA11936@jim.sh> <47BAF677.5000602@rtr.ca> <20080302061453.GA7291@denix.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.huweb.hu ([62.112.193.37]:52609 "EHLO ns1.huweb.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753351AbYCBJ7U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Mar 2008 04:59:20 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denys Dmytriyenko <denis@denix.org>, linux-ide@vger.kernel.org
Cc: Jim Paris <jim@jtan.com>, Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>

I have/had a similar (hard resetting) problem (2+8 disks, kernel 2.6.24), 
see thread:
http://www.mail-archive.com/linux-ide@vger.kernel.org/msg15950.html

I tried replacing the PSU and also run the system with two 650W PSU-s,
also failed. I also think that PSU shouldn't be the problem as I see they
eat much less in operation than at spinup.

Now I replaced the MB and it runs with a different Gigabyte MB with
the 8 disk in SW RAID6 connected to the 2*4 on board SATA
connectors (these now use 2+4*ata_piix and 2 ahci kernel drivers)
and the 2 system disk is on an add-on Silicon Image SiI 3512 card.

Since the problem is not seen immediately I can't tell whether it is
better now. It is running cp 1 2, cp 2 3... to 2500 or so, with 1GB
files then md5sums them, so far the problem not exhibiting. The
1st copy didn't finish in a day, so accidentally a second one got
started (cron) and yesterday an "md: data-check" also started, so
the system is quite busy now doing disk reads/writes...

G.


----- Original Message ----- 
From: "Denys Dmytriyenko" <denis@denix.org>
To: <linux-ide@vger.kernel.org>
Cc: "Jim Paris" <jim@jtan.com>; "Mark Lord" <liml@rtr.ca>
Sent: Sunday, March 02, 2008 7:14 AM
Subject: Re: sata_sil24 stability and performance


> On Tue, Feb 19, 2008 at 10:32:07AM -0500, Mark Lord wrote:
>> Jim Paris wrote:
>>> ..
>>> As you may have noticed on this list, power supplies are very
>>> frequently a problem.
>> ..
>>
>> Actually, no, I haven't noticed that.  :)
>>
>> I do see them more frequently being suggested as a possible problem,
>> and then after some time and expense on the part of the reporters
>> it nearly always turns out to have been a device driver bug,
>> or (less often) a firmware quirk of the device.
>>
>> Yes, PSUs are often suggested as a problem here,
>> but only rarely has that been true.
>>
>> Especially nowadays, as PSUs are becoming much larger than
>> they historically once were.
>
> Hi again. Thanks for your replies and sorry for bringing this up again.
> I am still trying to resolve those 2 issues I mentioned in the first
> email. While playing with different power options lately, I decided to
> replace the PSU again for a single-rail Silencer 750 EPS12V, which is
> rated at 60A (!) for a single 12V rail. Does anybody have any experience
> with it? Can anyone suggest anything better?
>
> That is assuming the first issue with exceptions and resets is due to
> the power being maxed out...
>
> Meanwhile I would still like to resolve the low performance issue with
> SiI 3124, which shows only 17 MB/s write speed doing "dd if=/dev/zero",
> while Intel ICH7 based PC writes at 44 MB/s sustained rate. I'd really
> appreciate any ideas/suggestions towards solving this issue. Please let
> me know if any other information is needed. I'm attaching the original
> email with logs. Thanks in advance!
>
> -- 
> Denys
> 

