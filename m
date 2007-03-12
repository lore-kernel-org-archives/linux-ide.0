From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 10/13] sl82c105: add ->speedproc support
Date: Mon, 12 Mar 2007 16:13:09 +0300
Message-ID: <45F551E5.8010904@ru.mvista.com>
References: <200703102209.59918.bzolnier@gmail.com> <45F32860.8040901@ru.mvista.com> <200703102332.12716.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:59660 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965850AbXCLNNT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 09:13:19 -0400
In-Reply-To: <200703102332.12716.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>Hello.

>>Bartlomiej Zolnierkiewicz wrote:

>>>[PATCH] sl82c105: add ->speedproc support

>>>* add sl82c105_tunepio() wrapper for sl82c105_tune_drive()
>>>  (just to get the error value)

>>>* add sl82c105_tune_chipset() (->speedproc method) for setting
>>>  transfer mode

>>    Thanks for the patch!

>>  > Index: b/drivers/ide/pci/sl82c105.c

>>>===================================================================
>>>--- a/drivers/ide/pci/sl82c105.c
>>>+++ b/drivers/ide/pci/sl82c105.c
[...]
>>>@@ -91,7 +91,7 @@ static void sl82c105_tune_drive(ide_driv
>>> 	xfer_mode = ide_get_best_pio_mode(drive, pio, 5, &p) + XFER_PIO_0;
>>> 
>>> 	if (ide_config_drive_speed(drive, xfer_mode))
>>>-		return;
>>>+		return 1;
>>> 
>>> 	drive->drive_data = drv_ctrl = get_timing_sl82c105(&p);
>>> 
>>>@@ -114,17 +114,45 @@ static void sl82c105_tune_drive(ide_driv
>>> 	 */
>>> 	drive->io_32bit = 1;
>>> 	drive->unmask	= 1;
>>>+
>>>+	return 0;
>>>+}
>>>+
>>>+static void sl82c105_tune_drive(ide_drive_t *drive, u8 pio)
>>>+{
>>>+	/*
>>>+	 * TODO: find best PIO mode and set device speed here
>>>+	 *       (requires adding helper function for getting PIO cycle time)
>>>+	 */

>>   I thought we were doing it by calling ide_get_best_pio_mode() above...

> We are also using ide_get_best_pio_mode() to get PIO cycle time
> so we can't move it here ATM.

   I've found/used quite convenient workaround for that -- return PIO mode 
actually selected from xxx_tune_pio(), then call ide_config_drive_speed() from 
the real tuneproc() method.

>>>+	(void)sl82c105_tunepio(drive, pio);

>>    Erm, I thought afterwards that I vainly folded one into another. I think 
>>it's worth moving those io_32bit and unmask flag assignments above back 
>>there... May also recast my patch. :-)

> Moving them to ->init_hwif where they belong would be even better... ;-)

    Well, I wasn't sure where they belong... :-)
    So, OK to recast that patch?

>>>+static int sl82c105_tune_chipset(ide_drive_t *drive, u8 mode)
>>>+{
>>>+	mode = ide_rate_filter(drive, mode);
>>>+
>>>+	if (mode >= XFER_PIO_0 && mode <= XFER_PIO_5)
>>>+		return sl82c105_tunepio(drive, mode - XFER_PIO_0);
>>>+
>>>+	/*
>>>+	 * TODO: add MWDMA0/1 support
>>>+	 */
>>>+	BUG_ON(mode != XFER_MW_DMA_2);

>>    Well, the other drivers just return non-zero in this case...

> They are are buggy and need fixing.

    Ugh, that'll be a lot of fixing... :-)
    Why BUG on being passed unsupported mode from userspace though (when 
there's no filtering involved before that)?

> IDE driver itself should never ask for an unsupported mode and if user passes
> such through ->speedproc interface OOPSing is IMO better than possible data
> corruption.  On the second thought ide_rate_filter() takes care of filtering
> UDMA modes, so it may as well take care of filtering SWDMA/MWDMA/PIO and the
> problem will be solved in more gracefull way... but more work is needed...

    Yeah. :-)

> Thanks,
> Bart

MBR, Sergei
