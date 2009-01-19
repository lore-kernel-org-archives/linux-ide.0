From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [patch 2.6.29-rc2] palm_bk3710 buildfix
Date: Mon, 19 Jan 2009 17:14:54 +0300
Message-ID: <49748ADE.70107@ru.mvista.com>
References: <200901180833.53969.david-b@pacbell.net> <49743B36.90909@ru.mvista.com> <4974408A.9050608@ru.mvista.com> <200901191307.33405.bzolnier@gmail.com> <49747AE7.7060908@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:52855 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752965AbZASOOW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 09:14:22 -0500
In-Reply-To: <49747AE7.7060908@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, David Brownell <david-b@pacbell.net>, linux-ide@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

Hello, I wrote:

>>>>>>> Someone should fix hw_regs_t to neither be a typedef, nor
>>>>>>> use "unsigned long" where it should use "void __iomem *".

>>>>>>    It cannot use pointers of course -- as the addresses can be I/O 
>>>>>> ports.

>>>>> It could use the ioread*() calls, which take pointers
>>>>> and handle both types of I/O in a type-safe manner.

>>>>  Probably they can... though using those would only slow down 
>>>> register access on x86.

>>>   ... and cause code bloat due to switching to real function calls 
>>> from inlines which now should render into in/out isns.

>> OTOH it would allow to unify a lot of 'if (hwif->host_flags & 
>> IDE_HFLAG_MMIO)'
>> cases so the code may even shrink.

>    It won't shrink as much as it will grow.

>> I also suspect that register access slow
>> down is most likely negligable (we can always measure and check it).

>    I'd agree here but code bloat won't be as negligible considering the 
> IDE code's predominant use of I/O ports on x86.

    After looking at the current code, the generic IDE code would actually 
benefit from such change, while the most of the controller drivers will only 
be subject to the code bloat.

MBR, Sergei
