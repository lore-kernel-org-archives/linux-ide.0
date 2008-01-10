From: Tejun Heo <htejun@gmail.com>
Subject: Re: [CALL-FOR-HELP] pata_ali: can't get MWDMA working!
Date: Thu, 10 Jan 2008 10:39:43 +0900
Message-ID: <4785775F.9040300@gmail.com>
References: <4784FBC1.7070804@gmail.com> <200801092355.34934.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.181]:60454 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402AbYAJBjw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 20:39:52 -0500
Received: by ro-out-1112.google.com with SMTP id p4so549914roc.5
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 17:39:51 -0800 (PST)
In-Reply-To: <200801092355.34934.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>, andre@linux-ide.org

Hello,

Bartlomiej Zolnierkiewicz wrote:
>> I wondered whether the device was configured differently, so compared
>> hdparm --Istdout results.  They were identical too. (attached)
> 
> ATA device, with non-removable media
>         Model Number:       IC25N040ATMR04-0
>         Serial Number:      MRG208K2K3A37H
>         Firmware Revision:  MO2OAD5A

Eeek.  sorry about that.  Correct one...

/dev/sr0:

ATAPI CD-ROM, with removable media
        Model Number:       HL-DT-STCD-RW/DVD DRIVE GCC-4241N
        Serial Number:
        Firmware Revision:  0C29
Standards:
        Likely used CD-ROM ATAPI-1
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(can be disabled)
        DMA: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
HW reset results:
        CBLID- below Vih
        Device num = 0 determined by CSEL

/dev/sr0:
85c0 0000 0000 0000 0000 0000 0000 0000
0000 0000 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 0000 0000 0000 3043
3239 2020 2020 484c 2d44 542d 5354 4344
2d52 572f 4456 4420 4452 4956 4520 4743
432d 3432 3431 4e20 2020 2020 2020 0000
0000 0f00 0000 0200 0200 0002 0000 0000
0000 0000 0000 0000 0000 0000 0007 0407
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
003c 0013 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 404d 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 fffe 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

> Could you also send hdparm output for ATAPI device?  Does it use CDB intr?
> 
>> I walked through IDE and libata codes and found some differences in the
>> order registers are accessed and which values are written (e.g. libata
>> never turns on device 0/1 DMA capable bits in BMDMA status register
>> while IDE does).  I made them access the registers in the same order and
>> write the same values.  Still no go.
>>
>> Then, I made libata probing sequence very close to IDE such that no
>> reset is performed and NIEN isn't tempered with.  No go.
>>
>> I thought maybe the drive should just be blacklisted.  I took the laptop
>> apart, took out the DVD combo drive to ICH7 ata_piix.  It works just fine.
>>
>> So, I'm out of ideas at this point.  Any suggestions?  Ideas?
> 
> If ATAPI device uses CDB intr then ->irq_clear will be called by
> ata_host_intr() on CDB IRQ and may confuse DMA engine (it shouldn't
> on most chipsets but older ALi-s are pretty weird)...?

Unfortunately no CDB intr.

Thanks.

-- 
tejun
