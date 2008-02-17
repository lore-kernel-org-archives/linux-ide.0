From: Willy Tarreau <w@1wt.eu>
Subject: [PATCH 0/2] libata: implement 32-bit transfers for PIO mode
Date: Sun, 17 Feb 2008 22:18:10 +0100
Message-ID: <20080217211810.GA15001@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1wt.eu ([62.212.114.60]:2013 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757281AbYBQVSS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 17 Feb 2008 16:18:18 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jeff,

For several times I tried libata on small machines equipped with either
CompactFlash or IDE DOM (Disk-On-Module). All those machines with small
flashes (<= 256 MB) were about 35-40% slower under libata than under the
plain old IDE driver. I realized that all the slower ones were running
PIO only.

Today I had time to investigate the issue on a Geode LX board. At first
I thought it was the pata_cs5536 driver which would have incorrect timings,
but this was not the case. I finally noticed that under IDE, my flashes
were running in 32-bit mode while I could not enable 32-bit with libata.

Reading ata_data_xfer() made it obvious that transfers were only 16-bit
wide.

Thus, I have implemented the 32-bit mode to bring the performance back
to the level of the old IDE driver. I jumped from 1.5 MB/s to 2.5 MB/s,
which is an important difference at this level of performance, especially
when large files are read. The 32-bit mode is enabled using the ioctl
which is already implemented but only accepts a null value.

I'm joining two patches which I hope you'll consider for inclusion. I've
updated them to latest Linus' git.

Best regards,
Willy

