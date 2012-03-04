From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: ATA standard vs. speed
Date: Sun, 04 Mar 2012 08:55:34 -0600
Message-ID: <1330872934.2858.18.camel@dabdike.int.hansenpartnership.com>
References: <20120304144806.4bef0256@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37768 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754447Ab2CDOzi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Mar 2012 09:55:38 -0500
In-Reply-To: <20120304144806.4bef0256@endymion.delvare>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-ide@vger.kernel.org

On Sun, 2012-03-04 at 14:48 +0100, Jean Delvare wrote:
> Hi all,
> 
> After reading
> http://en.wikipedia.org/wiki/Parallel_ATA#Features_introduced_with_each_ATA_revision
> it seemed clear to me that there was a direct relation between the
> operating speed of a (P)ATA hard disk drive and the version of the ATA
> standard it implemented. However I see the following in my kernel logs
> on an old machine (kernel 2.6.34, Intel ICH5 controller):
> 
> ata1: PATA max UDMA/100 cmd 0xeff0 ctl 0xefe4 bmdma 0xef90 irq 18
> ata2: PATA max UDMA/100 cmd 0xefa8 ctl 0xefe0 bmdma 0xef98 irq 18
> ata2.00: HPA unlocked: 40018511 -> 40020624, native 40020624
> ata2.00: ATA-6: Maxtor 52049H4, DAC10SC0, max UDMA/100
> ata2.00: 40020624 sectors, multi 16: LBA 
> ata1.00: HPA unlocked: 78175679 -> 78177792, native 78177792
> ata1.00: ATA-5: MAXTOR 6L040J2, A93.0300, max UDMA/133
> ata1.00: 78177792 sectors, multi 16: LBA 
> 
> While the second disk matches the wikipedia table (ATA-6 introduced
> UDMA/100), the first one doesn't: UDMA/133 wasn't supposed to exist in
> standard ATA-5.
> 
> Digging old logs, I also found this (same machine, same kernel,
> different drive):
> 
> ata2.00: ATA-4: WDC WD102AA, 05.05B05, max UDMA/66
> 
> Here again, UDMA/66 wasn't supposed to exist in standard ATA-4.
> 
> Can anyone explain this mystery to me?

It's not really a mystery: in this device speed hungry world
manufacturers usually get out ahead of standards, particularly for
transport and signalling electronics.  In SCSI, SCSI-2 only covered
10Mhz cable speeds but we were up to about 40MHz before SCSI-3 finally
came along and ratified it (and even then, lots of drives that go up to
high ultra speeds still only reported SCSI-2 compliance).

In SCSI, we got around this problem eventually by separating the
command, device and transport layers into different standards.  ATA does
this from ATA-8.

James


