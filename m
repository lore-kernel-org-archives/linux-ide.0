From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/6] ide: add ata_dev_has_iordy() helper
Date: Sun, 24 Jun 2007 20:54:35 +0400
Message-ID: <467EA1CB.8000800@ru.mvista.com>
References: <200706232005.10968.bzolnier@gmail.com> <467D7652.7070105@ru.mvista.com> <200706240009.49033.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:18579 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750927AbXFXQwz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Jun 2007 12:52:55 -0400
In-Reply-To: <200706240009.49033.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>>* Use it in sl82c105 host driver so it always gets the correct info
>>>  (use_iordy was incorrectly set for "pio" != 255 cases).

>>    Hm, why incorrectly? ATA specs say PIO3/4 *must* use IORDY flow control, 
>>IIRC... :-/

    Moreover, it was me who added that! :-)

	use_iordy = (pio_mode > 2);

>>>Index: b/drivers/ide/pci/sl82c105.c
>>>===================================================================
>>>--- a/drivers/ide/pci/sl82c105.c
>>>+++ b/drivers/ide/pci/sl82c105.c
>>>@@ -52,9 +52,10 @@
>>>  * Convert a PIO mode and cycle time to the required on/off times
>>>  * for the interface.  This has protection against runaway timings.
>>>  */
>>>-static unsigned int get_pio_timings(ide_pio_data_t *p)
>>>+static unsigned int get_pio_timings(ide_drive_t *drive, ide_pio_data_t *p)
>>> {
>>> 	unsigned int cmd_on, cmd_off;
>>>+	u8 iordy = 0;

>>> 	cmd_on  = (ide_pio_timings[p->pio_mode].active_time + 29) / 30;
>>> 	cmd_off = (p->cycle_time - 30 * cmd_on + 29) / 30;
>>>@@ -65,7 +66,10 @@ static unsigned int get_pio_timings(ide_
>>> 	if (cmd_off == 0)
>>> 		cmd_off = 1;

>>>-	return (cmd_on - 1) << 8 | (cmd_off - 1) | (p->use_iordy ? 0x40 : 0x00);
>>>+	if (p->pio_mode > 2 || ata_dev_has_iordy(drive->id))
>>>+		iordy = 0x40;

>>    This logic, although mimicking the old one from ide_get_best_pio_mode(), 
>>is not quite correct. As have been noted before, when you set a PIO mode using 

    It was actully correct enough, just superfluous -- it was me who was 
incorrect, mistaking || for &&. :-<

>>Set Transfer Mode subcode of the Set Features command, you're always selecting 
>>the flow control mode, i.e. using IORDY. So, the last condition in this if 

    So, what actually would need fixing in *all* the drivers if one was aiming 
at ATA-1 compatibility is *not* issuing that subcommand to such drives...

> Oh yes, I keep forgetting about it - some nice FIXME comment
> in <linux/ata.h> would be of a great help. :-)

    Well, some drivers (like pdc202xx_*) don't do the IORDY thing right for 
PIO modes < 3 as well...

>>stmt should probably be the first, if not the sole one...

> Fixed, new patch below.

> [PATCH] ide: add ata_dev_has_iordy() helper (take 2)

> * Add ata_dev_has_iordy() helper and use it sl82c105 host driver.

> * Remove no longer needed ide_pio_data_t.use_iordy field.

> v2:
> * Fix issues noticed by Sergei:
>   - correct patch description
>   - remove stale comment from ide_get_best_pio_mode()

    I meant something like changing use_iordy to IORDY but it's good as is now...

>   - use only ata_dev_has_iordy() in sl82c105 host driver

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

