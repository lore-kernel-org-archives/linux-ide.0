From: jayakumar ide <jayakumar.ide@gmail.com>
Subject: eighty_ninty_three
Date: Thu, 22 Sep 2005 15:31:06 +0800
Message-ID: <ed723e8205092200315d6d1f2a@mail.gmail.com>
Reply-To: jayakumar ide <jayakumar.ide@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:65411 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750988AbVIVHbJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Sep 2005 03:31:09 -0400
Received: by zproxy.gmail.com with SMTP id 13so127342nzn
        for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2005 00:31:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

quick question:

598 /*
599  *  All hosts that use the 80c ribbon must use!
600  *  The name is derived from upper byte of word 93 and the 80c ribbon.
601  */
602 u8 eighty_ninty_three (ide_drive_t *drive)
603 {
604         if(HWIF(drive)->udma_four == 0)
605                 return 0;
606         if (!(drive->id->hw_config & 0x6000))
607                 return 0;
608 #ifndef CONFIG_IDEDMA_IVB
609         if(!(drive->id->hw_config & 0x4000))
610                 return 0;
611 #endif /* CONFIG_IDEDMA_IVB */
612         return 1;
613 }

does that mean that 893() will return 0 if the drive is not udma4
capable? what's the rest of the stuff about 0x6000 and 0x4000? i took
a quick look at a diamondmax spec and it says:

http://www.maxtor.com/_files/maxtor/en_us/documentation/manuals/diamondmax_plus_9_manual.pdf

Word 93 Hardware reset result. The contents of bits (12:0) of this
word shall change only
during the execution of a hardware reset
15: Shall be cleared to zero.
14: Shall be set to one.
13: 1 = device detected CBLID- above ViH. 0 = device detected CBLID- below
ViL
12-8: Device 1 hardware reset result. Device 0 shall clear these bits to zero.
Device shall set these bits as follows:
12: Reserved.
11: 0 = Device 1 did not assert PDIAG

So I'm not sure I understand what the 0x6000 and 0x4000 check does. I
was kind of hoping it would be some way to detect whether the cable
was 40 core or 80 core. The reason I'm asking is because I'm trying to
figure out the appropriate usage for eighty_ninty_three, ratemask and
ide_rate_filter. I think I should call eighty93 in ratemask() and then
use that to decide what the maximum mode should be. so if eighty93
returned 0, then I would set max mode to 3 if my device spec claimed
it was UDMA66 0-4 capable. Actually, I'm not sure about the UDMA66 0-4
stuff. I haven't yet understood the relationship between the
XFER_UDMA_n and the UDMA/33/66/100 0-4 modes. If anyone has advice,
I'm all ears.

Thanks,
jayakumar
