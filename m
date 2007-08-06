From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: move ide_config_drive_speed() calls to upper layers
Date: Mon, 06 Aug 2007 21:43:37 +0400
Message-ID: <46B75DC9.3040001@ru.mvista.com>
References: <200707270222.28230.bzolnier@gmail.com> <46AC87F8.7050508@ru.mvista.com> <200708040101.44106.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:10974 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753626AbXHFRlf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 13:41:35 -0400
In-Reply-To: <200708040101.44106.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello again. :-)

Bartlomiej Zolnierkiewicz wrote:

>>>* Add ide_set_pio_mode()/ide_set_dma_mode() helpers and convert all
>>>  direct ->set_pio_mode/->speedproc users to use these helpers.

>>>* Move ide_config_drive_speed() calls from ->set_pio_mode/->speedproc
>>>  methods to callers.

>>>* Rename ->speedproc method to ->set_dma_mode, make it void and update
>>>  all implementations accordingly.

>>>* Update ide_set_xfer_rate() comments.

>>>Except removal of two debugging printk-s (from cs5530.c and sc1200.c)
>>>and the fact that transfer modes 0x00-0x07 passed from user space may
>>>be programmed twice on the device (not really an issue since 0x00-0x01
>>>are handled by very few host drivers and 0x02-0x07 are simply invalid)
>>>there should be no other functionality changes caused by this patch.

>>    Haven't see any driver handling 0x01. 0x00 is usually handled by setting

    Maybe I haven't looked too hard though... :-)

>>>Index: b/drivers/ide/ide-lib.c
>>>===================================================================
>>>--- a/drivers/ide/ide-lib.c
>>>+++ b/drivers/ide/ide-lib.c
>>>@@ -349,7 +349,7 @@ void ide_set_pio(ide_drive_t *drive, u8 
[...]
>>>+
>>>+	/*
>>>+	 * TODO: temporary hack for some legacy host drivers that didn't
>>>+	 * set transfer mode on the device in ->set_pio_mode method...
>>>+	 */
>>>+	if (hwif->set_dma_mode == NULL) {
>>>+		hwif->set_pio_mode(drive, mode - XFER_PIO_0);
>>>+		return 0;
>>>+	}

>>    Er... I didn't quite get it. :-/
>>    You mean those that are still unfixed WRT not calling
>>ide_config_drive_speed()?

> Yes.

    Ah, so you're emulating the current behaviour with this...

>>>+
>>>+	if (hwif->host_flags & IDE_HFLAG_POST_SET_MODE) {
>>>+		if (ide_config_drive_speed(drive, mode))
>>>+			return -1;
>>>+		hwif->set_pio_mode(drive, mode - XFER_PIO_0);
>>>+		return 0;
>>>+	} else {
>>>+		hwif->set_pio_mode(drive, mode - XFER_PIO_0);
>>>+		return ide_config_drive_speed(drive, mode);
>>>+	}
>>>+}
>>>+
>>>+int ide_set_dma_mode(ide_drive_t *drive, const u8 mode)
>>>+{
>>>+	ide_hwif_t *hwif = drive->hwif;
>>>+
>>>+	if (hwif->host_flags & IDE_HFLAG_NO_SET_MODE)
>>>+		return 0;

>>    I suggest that this be replaced by:

>>	if (hwif->set_dma_mode == NULL)
>>		return -1;

> Done.

> This alone would make ide_tune_dma() fail on it821x in smart mode
> but moving IDE_HFLAG_NO_SET_MODE checking there fixes the issue.

    Ah, I hadn't thought about all the consequencies... :-)

>>>+	if (hwif->host_flags & IDE_HFLAG_POST_SET_MODE) {
>>>+		if (ide_config_drive_speed(drive, mode))
>>>+			return -1;
>>>+		hwif->set_dma_mode(drive, mode);
>>>+		return 0;
>>>+	} else {
>>>+		hwif->set_dma_mode(drive, mode);
>>>+		return ide_config_drive_speed(drive, mode);
>>>+	}
>>>+}
>>>+
>>> /**
>>>  *	ide_set_xfer_rate	-	set transfer rate
>>>  *	@drive: drive to set
>>>- *	@speed: speed to attempt to set
>>>+ *	@rate: speed to attempt to set
>>>  *	
>>>  *	General helper for setting the speed of an IDE device. This
>>>  *	function knows about user enforced limits from the configuration
>>>- *	which speedproc() does not.  High level drivers should never
>>>- *	invoke speedproc() directly.
>>>+ *	which ->set_pio_mode/->set_dma_mode does not.
>>>  */
>>>- 
>>>+
>>> int ide_set_xfer_rate(ide_drive_t *drive, u8 rate)
>>> {
>>> 	ide_hwif_t *hwif = drive->hwif;
>>> 
>>>-	if (hwif->speedproc == NULL)
>>>+	if (hwif->set_dma_mode == NULL)
>>> 		return -1;
>>> 
>>> 	rate = ide_rate_filter(drive, rate);
>>> 
>>> 	if (rate >= XFER_PIO_0 && rate <= XFER_PIO_5) {
>>> 		if (hwif->set_pio_mode)

>>    Won't be needed if we'll check it inside ide_set_pio_mode().

>>>-			hwif->set_pio_mode(drive, rate - XFER_PIO_0);
>>>+			return ide_set_pio_mode(drive, rate);
>>> 
>>>-		/*
>>>-		 * FIXME: this is incorrect to return zero here but
>>>-		 * since all users of ide_set_xfer_rate() ignore
>>>-		 * the return value it is not a problem currently
>>>-		 */
>>>-		return 0;
>>>+		return -1;
>>> 	}
>>> 
>>>-	return hwif->speedproc(drive, rate);
>>>+	/*
>>>+	 * TODO: transfer modes 0x00-0x07 passed from the user-space are
>>>+	 * currently handled here which needs fixing (please note that such
>>>+	 * case could happen iff the transfer mode has already been set on
>>>+	 * the device by ide-proc.c::set_xfer_rate()).
>>>+	 */

>>    Would be quite easy to hook and *properly* handle mode 0x00 here, however
>>mode 0x01 would certainly be much trickier -- unless we'd want to delegate it
>>to set_pio_mode() itself (I'm not suggesting it though :-)...

> We do want (patches are welcomed).  :-)

    Erm, actually the preferrable way would be to handle 0x00/0x01 in some 
generic manner -- and I was talking about the drivers' set_pio_mode() methods.

> Handling 0x00 properly in ide_set_pio()/ide_set_pio_mode() would allow us to
> handle non-IORDY devices correctly without resorting to special hacks.

    Handling 0x01 correctly would be quite a hack in itself. :-)

>>>Index: b/drivers/ide/pci/piix.c
>>>===================================================================
>>>--- a/drivers/ide/pci/piix.c
>>>+++ b/drivers/ide/pci/piix.c
>>
>>[...]
>>
>>>@@ -288,9 +273,7 @@ static int piix_tune_chipset(ide_drive_t
>>> 			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
>>> 	}
>>> 
>>>-	piix_tune_pio(drive, piix_dma_2_pio(speed));
>>>-
>>>-	return ide_config_drive_speed(drive, speed);
>>>+	piix_set_pio_mode(drive, piix_dma_2_pio(speed));

>>    Hm, I remember some earlier patches which have changed this code...

> Earlier patches removed *_dma_2_pio() calls for PIO modes.

> I'll post patches to completely remove *_ dma_2_pio() shortly.

    Well, you have, and that patch looked half-baked to me. ;-)

>>>Index: b/drivers/ide/ppc/pmac.c
>>>===================================================================
>>>--- a/drivers/ide/ppc/pmac.c
>>>+++ b/drivers/ide/ppc/pmac.c

>>[...]

>>>@@ -1143,7 +1130,8 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
>>> 	hwif->cbl = pmif->cable_80 ? ATA_CBL_PATA80 : ATA_CBL_PATA40;
>>> 	hwif->drives[0].unmask = 1;
>>> 	hwif->drives[1].unmask = 1;
>>>-	hwif->host_flags = IDE_HFLAG_SET_PIO_MODE_KEEP_DMA;
>>>+	hwif->host_flags = IDE_HFLAG_SET_PIO_MODE_KEEP_DMA |
>>>+			   IDE_HFLAG_POST_SET_MODE,

>>    Er... have you tried to compile this before posting? ;-)

> This?  No. ;-)

> Fixed.

> [PATCH] ide: move ide_config_drive_speed() calls to upper layers (take 2)

> * Convert {ide_hwif_t,ide_pci_device_t}->host_flag to be u16.

> * Add IDE_HFLAG_POST_SET_MODE host to indicate the need to program the
>   host for the transfer mode after programming the device.  Set it in
>   au1xxx-ide, amd74xx, cs5530, cs5535, pdc202xx_new, sc1200, pmac and
>   via82cxxx host drivers.

> * Add IDE_HFLAG_NO_SET_MODE host flags to indicate the need to completely
>   skip programming of host/device for the transfer mode ("smart" hosts).
>   Set it in it821x host driver and check it in ide_tune_dma().

> * Add ide_set_pio_mode()/ide_set_dma_mode() helpers and convert all
>   direct ->set_pio_mode/->speedproc users to use these helpers.

> * Move ide_config_drive_speed() calls from ->set_pio_mode/->speedproc
>   methods to callers.

> * Rename ->speedproc method to ->set_dma_mode, make it void and update
>   all implementations accordingly.

> * Update ide_set_xfer_rate() comments.

> * Unexport ide_config_drive_speed().

> v2:
> * Fix issues noticed by Sergei:
>   - export ide_set_dma_mode() instead of moving ->set_pio_mode abuse wrt
>     to setting DMA modes from sc1200_set_pio_mode() to do_special()
>   - check IDE_HFLAG_NO_SET_MODE in ide_tune_dma()
>   - check for (hwif->set_pio_mode) == NULL in ide_set_pio_mode()
>   - check for (hwif->set_dma_mode) == NULL in ide_set_dma_mode()
>   - return -1 from ide_set_{pio,dma}_mode() if ->set_{pio,dma}_mode == NULL
>   - don't set ->set_{pio,dma}_mode on it821x in "smart" mode
>   - fix build problem in pmac.c
>   - minor fixes in au1xxx-ide.c/cs5530.c/siimage.c
>   - improve patch description

> Changes in behavior caused by this patch:
> - HDIO_SET_PIO_MODE ioctl would now return -ENOSYS for attempts to change
>   PIO mode if it821x controller is in "smart" mode
> - removal of two debugging printk-s (from cs5530.c and sc1200.c)
> - transfer modes 0x00-0x07 passed from user space may be programmed twice on
>   the device (not really an issue since 0x00 is not supported correctly by
>   any host driver ATM, 0x01 is not supported et all and 0x02-0x07 are invalid)

    Erm, may I insert a grammatical nit here? :-)
    It's either "at all" or "et al." (meaning something completely different) 
and your hybrid variant would mean "and all" if we treat "et" as a Latin word 
(well, it's certainly not an Emglish word anyway ;-)...

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
