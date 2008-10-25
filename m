From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Sat, 25 Oct 2008 22:21:03 +0400
Message-ID: <4903638F.4060309@ru.mvista.com>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp> <200810222215.02762.bzolnier@gmail.com> <20081024065043.GA4762@gollum.tnic> <200810251458.46140.bzolnier@gmail.com> <49032230.3080603@ru.mvista.com> <20081025174710.GA32108@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:6374 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750960AbYJYSVM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Oct 2008 14:21:12 -0400
In-Reply-To: <20081025174710.GA32108@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, valerio.p@libero.it, linux-ide@vger.kernel.org

Hello.

Borislav Petkov wrote:

>>> For 'addr' we may try to use 4 bytes instead of the current 32 ones but lets
>>> fix the regression first.
>>>       
>>   Alas, TX4939 requeires 8-byte DMA address (and byte count) alignment.  
>> Another semi-compatible SFF-8038 implementation...
>>     
>
> ... which calls for a field in the capabilities and mechanical status page
> saying something like: hello, I'm a xy device and I can do z bytes dma
> alignment, otherwise I get cranky and don't work anymore :)
>   

   I didn't get it -- TX4939 is IDE host controller and I can't imagine 
how an ATAPI device could care about the buffer address alignment on the 
host side...

MBR. Sergei


