From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] palm_bk3710: fix resource management (take 2)
Date: Tue, 17 Jun 2008 02:35:38 +0400
Message-ID: <4856EABA.4040105@ru.mvista.com>
References: <200806162351.07566.sshtylyov@ru.mvista.com> <200806162210.39943.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:19034 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757010AbYFPWfo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Jun 2008 18:35:44 -0400
In-Reply-To: <200806162210.39943.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:
> On Monday 16 June 2008, Sergei Shtylyov wrote:
>   
>> The driver expected a *virtual* address in the IDE platform device's memory
>> resource and didn't request the memory region for the register block. Fix this
>> taking into account the fact that DaVinci SoC devices are fixed-mapped to the
>> virtual memory early and we can get their virtual addresses using IO_ADDRESS()
>> macro, not having to call ioremap()...
>>
>> While at it, also do some cosmetic changes...
>>
>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>>
>> ---
>> Argh! I have finally run checkpatch.pl and it detected some whitespace damage.
>> And of course, I then re-sent it without fixing that!
>> So, here's take 2 of that stupid patch for real now. Sorry for the mess... :-<
>>     
>
> I've already fixed it while applying "take 1" but I was too lazy to
> mention it (not that single " " removal is worth mentioning)... :)
>   

   I do that kind of mistakes in reject resolution very rarely. This 
just wasn't my day it seems... :-)

> [ However please integrate checkpatch.pl into your workflow... ]
>
>   
   The forgotten signoff is surely my problem, so indeed I should... if 
I don't forget. ;-)

WBR. Sergei


