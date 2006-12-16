From: Jeff Garzik <jeff@garzik.org>
Subject: Re: JMicron SATA, "softreset failed (1st FIS failed)" on every boot
Date: Sat, 16 Dec 2006 12:10:46 -0500
Message-ID: <45842896.7030906@garzik.org>
References: <20061001133224.GC2848@melchior.yamamaya.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35009 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161250AbWLPRKt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Dec 2006 12:10:49 -0500
In-Reply-To: <20061001133224.GC2848@melchior.yamamaya.is-a-geek.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tobias Diedrich <ranma@tdiedrich.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Tobias Diedrich wrote:
> Hi,
> 
> I'm seeing the following strange behaviour with libata in the
> mm-series (currently 2.6.18-mm2):
> 
> [   31.324566] ata2: softreset failed (1st FIS failed)
> [   31.324674] ata2: softreset failed, retrying in 5 secs
> [   36.642196] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   36.645232] ata2.00: ATA-7, max UDMA7, 488397168 sectors: LBA48 NCQ (depth 31/32)
> 
> This is with a JMicron controller in AHCI mode on an ASUS M2N-SLI
> Deluxe board.  It's a bit annoying, since this means an additional
> 5-second delay on every boot.

Do you see the same on 2.6.20-rc1?

	Jeff



