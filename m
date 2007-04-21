From: Mark Lord <liml@rtr.ca>
Subject: Re: Kernel 2.6.18 and above
Date: Sat, 21 Apr 2007 11:28:25 -0400
Message-ID: <462A2D99.9090201@rtr.ca>
References: <4626AEF7.9010804@users.sourceforge.net> <46286D36.5090609@users.sourceforge.net> <1177057830.17978.13.camel@localhost.localdomain> <200704202241.13223.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2280 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1749667AbXDUP21 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 21 Apr 2007 11:28:27 -0400
In-Reply-To: <200704202241.13223.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mike <michael_six@users.sourceforge.net>, B.Zolnierkiewicz@elka.pw.edu.pl, list linux-ide <linux-ide@vger.kernel.org>

Bartlomiej Zolnierkiewicz wrote:
> On Friday 20 April 2007, Benjamin Herrenschmidt wrote:
>> I'm CC'ing linux-ide... looks like the disk which you say is 20GB is
>> misdetected by the IDE layer as being 2GB.
..
>> And here you can see that the partition map tries to use about 20GB...
>> so there is a discrepancy between what the partition map says and what
>> the IDE driver says. I suspect old kernel just ignores the later, while
>> newer kernels enforce the limit which causes your problem.
>>
>> Bart, I'm a bit at lost as to why the device size would be misdetected,
>> do you have an idea ? Might be worth getting a dump of the ID block...
>> Mike, can you send us a dump of the binary file /proc/ide/hdb/identify ?
> 
> Since this is a 2.6.17->2.6.18 regression narrowing the problem down to
> the specific changeset (or at least -git or even -rc) seems like a most
> promising way in discovering the source of the issue.

Oddly enough, the IDENTIFY data that was posted shows this:

        CHS current addressable sectors:    4128768
        LBA    user addressable sectors:   40188960

So, using CHS it appears as a 2GB drive, but using LBA we get a 20GB drive.
Is something mistakenly using CHS instead of LBA ??

-ml
