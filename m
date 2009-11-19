From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Thu, 19 Nov 2009 17:03:29 -0500
Message-ID: <4B05C0B1.2020307@garzik.org>
References: <20091117144450.15430.83450.stgit@localhost.localdomain> <200911182056.16517.bzolnier@gmail.com> <4B05BADF.1010205@garzik.org> <200911192249.16860.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47808 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752752AbZKSWD1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Nov 2009 17:03:27 -0500
In-Reply-To: <200911192249.16860.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 11/19/2009 04:49 PM, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 19 November 2009 22:38:39 Jeff Garzik wrote:
>> On 11/18/2009 02:56 PM, Bartlomiej Zolnierkiewicz wrote:
>>> On Wednesday 18 November 2009 20:07:07 Bartlomiej Zolnierkiewicz wrote:
>>>> On Wednesday 18 November 2009 19:41:25 Alan Cox wrote:
>>>>>> Maybe they are 'stable' but when it comes to features they are behind hpt366
>>>>>> (i.e. they lack PCI PM), which is also much cleaner than your drivers, easier
>>>>>> to understand and much smaller..
>>>>>
>>>>> 37x and 3xn lack PCI PM.  Added to the TODO list.
>>>>>
>>>>> The smaller size is a bit questionable given its mostly comments, and
>>>>> three drivers versus one.
>>>>
>>>> I wonder what you find 'questionable' in the numbers given..
>>>
>>> BTW we can immediately reclaim 300 LOC by simply merging drivers back..
>>
>> Merging drivers is a big pain for distributions and end users, even with
>> the new module_alias facility.
>
> Could please explain in more detail 'a big pain' part?

It makes issue tracking (bug reports, feature requests, etc.) more 
difficult.  The "where did my driver go?" issue, which is largely a 
communication/education not technical problem.  Manually specifying 
drivers in /etc/modprobe.conf remains supported.


>> Absent stronger justification, libata remains with separate drivers,
>> even if that means some code duplication.
>
> I can always hold my own tree with such changes if needed.

If it really bugs you, you could take the drivers/ata/sata_promise.h 
approach, or do multi-file modules.

	Jeff



