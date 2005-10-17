From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix broken Kconfig setup
Date: Mon, 17 Oct 2005 13:38:44 -0400
Message-ID: <4353E1A4.4050404@pobox.com>
References: <20051017044606.GA1266@havoc.gtf.org> <Pine.LNX.4.64.0510170754500.23590@g5.osdl.org> <4353C42A.3000005@pobox.com> <Pine.LNX.4.64.0510170848180.23590@g5.osdl.org> <4353CF7E.1090404@pobox.com> <Pine.LNX.4.64.0510170930420.23590@g5.osdl.org> <Pine.LNX.4.64.0510170946250.23590@g5.osdl.org> <4353DB2C.10905@pobox.com> <Pine.LNX.4.64.0510171017010.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:3471 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751181AbVJQRis (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Oct 2005 13:38:48 -0400
In-Reply-To: <Pine.LNX.4.64.0510171017010.3369@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, davej@redhat.com

Linus Torvalds wrote:
> The _best_ choice as far as I can tell, is to just dis-associate SATA from 
> SCSI entirely. Even if it's an implementation choice, we could make it a 
> "select SCSI" instead of "depends on SCSI", so that from a _logical_ 
> standpoint the user could just select SATA support without even knowing 
> that the kernel happens to need the SCSI layer for it.

Yep.  That would happen as a side effect of moving the code to 
drivers/ata, even.


> Of course, eventually I still hope that SATA could be done on the block 
> layer instead of even depending on SCSI at all, but hey, that's a totally 
> different issue.

If you look at libata-scsi, the code is simply a SCSI simulator that 
calls a _clean_ and _separate_ libATA API.

Other code -- such as a block-layer driver -- could use this same API. 
I think Bart has mentioned he has early code to do this, or at least 
ideas on how to do it.

I made a promise to you, to do it at the block layer, and I intend to 
keep my promise.  :)  It just takes years to get there.  The two main 
reasons for using SCSI were/are:

* provides a bunch of useful _generic_ infrastructure

* has a very high Just Works(tm) value for distro installers and users, 
where code already exists for /dev/sdX.  I learned the hard way with 
drivers/block/sx8.c that adding a new block device involves coordination 
with multiple distros :(

I dream of a /dev/disk, perhaps reusing and expanding /dev/sdX's block 
majors, but that may be unrealistic.

	Jeff

