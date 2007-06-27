From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/6] ide: add ata_dev_has_iordy() helper
Date: Thu, 28 Jun 2007 00:28:42 +0400
Message-ID: <4682C87A.2040709@ru.mvista.com>
References: <200706232005.10968.bzolnier@gmail.com> <200706240009.49033.bzolnier@gmail.com> <467EA1CB.8000800@ru.mvista.com> <200706272102.33989.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:55174 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756228AbXF0U06 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Jun 2007 16:26:58 -0400
In-Reply-To: <200706272102.33989.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>>>Index: b/drivers/ide/pci/sl82c105.c
>>>>>===================================================================
>>>>>--- a/drivers/ide/pci/sl82c105.c
>>>>>+++ b/drivers/ide/pci/sl82c105.c
>>>>>@@ -52,9 +52,10 @@
>>>>> * Convert a PIO mode and cycle time to the required on/off times
>>>>> * for the interface.  This has protection against runaway timings.
>>>>> */
>>>>>-static unsigned int get_pio_timings(ide_pio_data_t *p)
>>>>>+static unsigned int get_pio_timings(ide_drive_t *drive, ide_pio_data_t *p)
>>>>>{
>>>>>	unsigned int cmd_on, cmd_off;
>>>>>+	u8 iordy = 0;

>>>>>	cmd_on  = (ide_pio_timings[p->pio_mode].active_time + 29) / 30;
>>>>>	cmd_off = (p->cycle_time - 30 * cmd_on + 29) / 30;
>>>>>@@ -65,7 +66,10 @@ static unsigned int get_pio_timings(ide_
>>>>>	if (cmd_off == 0)
>>>>>		cmd_off = 1;

>>>>>-	return (cmd_on - 1) << 8 | (cmd_off - 1) | (p->use_iordy ? 0x40 : 0x00);
>>>>>+	if (p->pio_mode > 2 || ata_dev_has_iordy(drive->id))
>>>>>+		iordy = 0x40;

>>>>   This logic, although mimicking the old one from ide_get_best_pio_mode(), 
>>>>is not quite correct. As have been noted before, when you set a PIO mode using 

>>    It was actully correct enough, just superfluous -- it was me who was 
>>incorrect, mistaking || for &&. :-<

> After checking with ATA-2 spec I would prefer to leave extra p->pio_mode > 2
> check (if ata_dev_has_iordy() fails device still _may_ support IORDY).

    Indeed, it may... BUT it may not support PIO > 2 (since this also requires 
the "IORDY supported"  bit set).

> Fixed in "take 3" of the patch.

>>>>Set Transfer Mode subcode of the Set Features command, you're always selecting 
>>>>the flow control mode, i.e. using IORDY. So, the last condition in this if 

>>    So, what actually would need fixing in *all* the drivers if one was aiming 
>>at ATA-1 compatibility is *not* issuing that subcommand to such drives...

> I was actually thinking about a different way of fixing this:

> - remove 0x08 bit from XFER_PIO_[0,6] defines and add new XFER_PIO_IORDY
>   define (<linux/ata.h>)

    Nah, that wouldn't match to the ATA definition of these values.

> - check for speed == XFER_PIO_[0,6] in ide-lib.c::ide_config_drive_speed()

    It's in ide-iops.c. ;-)

>   and pmac.c::pmac_ide_do_setfeature(), add XFER_PIO_IORDY if needed

    And what, just pass the mode thru to the Set Features if there's no IORDY 
support?  That would be bogus since there are just *no* subcodes to set the 
specific mode below 0x08 -- the only defined subcodes are 0x00 (set default 
mode), and 0x01 (set default mode w/o IORDY).
    I was thinking of checking if the drive really supports IORDY before 
issuing a command to set PIO mode (and just skipping the command if there's no 
IORDY -- well, maybe adding an extra check that the passed mode is acceptable 
to the drive, i.e. <= its default one).  Should be quite simple to do.

> This should be done together with fixing these host drivers that don't
> handle IORDY properly.

    Erm, not necessarily...

>>>Oh yes, I keep forgetting about it - some nice FIXME comment
>>>in <linux/ata.h> would be of a great help. :-)

>>    Well, some drivers (like pdc202xx_*) don't do the IORDY thing right for 
>>PIO modes < 3 as well...

> Added to the existing IDE TODO at

> 	http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/TODO

> Patches adding/removing items are welcomed.

> Patches fixing actual issues are welcomed even more.

    Sigh, I'm trying to get some time (more like time slices :-) off to deal 
with my own issues...

>>>>stmt should probably be the first, if not the sole one...

>>>Fixed, new patch below.

>>>[PATCH] ide: add ata_dev_has_iordy() helper (take 2)

>>>* Add ata_dev_has_iordy() helper and use it sl82c105 host driver.

>>>* Remove no longer needed ide_pio_data_t.use_iordy field.

>>>v2:
>>>* Fix issues noticed by Sergei:
>>>  - correct patch description
>>>  - remove stale comment from ide_get_best_pio_mode()

>>    I meant something like changing use_iordy to IORDY but it's good as is now...

> Corrected in "take 3".

    Thanks.

> [PATCH] ide: add ata_dev_has_iordy() helper (take 3)

> * Add ata_dev_has_iordy() helper and use it sl82c105 host driver.

> * Remove no longer needed ide_pio_data_t.use_iordy field.

> v2/v3:
> * Fix issues noticed by Sergei:
>   - correct patch description
>   - fix comment in ide_get_best_pio_mode()

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
