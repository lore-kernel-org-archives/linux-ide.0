From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata passthru: support PIO multi commands
Date: Tue, 12 Jun 2007 17:05:19 +0100
Message-ID: <20070612170519.5f427a70@the-village.bc.nu>
References: <200706112200.l5BM0qFn005767@hera.kernel.org>
	<20070611233917.4bd8c6d7@the-village.bc.nu>
	<466DE438.70108@garzik.org>
	<20070612111621.10074408@the-village.bc.nu>
	<466EB937.6050807@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38614 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755401AbXFLQAM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jun 2007 12:00:12 -0400
In-Reply-To: <466EB937.6050807@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Albert Lee <albertcc@tw.ibm.com>

> ata_scsi_pass_thru() is not executed at ioctl submission time (block 
> queue submission time), but rather immediately before it is issued to 
> the drive.  At that point you know the bus is idle, all other commands 
> have finished executing, and dev->multi_count is fresh not stale.  The 
> code path goes from ata_scsi_pass_thru() to ata_qc_issue() without 
> releasing the spinlock, even.

Think up to user space

Poorusersapp			set multicount to 4

Evilproprietarytuningdaemon	set multicount to 8

Poorusersapp			issue I/O

at which point an error is indeed best.

> But the last point is true -- we should error rather than just warn 
> there, AFAICS.

Definitely. We've been asked "please do something stupid" and not even in
a case where the requester may know better.

Alan
