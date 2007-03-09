From: Tejun Heo <htejun@gmail.com>
Subject: Re: [git patches] libata fixes
Date: Fri, 09 Mar 2007 21:49:07 +0900
Message-ID: <45F157C3.4090604@gmail.com>
References: <01bd01c75fc2$57e70300$4b00a8c0@donald>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:56925 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767221AbXCIMtP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 07:49:15 -0500
Received: by wx-out-0506.google.com with SMTP id h31so846359wxd
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 04:49:14 -0800 (PST)
In-Reply-To: <01bd01c75fc2$57e70300$4b00a8c0@donald>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rol@as2917.net
Cc: 'Jeff Garzik' <jeff@garzik.org>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Linus Torvalds' <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, "'Eric D. Mudama'" <edmudama@gmail.com>

Paul Rolland wrote:
> Hell Tejun,
> 
> I've boot-tested this yesterday, with no real luck... 
> 
> 1 - Tested on top of 2.6.21-rc2 (hope it's fine for you),
> 2 - Collected a full dmesg before and after
> 
> Extract is :
> ata7: PATA max UDMA/100 cmd 0x0000000000019c00 ctl 0x0000000000019882 bmdma
> 0x00
> 00000000019400 irq 16
> ata8: PATA max UDMA/100 cmd 0x0000000000019800 ctl 0x0000000000019482 bmdma
> 0x00
> 00000000019408 irq 16
> scsi6 : pata_jmicron
> ata7.00: ATAPI, max UDMA/66
> ata7.00: configured for UDMA/66
> scsi7 : pata_jmicron
> ATA: abnormal status 0x7F on port 0x0000000000019807
> ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata7.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)

It seems like IRQ is not getting through.  The first IRQ driven command
is failing for you.

* Does giving 'acpi=off' or 'irqpoll' make any difference?

* Can you connect a harddisk to the channel and see whether that works?

Thanks.

-- 
tejun
