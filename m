From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 01/15] ide: include <asm/ide.h> only when needed
Date: Fri, 06 Feb 2009 02:58:01 +0300
Message-ID: <498B7D09.6040100@ru.mvista.com>
References: <20090201174916.19144.11318.sendpatchset@localhost.localdomain> <200902021927.25177.bzolnier@gmail.com> <20090204.232006.01916235.anemo@mba.ocn.ne.jp> <200902052214.31483.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:64806 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753131AbZBEX6I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Feb 2009 18:58:08 -0500
In-Reply-To: <200902052214.31483.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, geert@linux-m68k.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, apw@canonical.com

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>>> +#include <asm/ide.h>
>>>>>           
>>>> Did you try checkpatch.pl?
>>>>         
>>> Sure.
>>>
>>> This driver uses stuff from <asm-mips/ide.h>.
>>>
>>> [ I guess I could put '-mips' there to silence warnings on tx493{8,9}.c,
>>>   however I don't know of the way to get rid of ide-io-std.c's one... ]
>>>       
>> BTW, tx4939ide_{in,out}put_data_swap and
>> tx4939ide_{in,out}put_data_swap do exactly same thing.
>>
>> If byte-swapped version of ide_{in,out}put_data() were available by
>> ide core, they can be used instead.  The byte-swapped version of
>> default_tp_ops would much helps such queer big-endian platforms.  Is
>> it worth to bloat ide core? ;-)
>>     
>
> Seems to be a good idea and it may also help some other host drivers
> (ide-h8300.c?).
>   

   I'm not sure we need to carry the extra little used code just to help 
some exotic driver.

> Thanks,
> Bart

MBR, Sergei


