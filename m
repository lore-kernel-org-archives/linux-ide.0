From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Thu, 19 Nov 2009 16:57:19 -0500
Message-ID: <4B05BF3F.3040407@garzik.org>
References: <20091117144450.15430.83450.stgit@localhost.localdomain> <200911181919.19127.bzolnier@gmail.com> <4B05BA72.2030406@garzik.org> <200911192242.59476.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44358 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755522AbZKSV5Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Nov 2009 16:57:16 -0500
In-Reply-To: <200911192242.59476.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 11/19/2009 04:42 PM, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 19 November 2009 22:36:50 Jeff Garzik wrote:
>> On 11/18/2009 01:19 PM, Bartlomiej Zolnierkiewicz wrote:
>>> On Tuesday 17 November 2009 15:51:39 Alan Cox wrote:
>>>> Signed-off-by: Alan Cox<alan@linux.intel.com>
>>>> ---
>>>>
>>>>    drivers/ata/Kconfig |    8 ++++----
>>>>    1 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>>
>>>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>>>> index f2df6e2..36931e0 100644
>>>> --- a/drivers/ata/Kconfig
>>>> +++ b/drivers/ata/Kconfig
>>>> @@ -374,7 +374,7 @@ config PATA_HPT366
>>>>    	  If unsure, say N.
>>>>
>>>>    config PATA_HPT37X
>>>> -	tristate "HPT 370/370A/371/372/374/302 PATA support (Experimental)"
>>>> +	tristate "HPT 370/370A/371/372/374/302 PATA support"
>>>>    	depends on PCI&&   EXPERIMENTAL
>>>>    	help
>>>>    	  This option enables support for the majority of the later HPT
>>>> @@ -383,7 +383,7 @@ config PATA_HPT37X
>>>>    	  If unsure, say N.
>>>>
>>>>    config PATA_HPT3X2N
>>>> -	tristate "HPT 372N/302N PATA support (Experimental)"
>>>> +	tristate "HPT 372N/302N PATA support"
>>>>    	depends on PCI&&   EXPERIMENTAL
>>>>    	help
>>>>    	  This option enables support for the N variant HPT PATA
>>>
>>> Maybe they are 'stable' but when it comes to features they are behind hpt366
>>> (i.e. they lack PCI PM), which is also much cleaner than your drivers, easier
>>> to understand and much smaller..
>>
>> That sounds like an ACK to Alan's patch, to me ;-)
>>
>> A libata driver can be stable, yet not have all the features of drivers/ide.
>>
>> That said, I do agree that libata drivers need to have the features
>> found in the drivers/ide/ drivers.
>
> Feel free to add them Mr. Maintainer. :)

Oh, I'm happy to wait until one of two scenarios occurs:

1) Bart annoys Alan sufficiently to motivate Alan to add feature X
2) Alan annoys Bart sufficiently to motivate Bart to add feature X

Personally, I think my two PATA co-maintainers are doing an excellent 
job of finding and killing bugs, and adding features, even if the 
mailing list traffic is contentious.

I'm happy as long as the users win in the end...

	Jeff



