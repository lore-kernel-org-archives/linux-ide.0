From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Sat, 25 Oct 2008 20:43:17 +0200
Message-ID: <20081025184317.GA3962@gollum.tnic>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp> <200810222215.02762.bzolnier@gmail.com> <20081024065043.GA4762@gollum.tnic> <200810251458.46140.bzolnier@gmail.com> <49032230.3080603@ru.mvista.com> <20081025174710.GA32108@gollum.tnic> <4903638F.4060309@ru.mvista.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:6104 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbYJYSnX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Oct 2008 14:43:23 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1243808fkq.5
        for <linux-ide@vger.kernel.org>; Sat, 25 Oct 2008 11:43:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4903638F.4060309@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, valerio.p@libero.it, linux-ide@vger.kernel.org

On Sat, Oct 25, 2008 at 10:21:03PM +0400, Sergei Shtylyov wrote:
> Hello.
>
> Borislav Petkov wrote:
>
>>>> For 'addr' we may try to use 4 bytes instead of the current 32 ones but lets
>>>> fix the regression first.
>>>>       
>>>   Alas, TX4939 requeires 8-byte DMA address (and byte count) 
>>> alignment.  Another semi-compatible SFF-8038 implementation...
>>>     
>>
>> ... which calls for a field in the capabilities and mechanical status page
>> saying something like: hello, I'm a xy device and I can do z bytes dma
>> alignment, otherwise I get cranky and don't work anymore :)
>>   
>
>   I didn't get it -- TX4939 is IDE host controller and I can't imagine  
> how an ATAPI device could care about the buffer address alignment on the  
> host side...

Sorry about that - I was talking only about the ATAPI device. Totally unrelated,
my bad.

-- 
Regards/Gruss,
    Boris.
