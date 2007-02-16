From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) cmd64x: remove broken SW/MW DMA
 support
Date: Fri, 16 Feb 2007 18:06:12 +0300
Message-ID: <45D5C864.80009@ru.mvista.com>
References: <200702080858.l188wjmG008432@harpo.it.uu.se> <45D5AD8B.1060702@ru.mvista.com> <45D5B420.7040509@ru.mvista.com> <200702161542.16883.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:51254 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932415AbXBPPGX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Feb 2007 10:06:23 -0500
In-Reply-To: <200702161542.16883.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>   The intent of the patch was exactly to *remove* broken DMA support 
>>>until it's fixed (which requires more work).  It only worked by chance 
>>>-- because MWDMA2 timings are the same as of PIO4.  Have patience please.

>>    You may also consider switching to the libata driver -- Alan said he fixed 
>>DMA support there after I frisrt reported the breakage (however, I' still not 
>>seeing it fixed in the mainline)...

> I've just checked 2.6.20-mm1 (contains libata tree) and it is not fixed.

    I was saying exatly that. So, that's a question to Alan. :-)

> Bart

WBR, Sergei
