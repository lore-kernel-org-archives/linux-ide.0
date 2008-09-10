From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Wed, 10 Sep 2008 19:55:16 +0400
Message-ID: <48C7EDE4.3090400@ru.mvista.com>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>	<48C6B768.4010200@ru.mvista.com> <20080911.003222.51867360.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:14476 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751795AbYIJPyi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Sep 2008 11:54:38 -0400
In-Reply-To: <20080911.003222.51867360.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

Hello.

Atsushi Nemoto wrote:

>>>+		if (drive != &hwif->drives[i] &&
>>>+		    (hwif->drives[i].dev_flags & IDE_DFLAG_PRESENT))
>>>+			safe_speed = min(safe_speed,
>>>+					 (int)hwif->drives[i].current_speed);

>>    You shouldn't clamp the command PIO mode timings like this, and shouldn't 
>>do it at all when DMA mode is set. Call ide_get_best_pio_mode(255, 4) to get 
>>the mate drive's fastest PIO mode which should be a clamping value.

>>>+	/* Command Transfer Mode Select */
>>>+	switch (safe_speed) {
>>>+	case XFER_UDMA_5:
>>>+	case XFER_UDMA_4:
>>>+	case XFER_UDMA_3:
>>>+	case XFER_UDMA_2:
>>>+	case XFER_UDMA_1:
>>>+	case XFER_UDMA_0:
>>>+	case XFER_MW_DMA_2:

>>    You shouldn't change the command PIO mode when DMA mode is selected.

> But the "Command Transfer Mode Select" bits affects access timings on
> setting task registers for DMA command.

    So what? PIO and DMA are different protocols on IDE bus, so they shouldn't 
affect each other. The IDE core will always tune the best PIO mode for you, so 
the optimal command timings will be set.

>  Hmm... do you mean I should not do it _here_?

    You should only change command PIO timings only when PIO mode is changed.

>>>+	case XFER_MW_DMA_1:
>>>+	case XFER_MW_DMA_0:
>>>+	case XFER_PIO_4:

>>    MWDMA0/1 timings don't match PIO4, they are [much] slower.

> Oh thanks.  I will fix it.

    Just do not change PIO mode when selecitng DMA mode at all.

>>>+		hwif->select_data =
>>>+			(hwif->select_data & ~0xffff0000) | (value << 16);

>>    Why not just 0x0000ffff?

>>>+	else
>>>+		hwif->select_data = (hwif->select_data & ~0x0000ffff) | value;

>>    Why not just 0xffff0000?

> Indeed.

    Acltually, this is somewhat wrong WRT the programming the command PIO 
timings in the bits 8..10: they should be set to the same value (matching to 
the last "safest" PIO mode set) for both drives, so you should only "switch" 
bits 4 thru 7 of this register.

MBR, Sergei

