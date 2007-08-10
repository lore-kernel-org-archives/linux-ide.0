From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/11] au1xxx-ide: use ide_tune_dma()
Date: Fri, 10 Aug 2007 23:11:38 +0400
Message-ID: <46BCB86A.1010107@ru.mvista.com>
References: <200708042206.57529.bzolnier@gmail.com> <46B764EF.9000506@ru.mvista.com> <200708090057.13155.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:57350 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752697AbXHJTJ1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Aug 2007 15:09:27 -0400
In-Reply-To: <200708090057.13155.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>    Good, that's what I lacked for hpt366.c!  Were you planning to push it to 
>>Linus soon?

> Not really but if needed I will extract MWDMA filter part and push it sooner.

    Erm, may I just merge it to my patch (mentioning you of course)?

>>>* Add ->mdma_filter to ide_hwif_t and use it in ide_get_mode_mask().

>>    Hm, why not mwdma_filter()?  That "mdma" word has unneeded connotation. ;-)

> Ha!  As predicted:

> ->mdma_filter name would make people more ecstatic about the code

> ;)

    Nice one. 8-)

>>>* Remove needless setting of drive->using_dma from auide_dma_check().

>>>* Split off auide_mdma_filter() from auide_dma_check().

>>>* Use ide_tune_dma() in auide_dma_check(), this fixes following issues:
>>>  - device's DMA capability bit not being checked
>>>  - device not being checked against generic DMA blacklist
>>>  - transfer mode not being set on device/host

>>>* Add PIO autotune fallback to auide_dma_check().

>>>Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

>>>Index: b/drivers/ide/mips/au1xxx-ide.c
>>>===================================================================
>>>--- a/drivers/ide/mips/au1xxx-ide.c
>>>+++ b/drivers/ide/mips/au1xxx-ide.c
>>>@@ -351,11 +351,18 @@ static int auide_dma_setup(ide_drive_t *
>>> 	return 0;
>>> }
>>> 
>>>-static int auide_dma_check(ide_drive_t *drive)
>>>+static u8 auide_mdma_filter(ide_drive_t *drive)
>>> {
>>>-	u8 speed = ide_max_dma_mode(drive);
>>>+	/*
>>>+	 * FIXME: ->white_list and ->black_list are based on completely bogus
>>>+	 * ->ide_dma_check implementation which didn't set neither the host
>>>+	 * controller timings nor the device for the desired transfer mode.
>>>+	 *
>>>+	 * They should be either removed or 0x00 MWDMA mask should be
>>>+	 * returned for devices on the ->black_list.
>>>+	 */

>>    I don't get it -- why then introduce a method that does nothing?

> It does something as you've noticed yourself:

    Yeah, I saw that it does something that shouldn't be done there. :-)
The more is the reason to move that method into my recent hpt366 filter patch.

>>>-	if( dbdma_init_done == 0 ){
>>>+	if (dbdma_init_done == 0) {

>>    I wonder what this code is doing here at all...

>>> 		auide_hwif.white_list = ide_in_drive_list(drive->id,
>>> 							  dma_white_list);
>>> 		auide_hwif.black_list = ide_in_drive_list(drive->id,

>>    Why the results of the drive list lockup gets tied to auide_hwif? :-O

    Yet I was sure I'd typed "lookup". Probably a freudian slip. :-)

> To use results in auide_ddma_init()...  (which needs fixing of course).

> The more interesting questions are: WTF is "safe MWDMA" mode (tsize == 1,
> devwidth == 16) and whether ->white/black_list is really needed.

    No time to look into the manuals right now...

> I planned to cc: AU1XXX platform maintainers on this patch but to my
> surprise MAINTAINERS lacks AU1XXX entry.

    It's been solt out to Raza Microelectronics last year and those guys never
sent a single patch to linux-mips...

> Bart

MBR, Sergei
