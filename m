From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: eighty_ninty_three
Date: Thu, 22 Sep 2005 11:36:20 +0200
Message-ID: <58cb370e05092202364ddf0e5f@mail.gmail.com>
References: <ed723e8205092200315d6d1f2a@mail.gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.203]:49613 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030239AbVIVJgX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Sep 2005 05:36:23 -0400
Received: by nproxy.gmail.com with SMTP id x37so26962nfc
        for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2005 02:36:20 -0700 (PDT)
In-Reply-To: <ed723e8205092200315d6d1f2a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jayakumar ide <jayakumar.ide@gmail.com>
Cc: linux-ide@vger.kernel.org

On 9/22/05, jayakumar ide <jayakumar.ide@gmail.com> wrote:
> quick question:
>
> 598 /*
> 599  *  All hosts that use the 80c ribbon must use!
> 600  *  The name is derived from upper byte of word 93 and the 80c ribbon.
> 601  */
> 602 u8 eighty_ninty_three (ide_drive_t *drive)
> 603 {
> 604         if(HWIF(drive)->udma_four == 0)
> 605                 return 0;
> 606         if (!(drive->id->hw_config & 0x6000))
> 607                 return 0;
> 608 #ifndef CONFIG_IDEDMA_IVB
> 609         if(!(drive->id->hw_config & 0x4000))
> 610                 return 0;
> 611 #endif /* CONFIG_IDEDMA_IVB */
> 612         return 1;
> 613 }
>
> does that mean that 893() will return 0 if the drive is not udma4

No, hwif->udma_four is 1 if host detects 80-wires cable
(0 otherwise except when forced by "ide?=ata66" kernel parameter).

> capable? what's the rest of the stuff about 0x6000 and 0x4000? i took
> a quick look at a diamondmax spec and it says:
>
> http://www.maxtor.com/_files/maxtor/en_us/documentation/manuals/diamondmax_plus_9_manual.pdf
>
> Word 93 Hardware reset result. The contents of bits (12:0) of this
> word shall change only
> during the execution of a hardware reset
> 15: Shall be cleared to zero.
> 14: Shall be set to one.
> 13: 1 = device detected CBLID- above ViH. 0 = device detected CBLID- below
> ViL
> 12-8: Device 1 hardware reset result. Device 0 shall clear these bits to zero.
> Device shall set these bits as follows:
> 12: Reserved.
> 11: 0 = Device 1 did not assert PDIAG
>
> So I'm not sure I understand what the 0x6000 and 0x4000 check does. I

Drive side cable detection, some older drives get it wrong.

> was kind of hoping it would be some way to detect whether the cable
> was 40 core or 80 core. The reason I'm asking is because I'm trying to
> figure out the appropriate usage for eighty_ninty_three, ratemask and
> ide_rate_filter. I think I should call eighty93 in ratemask() and then
> use that to decide what the maximum mode should be. so if eighty93
> returned 0, then I would set max mode to 3 if my device spec claimed
> it was UDMA66 0-4 capable. Actually, I'm not sure about the UDMA66 0-4

Values returned by ->ratemask() are of internal use of IDE layer
so for UDMA66 capable host (not device!) ->ratemask() should return
2 if eighty_ninty_three() returns true and 1 otherwise.

Could you explain what exactly are you trying to do?

> stuff. I haven't yet understood the relationship between the
> XFER_UDMA_n and the UDMA/33/66/100 0-4 modes. If anyone has advice,
> I'm all ears.

XFER_UDMA_n is used for SETFEATURES command
(which is described in ATA spec - http://www.t13.org).

Bartlomiej
