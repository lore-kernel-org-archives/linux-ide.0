From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: Linux Serial ATA (SATA) status report
Date: Thu, 22 Jul 2004 10:35:28 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <2429743E-DBFD-11D8-A213-00039398BB5E@ieee.org>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:5098 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S266713AbUGVQfZ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jul 2004 12:35:25 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff G:

Two points:

1)

 > SATA driver release ... 2.4.28 and 2.6.7.
 > changes aren't very visible, ...
 > ... tweaked  ... buzzwords:  ATAPI, DMADIR, ... jelly beans.

Please tell me if I can now help.  Myself I only know to try:

a) SATAPI UDMA DVD without CONFIG_SCSI_SATA

b) SATAPI UDMA DVD with CONFIG_SCSI_SATA, with compile-time options and 
other patches applied near include/linux/libata.h

c) Add Di <= Hi PIO auto sense, now that we/ you have overcome:

--- http://kernel.org/pub/linux/kernel/v2.6/testing/ChangeLog-2.6.8-rc1
...
[libata] create, and use, ->irq_clear hook
...
On Intel ICH5/6, the BMDMA 'interrupt' status bit will be set even on 
non-DMA commands, ... This change clears pending interrupts once upon 
initialization, and then each ... ata_irq_on...
...
---

2)

 > Serial ATA (SATA) for Linux
 > status report
 > July 8, 2004

Please correct me if I err in thinking,

Still today in kernel.org Linux .config we choose one of two SATAPI 
UDMA.  The post:

 > > > Subject: Re: SATA ATAPI UDMA - first in Linux
 > > > From: Jeff Garzik ...
 > > > Date: 2004-05-14 20:35:53
 > > > http://marc.theaimsgroup.com/?l=linux-ide&m=108456699805023&

tells us of an lk 2.6 SATAPI UDMA available near make defconfig when 
CONFIG_SCSI_SATA is not set.  But the focus of this "Subject: Re: Linux 
Serial ATA (SATA) status report" thread is the Linux SATA/ SATAPI we 
get when CONFIG_SCSI_SATA=y.

Pat LaVarre

