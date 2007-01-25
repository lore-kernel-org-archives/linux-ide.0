From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] ide: clear bmdma status in ide_intr() (revised)
Date: Thu, 25 Jan 2007 19:40:36 +0300
Message-ID: <45B8DD84.3090700@ru.mvista.com>
References: <45AF57BE.7060505@tw.ibm.com>	 <58cb370e0701191133m3dd584ffna5b231b00392c13d@mail.gmail.com>	 <45B12318.9000704@gmail.com> <45B467A9.6040404@tw.ibm.com>	 <45B479C2.7090300@tw.ibm.com> <58cb370e0701220805i783dddafse768e500b27fff36@mail.gmail.com> <45B6D386.3030104@tw.ibm.com> <45B6D5A7.6080700@tw.ibm.com> <45B7596F.6080504@ru.mvista.com> <45B878F0.7060707@tw.ibm.com> <45B8CA02.4050701@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:1880 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030304AbXAYQkl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2007 11:40:41 -0500
In-Reply-To: <45B8CA02.4050701@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, "Adam W. Hawks" <awhawks@us.ibm.com>

Hello.

Sergei Shtylyov wrote:

>> diff -Nrup 01_remove_from_ide_cd/drivers/ide/ide-cd.c 02_add_to_ide_intr/drivers/ide/ide-cd.c
>> --- 01_remove_from_ide_cd/drivers/ide/ide-cd.c    2007-01-24 11:00:03.000000000 +0800
>> +++ 02_add_to_ide_intr/drivers/ide/ide-cd.c    2007-01-25 16:52:20.000000000 +0800
>> @@ -923,6 +923,10 @@ static ide_startstop_t cdrom_start_packe
>>          HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
>>        if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
>> +        /* waiting for CDB interrupt, not DMA yet. */
>> +        if (info->dma)
>> +            drive->waiting_for_dma = 0;
>> +
>>          /* packet command */
>>          ide_execute_command(drive, WIN_PACKETCMD, handler, ATAPI_WAIT_PC, cdrom_timer_expiry);
>>          return ide_started;
>> @@ -965,6 +969,10 @@ static ide_startstop_t cdrom_transfer_pa
>>          /* Check for errors. */
>>          if (cdrom_decode_status(drive, DRQ_STAT, NULL))
>>              return ide_stopped;
>> +
>> +        /* Ok, next interrupt will be dma interrupt. */
>> +        if (info->dma)
>> +            drive->waiting_for_dma = 1;
>>      } else {
>>          /* Otherwise, we must wait for DRQ to get set. */
>>          if (ide_wait_stat(&startstop, drive, DRQ_STAT,

>    Erm... shouldn't we set drive->waiting_for_dma in hwif->dma_start() 
> then?  Why it's set in hwif->dma_setup() at all I wonder?

    Well, it'll become raicy as well then... Isn't it ugly. :-/

MBR, Sergei
