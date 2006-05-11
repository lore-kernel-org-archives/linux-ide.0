From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] PIIX: fix 82371MX enablebits
Date: Fri, 12 May 2006 00:32:12 +0400
Message-ID: <44639F4C.7040709@ru.mvista.com>
References: <446395A0.20806@ru.mvista.com> <1147379225.26130.81.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:25551 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750771AbWEKUdU
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 16:33:20 -0400
In-Reply-To: <1147379225.26130.81.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:

>>     According to the datasheet, Intel 82371MX (MPIIX) actually has only a
>>single IDE channel mapped to the primary or secondary ports depending on the
>>value of the bit 14 of the IDETIM register at PCI config. offset 0x6C (the
>>register at 0x6F which the driver refers to. doesn't exist). So, disguise the
>>controller as dual channel and set enablebits masks/values such that only
>>either primary or secondary channel is detected enabled. Also, preclude the
>>IDE probing code from reading PCI BARs, this controller just doesn't have them
>>(it's not the separate PCI function like the other PCI controllers), it only
>>decodes the legacy addresses.

> There are lots and lots of other things you need to fix to make MPIIX
> work with that driver. It has only a single timing register for one so
> you must switch timing as you flip drive.

    I know. All in a good time (if I have it :-)...

> Also it is not an IDE class
> device so the PCI native/legacy and simplex stuff is not valid.

    Erm, simplex stuff shouldn't be touched at all since the chip is not 
DMA-capable. The same should be true about the native/legacy mode...

> Finally the PIIX driver pokes several registers it doesn't even have.

    Hm, as I can see, it avoids touching anything at all on MPIIX. This may 
rather be said of PIIX -- this chip didn't have SIDETIM register yet, so slave 
tuning won't work on it...

> What else - oh yes the piix driver doesn't even tune the timings, so it
> doesn't work anyway.

    Of course it doesn't, because of the non-standard timing reg.
    BTW, piix_tune_drive() "forgets" to actully set the speed for drive and... 
setting UDMA modes affects PIO timing for absolutely no reason and ... all in 
all, the tuning code here is BAD.

> Thats why drivers/scsi/pata_mpiix is a separate driver. Really if you
> want to try and rescue the old PIIX driver you should split out PIIX3
> and MPIIX into their own drivers.

    There's no great need in splitting, just the separate tune_chipset() 
functions for PIIX/MPIIX and the rest of the crowd would suffice, IMHO...

MBR, Sergei
