From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: strange hdparm results with serverworks and pata-serverworks
Date: Mon, 23 Feb 2009 23:10:32 +0100
Message-ID: <49A31ED8.1030105@wpkg.org>
References: <49A30901.1@wpkg.org> <87f94c370902231249of8c9dc3p80ae280ef09b0b94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx03.syneticon.net ([78.111.66.105]:51852 "EHLO
	mx03.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbZBWWKS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Feb 2009 17:10:18 -0500
In-Reply-To: <87f94c370902231249of8c9dc3p80ae280ef09b0b94@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: linux-ide@vger.kernel.org

Greg Freemyer schrieb:

>> "hdparm -t" gives me different results for these drives: ~10 MB/s for hda,
>> and ~20 MB/s for hdb with "serverworks" driver on Debian's 2.6.26 kernel.
>> When using "pata-serverworks" with 2.6.28.7 kernel, hdparm shows the same
>> results (~10 MB/s for sda, ~20 MB/s for sdb).
>>
>> However, when I run "dd if=/dev/sda of=/dev/null bs=64k", I can see with
>> iostat that for the first 7-8 seconds, reads are with ~10 MB/s speed. Then,
>> reads from sda are with ~20 MB/s or more and are on par with sdb.
>>
>> Similar dd test for sdb shows that it delivers with speed of ~20 MB/s from
>> the first second.

> Just a guess, but I would bet you have some sector remapping going on
> in the early portion of the 10/MB/sec drive.
> 
> Thus once dd gets based the area that has remapped sectors, it speeds up.
> 
> When reading the slow LBA sectors, the head is actually having to seek
> back and forth from the primary sector area out to the spares area.
> I've seen that before.

There is some logic in this, but:

- smartctl doesn't show any remappings - AFAIK it should?

- there are some more of these HP ProLiant BL30p G1 blades here - some 
show this behaviour, some don't (i.e., both drives are as fast from the 
very beginning). Always the first drive shows this behaviour.

Could be an issue with these WDC WD2500BEVE-00WZT0 drives when they are 
connected as master? Why the issue doesn't show up on all such blades?

> FYI: I saw a drive last week that had over 10% of the first 200
> sectors bad.  After that all was good.  The drive I was looking at was
> several years old and remapping had not been triggered, so it was
> obvious what was going on when I ran dd to try and read the entire
> drive.


-- 
Tomasz Chmielewski
http://wpkg.org

