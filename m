From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Thu, 22 Jan 2009 15:16:54 +0300
Message-ID: <497863B6.4040306@ru.mvista.com>
References: <200901141345.42583.stf_xl@wp.pl> <4975B065.6030705@ru.mvista.com> <200901221212.55528.stf_xl@wp.pl> <49786138.20809@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:24240 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752503AbZAVMRA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jan 2009 07:17:00 -0500
In-Reply-To: <49786138.20809@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Hello, I wrote:

>>>> +            t9 = t2i - t1;
>>>>         
>>>    It  more sense to calculate such things *after* quantizing the 
>>> timings with calc_mck_cycles()...
>>>     
>> Why?
>>   
>
>   More precise result -- matching the clock being used.

   However, I don't understand now why you need to stretch t9...

MBR, Sergei


