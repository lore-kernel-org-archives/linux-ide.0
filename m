From: Geller Sandor <wildy@petra.hos.u-szeged.hu>
Subject: Re: HPT374 IDE problem with 2.6.21.* kernels
Date: Sun, 3 Jun 2007 12:37:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0706031224030.25438@petra.hos.u-szeged.hu>
References: <Pine.LNX.4.62.0705301112170.1260@petra.hos.u-szeged.hu>
 <46608EFE.1030202@ru.mvista.com> <Pine.LNX.4.62.0706020035200.19399@petra.hos.u-szeged.hu>
 <200706030138.15353.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eos.fwall.u-szeged.hu ([160.114.120.248]:57175 "EHLO
	eos.fwall.u-szeged.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760961AbXFCKhi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Jun 2007 06:37:38 -0400
In-Reply-To: <200706030138.15353.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

On Sun, 3 Jun 2007, Bartlomiej Zolnierkiewicz wrote:

>
> Hi,
>
> On Saturday 02 June 2007, Geller Sandor wrote:
>> On Sat, 2 Jun 2007, Sergei Shtylyov wrote:
>>
>>>> The log of a typical IDE reset is available here:
>>>
>>>> http://petra.hos.u-szeged.hu/~wildy/syslog.gz
>>>
>>>> This was the worst case: the IDE bus was resetted during the system boot.
>>>
>>>   Could you try setting HPT374_ALLOW_ATA133_6 to 0 in
>>> drivers/ide/pci/hpt366.c and rebuild/reboot the kernel?
>>
>>
>> Hi Sergei,
>>
>> This looks promising. Using a vanilla 2.6.22-rc3 I was able to reproduce
>> the problem within a few seconds. With the above modification the machine
>> is running under heavy disk I/O without problems since 30 minutes...
>
> Did it fix the problem for good?

It seems so far. There hasn't been any problem since I've applied the fix.

> Sergei, do we need to disallow UDMA6 completely on HPT734 or
> is it only an issue with some problematic devices (=> blacklist)?
>
> Either way we need to fix it somehow for 2.6.22.

For the record: this HTP374 is running with a quite outdated firmware 
(1.22) - maybe newer firmwares work correctly. I'm going to upgrade the 
firmware to the latest one (which was released in 2004...), but 
unfortunately in the upcoming 2-3 weeks I won't have access to this 
machine, so I can't check the case within the release cycle of 2.6.22. If 
you were interested I would post the result of the firmware upgrade.

Regards,

   Sandor
