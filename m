From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Wed, 05 Dec 2007 23:22:13 +0900
Message-ID: <4756B415.404@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com>	<11963468202627-git-send-email-htejun@gmail.com>	<4755ABB3.6030907@garzik.org>	<4755FB90.50505@gmail.com>	<20071205124713.4d31c5e7@the-village.bc.nu>	<4756A1AE.4010205@gmail.com> <20071205140119.532c1eb4@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:7768 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbXLEOXr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 09:23:47 -0500
Received: by wa-out-1112.google.com with SMTP id v27so7164223wah
        for <linux-ide@vger.kernel.org>; Wed, 05 Dec 2007 06:22:27 -0800 (PST)
In-Reply-To: <20071205140119.532c1eb4@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Mikael Pettersson <mikpe@it.uu.se>

Alan Cox wrote:
>> Well, if we change that in #upstream now, -mm will receive it and after
>> 2.6.24 is released, it will end up in -rc1.  We can change it back if
>> the damage is too grave.
> 
> Getting it in -rc is going to mess up other testing. It's perfect for -mm
> testing not -rc testing.

It eventually has to end up in -rc.  If not for 2.6.25-rc1 is too early,
we can put it in #testing and put it into #upstream later.

>> Yeah, ALi seems to be genuine driver problem.  I don't think using PIO
>> for misc ATAPI commands is extreme considering Windows is doing it.
> 
> Windows does a lot of things that are bad and ugly workarounds for messes
> in the past. We have the ability to do a lot better than that.

I agree.  It's double edged sword tho.  We're not gonna get much test
coverage over those messes of the past and as I said, those are what I'm
primarily worried about.  Command type dependent quick fallback might
help but ancient controllers are more likely to bring the whole machine
down when a DMA transaction goes south.

>> Another thing is check_atapi_dma in sata_promise.  It mentions losing
>> interrupt which is exactly what happens if the drive tries to transfer
>> more data but DMA buffer is short on several controllers.  I wonder
>> whether this is unnecessary with DMA draining added.
> 
> Is it like the inic where you must do transfers in specific chunk sizes ?

I don't think so.  It does READ_CD and READ_DVD_STRUCTURE via DMA.  The
first one isn't 2k aligned the second is of variable size.  I think the
driver was just working around buggy userland which issues commands like
mode sense with longer allocation size than actual buffer size.

-- 
tejun
