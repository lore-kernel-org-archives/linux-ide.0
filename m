From: Craig Metz <cmetz@inner.net>
Subject: Re: Problems with Linux SATA driver and ARC-770 IDE Bridge chip
Date: Wed, 25 Apr 2007 22:35:33 -0400
Message-ID: <20070426023534.68007582C@rmail.inner.net>
References: <010501c78736$aad2e480$0703a8c0@SJAWINXP>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rmail.inner.net ([199.33.248.12]:3497 "EHLO rmail.inner.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754680AbXDZCYT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Apr 2007 22:24:19 -0400
In-reply-to: <010501c78736$aad2e480$0703a8c0@SJAWINXP> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Steven J. Ackerman" <sjackerman@comcast.net>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com

In message <010501c78736$aad2e480$0703a8c0@SJAWINXP>, you write:
>> Here are the Linux Kernel error messages that are produced by this
>> kernel running on a Intel D865GLC motherboard trying to talk to our
>> ARC-770 based adaptor on SATA-0 :
>> 
>> ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 10 
>> scsi2 : ata_piix ata1.00: CFA, max PIO4, 8005536 sectors: LBA 
>> ata1.00: ata1: dev 0 multi count 0 ata1.00: qc timeout (cmd 0xef) 
>> ata1.00: failed to set xfermode (err_mask=0x4)
>
>Can you give a shot at 2.6.21-rc7.  The problem should have been fixed
>there.

  I am also having problems with this device, but on both an ICH5 and on a
VIA pre-AHCI SATA controller. I just tried 2.6.21-rc7 - it fails in exactly the
same way as with 2.6.20.

									-Craig
