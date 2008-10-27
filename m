From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Mon, 27 Oct 2008 11:55:24 +0100
Message-ID: <9ea470500810270355t568c88f2p24fcd45d51ef4164@mail.gmail.com>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp>
	 <200810260938.55709.valerio.passini@unicam.it>
	 <20081026145819.GA1320@gollum.tnic>
	 <200810262101.42874.valerio.passini@unicam.it>
	 <20081027061556.GA17928@gollum.tnic> <49059C56.2010405@ru.mvista.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:48627 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbYJ0Kz0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Oct 2008 06:55:26 -0400
Received: by gxk9 with SMTP id 9so2113244gxk.13
        for <linux-ide@vger.kernel.org>; Mon, 27 Oct 2008 03:55:24 -0700 (PDT)
In-Reply-To: <49059C56.2010405@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Valerio Passini <valerio.passini@unicam.it>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, valerio.p@libero.it, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org

On Mon, Oct 27, 2008 at 11:47 AM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Borislav Petkov wrote:
>
>  More nipicking... :-)

Admit that you secretly like doing that :)

s/nipcking/nitpicking/

>> From: Borislav Petkov <petkovbb@gmail.com>
>> Date: Mon, 27 Oct 2008 06:59:14 +0100
>> Subject: [PATCH] ide-cd: fix dma alignment regression
>>
>> e5318b531b008c79d2a0c0df06a7b8628da38e2f introduced a regression which
>>
>
>  I remember Linus asking to put the commit's one-liner in parens after its
> SHA1...

I remember reading something in the likes of it, will fix.

>> caused some ATAPI drives to turn off dma for REQ_TYPE_ATA_PC commands
>>
>
>  Hm, why "ATAPI" but "dma"? Is "dma" a neologism now in English? :-)

Are you're referring to "... Once the Command Packet has been sent, the command
proceeds as a normal ATA command would. The Command Packet bytes shall always be
transferred via PIO and never using DMA." from SFF8020?

>> while burning and thus degrating performance and ultimately causing an
>>
>
>   s/degrating/degrading/

Already fixed. Will resend later, thanks.

-- 
Regards/Gruss,
Boris
