From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3] AT91: initialize IDE driver on AT91SAM9263 cpu
Date: Fri, 06 Feb 2009 02:52:37 +0300
Message-ID: <498B7BC5.40506@ru.mvista.com>
References: <200902031147.41822.stf_xl@wp.pl>	 <cd73a99e0902031227x678ebfa3h14207aeaf00a406c@mail.gmail.com>	 <200902041036.30785.stf_xl@wp.pl> <498AD574.9050003@ru.mvista.com> <cd73a99e0902051143m755cf077le11f01bd4454b15f@mail.gmail.com> <498B45AB.3070409@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:64699 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754264AbZBEXwm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Feb 2009 18:52:42 -0500
In-Reply-To: <498B45AB.3070409@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Victor <avictor.za@gmail.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

Hello. I wrote:

>>>> http://download.ronetix.info/sk-eb926x/linux/kernel/2.6.28/003_linux-2.6.28-at91-ronetix-12012009.patch 
>>>>
>
>>> This patch is clearly incomplete because drivers/pcmcia/at91_cf.c does
>>> accesses AT91RM9200 specific SMC register, but the patch does 
>>> nothing about
>>> making this work on AT91SAM9. Though it indeed seems that AT91SAM9 
>>> can be
>>> supported by that driver with minimum change -- perhaps by using
>>> cpi_is_*()...
>
>> Rather see latest patch on http://maxim.org.za/at91_26.html.
>
>> The cpu_is_XX() is for run-time selection (and is the preferred 
>> mechanism).
>> Unfortunately the SMC registers are significantly different on the
>> SAM9 and RM9200, so we need to use #ifdefs for compile-time selection.
>
>    Ah, seeing the real issue now: different encoding of the DBW fields 
> b/w those 2 types of SMCs. Oh, and I've missed the different DBW field 
> positions too... That however can be addressed by using the driver 
> local #define', not the ones from the headers (which should be 
> conflicting)...

   Well, probably not the best approach either. Since the SMC specific 
in contained in a single funtion in this case, anothe rapproach can be 
used: implement the function in the platfrom code and pass the pointer 
to it via the platfrom data. This approach is used when the driver needs 
to some board specific hook, e.g. some MMC drivers use this approach for 
checking the write protect signal wired to some GPIO in a board specific 
way).

>>   Andrew Victor
> Regards,

WBR, Sergei


