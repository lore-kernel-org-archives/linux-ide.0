From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: HPT374 IDE problem with 2.6.21.* kernels
Date: Sun, 03 Jun 2007 21:36:48 +0400
Message-ID: <4662FC30.2000602@ru.mvista.com>
References: <Pine.LNX.4.62.0705301112170.1260@petra.hos.u-szeged.hu> <46608EFE.1030202@ru.mvista.com> <Pine.LNX.4.62.0706020035200.19399@petra.hos.u-szeged.hu> <200706030138.15353.bzolnier@gmail.com> <Pine.LNX.4.62.0706031224030.25438@petra.hos.u-szeged.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:3385 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753987AbXFCRfT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Jun 2007 13:35:19 -0400
In-Reply-To: <Pine.LNX.4.62.0706031224030.25438@petra.hos.u-szeged.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geller Sandor <wildy@petra.hos.u-szeged.hu>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Geller Sandor wrote:
Hello.

>>>>> The log of a typical IDE reset is available here:

>>>>> http://petra.hos.u-szeged.hu/~wildy/syslog.gz

>>>>> This was the worst case: the IDE bus was resetted during the system 
>>>>> boot.

>>>>   Could you try setting HPT374_ALLOW_ATA133_6 to 0 in
>>>> drivers/ide/pci/hpt366.c and rebuild/reboot the kernel?

>>> Hi Sergei,

>>> This looks promising. Using a vanilla 2.6.22-rc3 I was able to reproduce
>>> the problem within a few seconds. With the above modification the 
>>> machine
>>> is running under heavy disk I/O without problems since 30 minutes...

>> Did it fix the problem for good?

> It seems so far. There hasn't been any problem since I've applied the fix.

>> Sergei, do we need to disallow UDMA6 completely on HPT734 or
>> is it only an issue with some problematic devices (=> blacklist)?

    Note that I didn't change what the old code was doing in this regard -- 
although the HPT374 spec does *not* say that UDMA6 is supported, it had been 
enabled. What have *really* changed for HPT374 was:

- in 2.6.20-rc1, the driver switched to using the actual 33 MHz timing table
   instead of the old one, matching 50 MHz (and so, severely underclocked);

- in 2.6.2-rc1, the driver switched from 33 MHz PCI to 66 MHz DPLL clock.

    Disallowing UDMA6 would clock the chip with 50 MHz DPLL, howewer, the 
original report claimed that something has changed to worse between 2.6.21.1 
and .3 but nothing changed in drivers/ide/ between those releases...

>> Either way we need to fix it somehow for 2.6.22.

> For the record: this HTP374 is running with a quite outdated firmware 
> (1.22) - maybe newer firmwares work correctly. I'm going to upgrade the 
> firmware to the latest one (which was released in 2004...), but 
> unfortunately in the upcoming 2-3 weeks I won't have access to this 
> machine, so I can't check the case within the release cycle of 2.6.22. 
> If you were interested I would post the result of the firmware upgrade.

    I don't think this will matter...

> Regards,
>   Sandor

MBR, Sergei
