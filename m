From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_cmd64x: Correct the speed ranges
Date: Fri, 27 Jul 2007 01:16:19 +0400
Message-ID: <46A90F23.8010907@ru.mvista.com>
References: <200707262101.l6QL1Iqk029149@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:37544 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756385AbXGZVOS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jul 2007 17:14:18 -0400
In-Reply-To: <200707262101.l6QL1Iqk029149@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Mikael Pettersson wrote:

> This fix inspired me to finally try to convert my Sun Ultra5
> (sparc64) with a CMD646 [1095:0646 rev 03] to libata.

> With pata_cmd64x the machine has so far survived a usual
> boot/mrproper/reconfig/make/install/reboot kernel update
> cycle without any issues, and performance seems to be the
> same as with the old IDE driver.

> /Mikael
> 
> scsi0 : pata_cmd64x
> scsi1 : pata_cmd64x
> ata1: PATA max MWDMA2 cmd 0x000001fe02c00000 ctl 0x000001fe02c0000a bmdma 0x000001fe02c00020 irq 14
> ata2: PATA max MWDMA2 cmd 0x000001fe02c00010 ctl 0x000001fe02c0001a bmdma 0x000001fe02c00028 irq 14
> ata1.00: ATA-4: ST320420A, 3.21, max UDMA/66
> ata1.00: 39851760 sectors, multi 0: LBA 
> pata_cmd64x: active 3 recovery 1 setup 1.
> ata1.00: configured for MWDMA2
> ata2.00: ATAPI: CRD-8483B, 1.00, max UDMA/33
> pata_cmd64x: active 3 recovery 1 setup 1.
> ata2.00: configured for MWDMA2
[...]

    Note that the olde driver has MWDMA fixed, and the new one has it still 
borken, yet MWDMA2 is the mode you're using.

MBR, Sergei
