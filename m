From: Mark Lord <kernel@teksavvy.com>
Subject: Re: If I have a single bad sector, how many failed reads should
 simple dd report?
Date: Fri, 09 Jul 2010 21:19:21 -0400
Message-ID: <4C37CA99.1040104@teksavvy.com>
References: <AANLkTil2Zfhpkq24qrCoHZVx1vlbIPTcDMrZ508yODta@mail.gmail.com> <AANLkTimWfp4mLF9DCpxtnnUQsYQ08gXmh491EfhARe1x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:21008 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751186Ab0GJBTX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jul 2010 21:19:23 -0400
In-Reply-To: <AANLkTimWfp4mLF9DCpxtnnUQsYQ08gXmh491EfhARe1x@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>

On 09/07/10 03:04 PM, Greg Freemyer wrote:
..
>> When I re-ran it, /var/log/messages reported 10 bad logical blocks.
>> And even worse, dd reported 20 bad blocks.  I examined the data dd
>> read and it had 80KB of zero'ed out data.  So that's 160 sectors worth
>> of data lost because of a single bad sector.  At most I was expecting
>> 4KB of zero'ed out data.
..

That's just the standard, undesirable result of the current SCSI EH
when used with libata for (mainly) desktop computers.

I have patches (against older kernels) to fix it, but have yet to
get both myself and James B. interested enough simultaneously to
actually get the kernel fixed.  :)
..
> cmp -bl clean.dd corrupt.dd>  delta.log
>
> Looking at delta.log, the bytes start disagreeing 4 bytes prior to the
> sector boundary.  How can that be?
..

Dunno.  That could be a different problem.
I've seen the odd scattered report of data corruption on ext3/ext4
with large data sets, but don't know what the root causes were.

Cheers
