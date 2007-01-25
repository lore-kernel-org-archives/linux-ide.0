From: John Williams <john@pond-weed.com>
Subject: Failed to set xfermode on LITE-ON  LTR-40125S
Date: Thu, 25 Jan 2007 20:17:50 +0000
Message-ID: <20070125201750.2adbd57c@buffy.scoobygang>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from john-and-mon.demon.co.uk ([62.49.18.13]:3977 "EHLO
	pond-weed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030561AbXAYUog (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Jan 2007 15:44:36 -0500
Received: from buffy.scoobygang ([192.168.156.102])
	by pond-weed.com with esmtps (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HAB2h-00067d-4i
	for linux-ide@vger.kernel.org; Thu, 25 Jan 2007 20:17:55 +0000
Received: from buffy.scoobygang (localhost [127.0.0.1])
	by buffy.scoobygang (8.13.8/8.13.5) with ESMTP id l0PKHowL002670
	for <linux-ide@vger.kernel.org>; Thu, 25 Jan 2007 20:17:50 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I just tried the libata support for PATA in kernel 2.6.20-rc5 and I got
this:

scsi1 : pata_sis
ata2.00: ATAPI, max UDMA/66
ata2.01: ATAPI, max UDMA/33
ata2.00: configured for UDMA/33
ata2.01: qc timeout (cmd 0xef)
ata2.01: failed to set xfermode (err_mask=0x4)
ata2.01: limiting speed to UDMA/25
ata2: failed to recover some devices, retrying in 5 secs
ata2.00: configured for UDMA/33
ata2.01: qc timeout (cmd 0xef)
ata2.01: failed to set xfermode (err_mask=0x4)
ata2.01: limiting speed to PIO0
ata2: failed to recover some devices, retrying in 5 secs
ata2.00: configured for UDMA/33
ata2.01: qc timeout (cmd 0xef)
ata2.01: failed to set xfermode (err_mask=0x4)
ata2.01: disabled
ata2: failed to recover some devices, retrying in 5 secs
ata2.00: failed to set xfermode (err_mask=0x40)
ata2.00: limiting speed to UDMA/25
ata2: failed to recover some devices, retrying in 5 secs
ata2.00: configured for UDMA/25

The offending device is a LITE-ON LTR-40125S CDRW attached to SIS 513
IDE (rev d0)

I found a patch here:
http://readlist.com/lists/vger.kernel.org/linux-kernel/45/228948.html
which cures the problem for me. Is this the recommended patch for this
problem? If not, I would be happy to test alternative solutions.

Thanks,
John Williams
