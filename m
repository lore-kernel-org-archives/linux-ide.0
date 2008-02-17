From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/2] libata: implement 32-bit transfers for PIO mode
Date: Sun, 17 Feb 2008 22:31:34 +0000
Message-ID: <20080217223134.1c61809b@core>
References: <20080217211810.GA15001@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49769 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753972AbYBQWkC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Feb 2008 17:40:02 -0500
In-Reply-To: <20080217211810.GA15001@1wt.eu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Willy Tarreau <w@1wt.eu>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> Thus, I have implemented the 32-bit mode to bring the performance back
> to the level of the old IDE driver. I jumped from 1.5 MB/s to 2.5 MB/s,
> which is an important difference at this level of performance, especially
> when large files are read. The 32-bit mode is enabled using the ioctl
> which is already implemented but only accepts a null value.

Excellent, that has been on my TODO list for some time and I'd only
gotten as far as putting into the ISA/VLB drivers rather than generally
testing.

I'm not however sure this should be a DFLAG but should be an alernative
ata_data_xfer method - I say that because VLB needs to wrap it and some
controllers have quirky rules for 32bit xfers. (Also some small number of
pre ATA disks can't handle the different timing cycles from a 32bit ISA
I/O being redirected their way).

Alan
