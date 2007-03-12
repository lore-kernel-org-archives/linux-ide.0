From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/13] siimage: fix wrong ->swdma_mask
Date: Mon, 12 Mar 2007 16:19:03 +0300
Message-ID: <45F55347.6090301@ru.mvista.com>
References: <200703102212.49447.bzolnier@gmail.com> <45F3219C.5040500@ru.mvista.com> <200703102337.47122.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:59682 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965380AbXCLNTM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 09:19:12 -0400
In-Reply-To: <200703102337.47122.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>[PATCH] siimage: fix wrong ->swdma_mask

>>>This driver doesn't support SWDMA so use the correct ->swdma_mask.

>>>While at it:

>>>* no need to call config_chipset_for_pio() in config_chipset_for_dma(),
>>>  if DMA is not available config_chipset_for_pio() will be called
>>>  by siimage_config_drive_for_dma() and if DMA is available
>>>  config_siimage_chipset_for_pio() will be called by siimage_tune_chipset()

>>    Ugh, this driver has such a messy code PIO-wise!  There seems to be 
>>completely no point in calling config_siimage_chipset_for_pio() from 
>>siimage_tune_chipset().  Not mentioning that tuneproc() method fails to 
>>actually control IORDY (it only twiddles IORDY bits for taskfile access). Ah, 
>>and tuneproc() fails to set the drive's own mode (as usual)... :-)

    Oh, I knew I was going to forget something: it's also limiting the PIO 
mode to the one of the slowest drive for no good reason. :-/

>>    I was going to post patches but then figured out that we don't actually 
>>support this driver, so the priority has significatly dropped. :-)

> Does it mean that I should expect more patches for other drivers? ;-)

    Certainly. We're just having a release fever, so I had to switch to fixing 
the stupid network drivers (where the breakage wasn't so obvious).

> If so I could take care of this one... :-)

    Please do. :-)

> Bart

MBR, Sergei
