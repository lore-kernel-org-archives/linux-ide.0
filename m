From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Sat, 25 Oct 2008 22:27:50 +0400
Message-ID: <49036526.5090508@ru.mvista.com>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp> <200810222215.02762.bzolnier@gmail.com> <20081024065043.GA4762@gollum.tnic> <200810251458.46140.bzolnier@gmail.com> <49032230.3080603@ru.mvista.com> <20081025174710.GA32108@gollum.tnic> <4903638F.4060309@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:6480 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751197AbYJYS17 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Oct 2008 14:27:59 -0400
In-Reply-To: <4903638F.4060309@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, valerio.p@libero.it, linux-ide@vger.kernel.org

Hello, I wrote:

>>>> For 'addr' we may try to use 4 bytes instead of the current 32 ones 
>>>> but lets
>>>> fix the regression first.
>>>>       
>>>   Alas, TX4939 requeires 8-byte DMA address (and byte count) 
>>> alignment.  Another semi-compatible SFF-8038 implementation...
>>>     
>>
>> ... which calls for a field in the capabilities and mechanical status 
>> page
>> saying something like: hello, I'm a xy device and I can do z bytes dma
>> alignment, otherwise I get cranky and don't work anymore :)
>>   
>
>   I didn't get it -- TX4939 is IDE host controller

   Oops -- actualy it's a SoC having 2 IDE controllers.

MBR. Sergei


