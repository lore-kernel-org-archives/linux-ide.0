From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Linux v2.6.16-rc6
Date: Sun, 12 Mar 2006 17:54:55 -0500
Message-ID: <4414A6BF.3030604@garzik.org>
References: <1142189154.21274.20.camel@blaze.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:20946 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751349AbWCLWy6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Mar 2006 17:54:58 -0500
In-Reply-To: <1142189154.21274.20.camel@blaze.homeip.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Blazejowski <paulb@blazebox.homeip.net>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Paul Blazejowski wrote:
> sata_nv 0000:00:07.0: version 0.8

sata_nv

> ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC400 irq 21
> ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 21

host max udma6

> ata3: dev 0 ATA-6, max UDMA/100, 390721968 sectors: LBA48
> ata3: dev 0 configured for UDMA/100

dev max udma5, configured for max speed

> ata4: dev 0 ATA-6, max UDMA/133, 390721968 sectors: LBA48
> ata4: dev 0 configured for UDMA/133

dev max udma6, configured for max speed

Everything is correct.

	Jeff


