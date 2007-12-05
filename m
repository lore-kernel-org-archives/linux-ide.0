From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Wed, 05 Dec 2007 22:03:42 +0900
Message-ID: <4756A1AE.4010205@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com>	<11963468202627-git-send-email-htejun@gmail.com>	<4755ABB3.6030907@garzik.org>	<4755FB90.50505@gmail.com> <20071205124713.4d31c5e7@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:3275 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbXLEND5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 08:03:57 -0500
Received: by wa-out-1112.google.com with SMTP id v27so7111129wah
        for <linux-ide@vger.kernel.org>; Wed, 05 Dec 2007 05:03:54 -0800 (PST)
In-Reply-To: <20071205124713.4d31c5e7@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Mikael Pettersson <mikpe@it.uu.se>

Alan Cox wrote:
>> This is about time we make decision on this.  If we're gonna go
> 
> I thought everyone but you had made a decision ;)

Hey, at least Mark was loosely on my side! 8-P

>> DMA-for-everything way, we should lift 16 byte default masking for -mm
>> and -rc's as that only makes debugging difficult and try to blacklist
>> offending devices and controllers individually.
> 
> Would be a useful experiment for -mm not really I think for -rc.

Well, if we change that in #upstream now, -mm will receive it and after
2.6.24 is released, it will end up in -rc1.  We can change it back if
the damage is too grave.

>> My primary concern is about not achieving enough test coverage and
>> isolated cases where it's difficult to tell whether it's the device or
>> the controller.  e.g. Loading recent distro on an ancient and/or strange
>> machine, scratching head while cursing and giving up.  
> 
> Watching the Fedora bugzilla I don't see things that match up to your
> descriptions and fixes. Indeed I've now got verification that the weird
> ALi ATAPI problem a few people have isn't even fixed by your extreme
> changes.

Yeah, ALi seems to be genuine driver problem.  I don't think using PIO
for misc ATAPI commands is extreme considering Windows is doing it.

Another thing is check_atapi_dma in sata_promise.  It mentions losing
interrupt which is exactly what happens if the drive tries to transfer
more data but DMA buffer is short on several controllers.  I wonder
whether this is unnecessary with DMA draining added.

Thanks.

-- 
tejun
