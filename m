From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_hpt3x2n: fix overclocked MWDMA0 timing
Date: Thu, 03 Dec 2009 15:56:53 -0500
Message-ID: <4B182615.8030104@garzik.org>
References: <200911271956.55939.bzolnier@gmail.com> <4B102B83.1080102@ru.mvista.com> <4B102CE5.1050901@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:47070 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbZLCU4s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 15:56:48 -0500
In-Reply-To: <4B102CE5.1050901@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/27/2009 02:47 PM, Sergei Shtylyov wrote:
> Hello, I wrote:
>
>>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>>> ---
>>> Sergei, XFER_UDMA_5 timing also looks suspicious,
>>> please take a look when you have a minute, thanks.
>
>> Yeah, but it's the same as XFER_UDMA_4, so actually underclocked...
>> However, it matches what the HPT371N datasheet and the vendor drivers
>> have. The 'hpt366' driver uses more speedy mode, with 22.5 ns cycle. ;-)
>
> I have just verified: this driver has always used this timing
> historically, at least for HPT372+ chips.

Could you clarify which "this timing" you are referring to?  :)  I never 
saw an Acked-by on this one.

	Jeff




