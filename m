From: Jeff Garzik <jgarzik@pobox.com>
Subject: [sata] libata update
Date: Tue, 30 Mar 2004 16:31:39 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4069E73B.1040109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18818 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261351AbUC3Vby
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Mar 2004 16:31:54 -0500
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>


A ton of SATA work in the past few weeks, but not a lot terribly new in 
this update.  The update is mainly to rediff against the latest 2.4 and 
2.6 kernels.  Note that this does not include experimental patches. 
Notably absent are

* lba48 (large transfer) requests
* splitting up Promise driver into sata_promise (tx2/tx4) and sata_sx4 
(sx4) drivers.
* adding better flush-cache / writeback caching support

The above are all experimental patches I have locally.

Finally, per user requests, I have started posting the associated 
changelog as well.

BK repositories:
	http://gkernel.bkbits.net/libata-2.[46]

2.6.x patch and changelog:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.5-rc3-libata1.patch.bz2
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.5-rc3-libata1.log

2.4.x patch and changelog:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.26-rc1-libata2.patch.bz2
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.26-rc1-libata2.log

Drivers for SATA-2 controllers have been in development, and should be 
making their appearance soon.



