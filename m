From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
Date: Tue, 23 Sep 2008 21:20:05 +0400
Message-ID: <48D92545.7050307@ru.mvista.com>
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp>	<48D57245.8060606@ru.mvista.com> <20080924.020459.128619366.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:42390 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752569AbYIWRTH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Sep 2008 13:19:07 -0400
In-Reply-To: <20080924.020459.128619366.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: bzolnier@gmail.com, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org

Hello.

Atsushi Nemoto wrote:

>>>+static int tx4939ide_dma_test_irq(ide_drive_t *drive)
>>>+{
>>>+	ide_hwif_t *hwif = HWIF(drive);
>>>+	void __iomem *base = TX4939IDE_BASE(hwif);
>>>+	u16 ctl = tx4939ide_readw(base, TX4939IDE_int_ctl);
>>>+	u8 dma_stat, stat;
>>>+	u16 ide_int;
>>>+	int found = 0;
>>>+
>>>+	tx4939ide_check_error_ints(hwif, ctl);
>>>+	ide_int = ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST);

>>   Well, since you're effectively ignoring the BUSERR interrupt, there's 
>>no point in enabling it...

> The BUSERR is not ignored.  tx4939ide_check_error_ints() will print a
> message.  It would be better than just ignoring.

     I mean you're not accounting it as an interrupt.  It will be reported 
anyway when the dma_timeout() method will call this method on timeout... ah, 
it wouldn't be called in this case since dma_time_expiry() will most probably 
return -1 seeing bit 1 of DMA status register set.  You're right then...

> ---
> Atsushi Nemoto

MBR, Sergei
