From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [patch 2.6.29-rc2] palm_bk3710 buildfix
Date: Mon, 19 Jan 2009 11:57:46 +0300
Message-ID: <4974408A.9050608@ru.mvista.com>
References: <200901180833.53969.david-b@pacbell.net> <4973635A.2050302@ru.mvista.com> <200901181629.48348.david-b@pacbell.net> <49743B36.90909@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:42069 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753417AbZASI5w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jan 2009 03:57:52 -0500
In-Reply-To: <49743B36.90909@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

Hello, I wrote:

>>>> Someone should fix hw_regs_t to neither be a typedef, nor
>>>> use "unsigned long" where it should use "void __iomem *".
>>>>       
>>>     It cannot use pointers of course -- as the addresses can be I/O 
>>> ports.
>>>     
>>
>> It could use the ioread*() calls, which take pointers
>> and handle both types of I/O in a type-safe manner.
>>   
>
>   Probably they can... though using those would only slow down 
> register access on x86.

   ... and cause code bloat due to switching to real function calls from 
inlines which now should render into in/out isns.

> - Dave

WBR, Sergei


