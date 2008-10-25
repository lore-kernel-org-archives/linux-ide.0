From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Sat, 25 Oct 2008 19:47:10 +0200
Message-ID: <20081025174710.GA32108@gollum.tnic>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp> <200810222215.02762.bzolnier@gmail.com> <20081024065043.GA4762@gollum.tnic> <200810251458.46140.bzolnier@gmail.com> <49032230.3080603@ru.mvista.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:31231 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbYJYRrR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Oct 2008 13:47:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1343888fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 25 Oct 2008 10:47:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49032230.3080603@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, valerio.p@libero.it, linux-ide@vger.kernel.org

On Sat, Oct 25, 2008 at 05:42:08PM +0400, Sergei Shtylyov wrote:
> Hello.
>
> Bartlomiej Zolnierkiewicz wrote:
>
>> For 'addr' we may try to use 4 bytes instead of the current 32 ones but lets
>> fix the regression first.
>>   
>
>   Alas, TX4939 requeires 8-byte DMA address (and byte count) alignment.  
> Another semi-compatible SFF-8038 implementation...

... which calls for a field in the capabilities and mechanical status page
saying something like: hello, I'm a xy device and I can do z bytes dma
alignment, otherwise I get cranky and don't work anymore :)

-- 
Regards/Gruss,
    Boris.
