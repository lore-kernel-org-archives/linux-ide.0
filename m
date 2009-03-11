From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: add support for CFA specified transfer modes (take
 3)
Date: Wed, 11 Mar 2009 20:49:42 +0300
Message-ID: <49B7F9B6.8060409@ru.mvista.com>
References: <200903102242.58158.sshtylyov@ru.mvista.com> <200903111735.40517.bzolnier@gmail.com> <49B7EFE2.3010806@ru.mvista.com> <200903111834.01712.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5582 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751342AbZCKRtE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Mar 2009 13:49:04 -0400
In-Reply-To: <200903111834.01712.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, stf_xl@wp.pl

Bartlomiej Zolnierkiewicz wrote:

>>>>Add support for the CompactFlash specific PIO modes 5/6 and MWDMA modes 3/4.

>>>>Since there were no PIO5 capable hard drives produced and one would also need
>>>>66 MHz IDE clock to actually get the difference WRT the address setup timings
>>>>programmed, I decided to simply replace the old non-standard PIO mode 5 timings
>>>>with the CFA specified ones.

>>>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>>>---
>>>>Changes since the previous take:
>>>>- added check for CFA modes to 'sl82c105' driver;
>>>>- added identify word 163 copying to ide_driveid_update();
>>>>- made change based on just posted ide_config_drive_speed() fixlet...
>>
>>>applied fixing checkpatch.pl complaint while at it:

>>>ERROR: space prohibited after that open parenthesis '('
>>>#199: FILE: drivers/ide/sl82c105.c:64:
>>>+       if ( (pio > 2 || ata_id_has_iordy(drive->id)) && ]

>>    Sigh, that one was done on purpose... :-]

>>>>--- linux-2.6.orig/drivers/ide/sl82c105.c
>>>>+++ linux-2.6/drivers/ide/sl82c105.c
>>>>@@ -61,7 +61,8 @@ static unsigned int get_pio_timings(ide_
>>>>	if (cmd_off == 0)
>>>>		cmd_off = 1;
>>>>
>>>>-	if (pio > 2 || ata_id_has_iordy(drive->id))
>>>>+	if ( (pio > 2 || ata_id_has_iordy(drive->id)) &&
>>>>+	    !(pio > 4 && ata_id_is_cfa(drive->id)))
>>>>		iordy = 0x40;

>>>I guess that it would later make sense to abstract this code into
>>>ata_id_needs_iordy(id, pio) helper +

>>    Er, if we can't reuse libata's stuff, I'd prefer to put this into 

> We can't reuse libata's ata_pio_need_iordy() since it resides in
> libata-core.c and also checks controller's capabilities.

>><linux/ide.h> as ide_dev_use_iordy()...

> Also fine with me, though I see no reason why not to move it to
> <linux/ata.h> so libata guys can use it inside ata_pio_need_iordy().

    Ah, I was too IDE-centric and thought that if they already have the needed 
logic, then why care about them... :-D

> Thanks,
> Bart

WBR, Sergei
