From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_hpt3x2n: fix overclocked MWDMA0 timing
Date: Fri, 04 Dec 2009 00:51:33 +0300
Message-ID: <4B1832E5.9080100@ru.mvista.com>
References: <200911271956.55939.bzolnier@gmail.com> <4B102B83.1080102@ru.mvista.com> <4B102CE5.1050901@ru.mvista.com> <4B182615.8030104@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:8014 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751733AbZLCVvm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 16:51:42 -0500
In-Reply-To: <4B182615.8030104@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Jeff Garzik wrote:

>>>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>>>> ---
>>>> Sergei, XFER_UDMA_5 timing also looks suspicious,
>>>> please take a look when you have a minute, thanks.
>>
>>> Yeah, but it's the same as XFER_UDMA_4, so actually underclocked...
>>> However, it matches what the HPT371N datasheet and the vendor drivers
>>> have. The 'hpt366' driver uses more speedy mode, with 22.5 ns cycle. 
>>> ;-)
>>
>> I have just verified: this driver has always used this timing
>> historically, at least for HPT372+ chips.
>
> Could you clarify which "this timing" you are referring to?  :)

   UDMA5 timing which looked suspicious to Bart: 'hpt366' driver uses 
faster timing at 66 MHz clock than the vendor drivers and HPT371N 
datasheet have (they have it the same as UDMA4).

>   I never saw an Acked-by on this one.

   I usually don't ACK libata patches, but this one can be an exception:

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

   Though I guess you're waiting for Alan's ACK... :-)

>     Jeff

MBR, Sergei


