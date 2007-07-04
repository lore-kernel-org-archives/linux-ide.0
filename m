From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 9/15] ide: add PIO masks
Date: Wed, 04 Jul 2007 18:24:23 +0400
Message-ID: <468BAD97.2030904@ru.mvista.com>
References: <200706302107.42458.bzolnier@gmail.com>	<468AA351.4090509@ru.mvista.com> <20070703230034.233d0d7e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:31785 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758850AbXGDOW2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jul 2007 10:22:28 -0400
In-Reply-To: <20070703230034.233d0d7e@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hello.

Alan Cox wrote:
>>> 		.bootable	= ON_BOARD,		\
>>> 		.enablebits	= { {0x40, 1, 1}, {0x40, 0x10, 0x10} }, \
>>>+		.pio_mask	= ATA_PIO5,		\
>>> 	}
>>
>>    Just noticed that this driver does nothing in its tuneproc() method. So, 
>>this mask is unrealistic. The method needs to be dropped for now along with 
>>config-jmicron_chipset_for_pio() 

> It doesn't need to do anything. 

    Not true. It should call ide_config_drive_speed() at least, else PIO 
autotuning won't actually work.

MBR, Sergei
