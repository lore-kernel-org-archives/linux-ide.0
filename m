From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24-rc6 and earlier: "host bus error" after STR
Date: Wed, 26 Dec 2007 17:10:59 +0900
Message-ID: <47720C93.2010800@gmail.com>
References: <20071224204813.GA3546@martell.zuzino.mipt.ru> <20071225094151.GA9769@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:30755 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbXLZL2a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Dec 2007 06:28:30 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2212763rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 26 Dec 2007 03:28:30 -0800 (PST)
In-Reply-To: <20071225094151.GA9769@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, torvalds@osdl.org, jgarzik@pobox.com, pavel@suse.cz, rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

Jeff Garzik wrote:
>> ata3.00: limiting speed to UDMA/33:PIO4
>> ata3.00: exception Emask 0x0 Sact 0x0 Serr 0x0 action 0x2
>> ata3.00: BMDMA stat 0x6
>> ata3.00: cmd ca/00:08:47:66:6e/00:00:00:00:00/eb tag 0 dma 4096 out
>> 	 res 51/84:08:47:66:6e/00:00:00:00:00/eb Emask 0x30 (host bus error)
>> ata3.00: status: { DRDY ERR }
>> ata3.00: error: { ICRC ABRT }
>> ata3: soft resetting link
> 
> host bus == PCI
> 
> So, your PCI bus is crapping itself in a major way.
> 
> One thing to try might be "libata.noacpi=1"

Yeah, BMDMA stat 0x6 is INTR and ERR which means the controller tried to
perform DMA write but couldn't pull data from main memory.  Maybe PCI
bus isn't setup properly after resuming.  Comparing the result of 'lspci
-xxx' before and after resume and see what changed can be helpful.

Thanks.

-- 
tejun

