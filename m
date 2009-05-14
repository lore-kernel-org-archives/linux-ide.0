From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/7] ide: pass number of ports to ide_host_{alloc,add}()
Date: Fri, 15 May 2009 00:19:23 +0400
Message-ID: <4A0C7CCB.1040805@ru.mvista.com>
References: <20090513205139.28638.87226.sendpatchset@localhost.localdomain> <20090513205222.28638.19386.sendpatchset@localhost.localdomain> <4A0C6A27.7010703@ru.mvista.com> <200905142151.15854.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:12556 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750957AbZENUT2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 May 2009 16:19:28 -0400
In-Reply-To: <200905142151.15854.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>> @@ -467,7 +467,7 @@ icside_register_v6(struct icside_state *
>>>  	struct ide_host *host;
>>>  	unsigned int sel = 0;
>>>  	int ret;
>>> -	hw_regs_t hw[2], *hws[] = { &hw[0], NULL, NULL, NULL };
>>> +	hw_regs_t hw[2], *hws[] = { &hw[0], NULL };
>>>       
>>     I wonder if there's an old bug here since I'm not seeing when hws[1] is 
>> set to non-NULL -- despite there are apparently two ports?
>>
>>     Indeed, this bug seems to date back to the 'struct ide_host' 
>> introduction, see this:
>>  
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=48c3c1072651922ed153bcf0a33ea82cf20df390#patch1...
>>     
>
> Care to send a fix?
>   

   I will...

MBR, Sergei


