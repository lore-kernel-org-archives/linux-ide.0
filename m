From: Pat LaVarre <p.lavarre@ieee.org>
Subject: SATAPI status
Date: 23 Jul 2004 10:58:45 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1090601924.4850.6.camel@patibmrh9>
References: <2429743E-DBFD-11D8-A213-00039398BB5E@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:59605 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S267841AbUGWQ67
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jul 2004 12:58:59 -0400
Received: from royntex01.iomegacorp.com (edison [10.1.1.82])
	by email.iomega.com (Postfix) with ESMTP id 8DF9226CF
	for <linux-ide@vger.kernel.org>; Fri, 23 Jul 2004 10:58:58 -0600 (MDT)
In-Reply-To: <2429743E-DBFD-11D8-A213-00039398BB5E@ieee.org>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Sanity check failed.  Specifically,

> http://marc.theaimsgroup.com/?l=linux-ide&m=109051413922708
> Subject: Re: Linux Serial ATA (SATA) status report
> Date: 2004-07-22 16:35:28

Easiest for me to try first was plugging an unreleased SATAPI device
into:

Linux 2.6.8-rc1-bk6 i686

After defining ATA_ENABLE_ATAPI ATA_DEBUG ATA_VERBOSE_DEBUG in
include/linux/libata.h, then still I saw the disappointing:

kernel: ata_bus_reset: ENTER, host 2, port 1
kernel: ata_bus_softreset: ata2: bus reset via SRST
kernel: ATA: abnormal status 0x80 on port 0xE007
kernel: ata_bus_reset: EXIT

I guess next I'll fall back to trying an old device, and if need be an
old kernel, to reestablish a base line.  Til I have an interesting
question or patch to share, I may remember to blog how life goes to
http://linux-pel.blog-city.com/read/742498.htm

Pat LaVarre


