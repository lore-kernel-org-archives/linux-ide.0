From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PROBLEM: dma timeout errors on reads and large writes (sata_vsc
 on kernel 2.6.9)
Date: Thu, 09 Dec 2004 01:58:02 -0500
Message-ID: <41B7F77A.2080404@pobox.com>
References: <000501c4ddb2$b97cd660$0d65a8c0@SHARK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56723 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261465AbULIG6H
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Dec 2004 01:58:07 -0500
In-Reply-To: <000501c4ddb2$b97cd660$0d65a8c0@SHARK>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atul Bhouraskar <atul.bhouraskar@acoustic-technologies.com>
Cc: linux-ide@vger.kernel.org

Atul Bhouraskar wrote:
> Hi,
> 
> I am building a linux-2.6.9 system with 4 250G SATA drives (using the
> intel GD31244 controller).
> I have compiled a monolithic kernel with Vitesse vsc SATA support, ACPI
> and APM have been turned off (see config at end of message).
> The kernel boots up properly and detects all drives correctly (see dmesg
> below).
> I can partition and initialize the drives without any problem (using
> cfdisk and mke2fs).
> I can read and write small files (<100MB) without any problem too.
> 
> But when I try to use any of the drives with large files (more than a
> couple of GB), the process invariably hangs with the kernel spewing out
> ATA timeout and other errors (see log below). It usually needs a write
> of more than 5-6GB before it happens, but it usually occurs at around
> 50-100MB while reading. It is not possible to kill the hung process,
> though the rest of the system continues to be responsive. Any further
> access (even an 'ls') on *any* of the SATA drives usually instantly
> meets with the same fate.
> 
> It can be reproduced in the following way:

I got a similar report via my employer as well.  I don't think anybody 
has really tested sata_vsc on the Intel controller, just the one that 
Vitesse put out.

You don't happen to have a spare controller, do you?

	Jeff



