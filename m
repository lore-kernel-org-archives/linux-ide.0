From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: porting IDE patches to PATA driver
Date: Fri, 03 Jul 2009 19:17:41 -0600
Message-ID: <4A4EADB5.6070609@gmail.com>
References: <323951117.20090625100956@web.de> <20090625092324.2dd4de5a@lxorguk.ukuu.org.uk> <14164712.20090625103834@web.de> <20090625100542.525dba02@lxorguk.ukuu.org.uk> <951976828.20090625123021@web.de> <20090625122958.510c28ad@lxorguk.ukuu.org.uk> <96179821.20090626152440@web.de> <20090626144639.4bc822b8@lxorguk.ukuu.org.uk> <792909512.20090626164052@web.de> <20090626172143.3fe6a59c@lxorguk.ukuu.org.uk> <596875090.20090629140157@web.de> <20090629155349.1574e492@lxorguk.ukuu.org.uk> <149127909.20090703115022@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:47643 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098AbZGDBQ2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Jul 2009 21:16:28 -0400
Received: by gxk26 with SMTP id 26so4237732gxk.13
        for <linux-ide@vger.kernel.org>; Fri, 03 Jul 2009 18:16:31 -0700 (PDT)
In-Reply-To: <149127909.20090703115022@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrei Martynov <andrei.martynov@web.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On 07/03/2009 03:50 AM, Andrei Martynov wrote:
> Monday, June 29, 2009, 4:53:49 PM, Alan Cox wrote:
>
>> The only other thing I can see is the way it hangs around waiting a bit
>> for the DMA to finish after the DMA completion event occurs - that might
>> be your problem if they goofed and reported DMA complete too early.
>
> Thank you very much for your advices. Reading from disk works fine now
> but writing attempt results in a series of similar error messages.
> What is the meaning of this error? Is there any documentation that may
> be useful to understand libata error messages?
>
> ~ # cp /hdd/c/Test/test.dat /hdd/d
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> ata1.00: BMDMA stat 0x6

BMDMA status 0x6 means DMA failed because the adapter encountered an 
error transferring data to/from host memory (from the PCI ATA host 
adapter spec). Some problem in the adapter setup?

> ata1.00: cmd 35/00:98:40:6f:fe/00:01:20:00:00/e0 tag 0 dma 208896 out
>           res 50/00:00:d7:70:fe/00:00:20:00:00/e0 Emask 0x20 (host bus error)
> ata1.00: status: { DRDY }
> jasper_set_piomode: devno = 0
> jasper_tune_chipset: slave = 0 speed = 0x0c
> jasper_set_dmamode: devno = 0
> jasper_tune_chipset: slave = 0 speed = 0x22
> ata1.00: configured for MWDMA2
> ata1: EH complete
> sd 0:0:0:0: [sda] 586070255 512-byte hardware sectors (300068 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> ata1.00: BMDMA stat 0x6
> ata1.00: cmd 35/00:a0:b0:72:fe/00:01:20:00:00/e0 tag 0 dma 212992 out
>           res 50/00:00:4f:74:fe/00:00:20:00:00/e0 Emask 0x20 (host bus error)
> ata1.00: status: { DRDY }
> jasper_set_piomode: devno = 0
> jasper_tune_chipset: slave = 0 speed = 0x0c
> jasper_set_dmamode: devno = 0
> jasper_tune_chipset: slave = 0 speed = 0x22
> ata1.00: configured for MWDMA2
> ata1: EH complete
>
>

