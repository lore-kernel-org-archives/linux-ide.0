From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 9/15] ide: add PIO masks
Date: Wed, 04 Jul 2007 00:35:07 +0400
Message-ID: <468AB2FB.70600@ru.mvista.com>
References: <200706302107.42458.bzolnier@gmail.com> <468AA351.4090509@ru.mvista.com> <200707032208.13580.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [63.81.120.155] ([63.81.120.155]:25980 "EHLO imap.sh.mvista.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756603AbXGCUd0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 16:33:26 -0400
In-Reply-To: <200707032208.13580.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Bartlomiej Zolnierkiewicz wrote:

>>>* Add ATA_PIO[0-6] defines to <linux/ata.h>.

>>>* Add ->pio_mask field to ide_pci_device_t and ide_hwif_t.

>>>* Add PIO masks to host drivers.

>>>Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

>>   Not sure if my ACK applies now...

>>>Index: b/drivers/ide/pci/jmicron.c
>>>===================================================================
>>>--- a/drivers/ide/pci/jmicron.c
>>>+++ b/drivers/ide/pci/jmicron.c
>>>@@ -180,6 +180,7 @@ fallback:
>>> 		.autodma	= AUTODMA,		\
>>> 		.bootable	= ON_BOARD,		\
>>> 		.enablebits	= { {0x40, 1, 1}, {0x40, 0x10, 0x10} }, \
>>>+		.pio_mask	= ATA_PIO5,		\
>>> 	}

>>    Just noticed that this driver does nothing in its tuneproc() method. So, 
>>this mask is unrealistic. The method needs to be dropped for now along with 

> Adding ->pio_mask doesn't change the old behavior in _any_ way.

    Of course not. That's why I didn't NAK. :-)

>>config-jmicron_chipset_for_pio() -- ptobably, with FIXME added.

> Please see comments for jmicron_tune_chipset(), ->tuneproc just misses

    Ah, the case of overly smart chipset!

> setting transfer mode on the device.  Care to send a patch fixing it?

    I don't care about JMicron, so only when/if I'll find some time...

> Thanks,
> Bart

WBR, Sergei
