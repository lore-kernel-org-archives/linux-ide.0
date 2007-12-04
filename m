From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Is BIO_RW_FAILFAST really usable?
Date: Mon, 03 Dec 2007 22:51:21 -0500
Message-ID: <4754CEB9.4030703@garzik.org>
References: <18260.49019.684445.303719@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50206 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362AbXLDDvZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 22:51:25 -0500
In-Reply-To: <18260.49019.684445.303719@notabene.brown>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Neil Brown wrote:
> I've been looking at use BIO_RW_FAILFAST in md/raid to improve
> handling of some error cases.
> 
> This is particularly significant for the DASD driver (s390 specific).
> I believe it uses optic fibre to connect to the drives.  When one of
> these paths is unplugged, IO requests will block until an operator
> runs a command to reset the card (or until it is plugged back in).
> The only way to avoid this blockage is to use BIO_RW_FAILFAST.  So
> we really need BIO_RW_FAILFAST for a reliable RAID1 configuration on
> DASD drives.
> 
> However, I just tested BIO_RW_FAILFAST on my SATA drives: controller 
> 
> 02:06.0 RAID bus controller: Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
> 
> (not using the cards minimal RAID functionality) and requests fail
> immediately and always with e.g.
> 
> sd 2:0:0:0: [sdc] Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK,SUGGEST_OK
> end_request: I/O error, dev sdc, sector 2048
> 
> So fail fast obviously isn't generally usable.
> 
> What is the answer here?  Is the Silicon Image driver doing the wrong
> thing, or is DASD doing the wrong thing, or is BIO_RW_FAILFAST
> under-specified and we really need multiple flags or what?

It's a hard thing to implement, in general, for scalability reasons.

To make it work, you need to examine each driver's error handling to 
figure out what "fail fast" really means.

Most storage drivers are written to try as hard as possible to complete 
a request, where "try as hard as possible" can often mean internal 
retries while trying various multi-path configurations and hardware mode 
changes.  You might be catching SATA in the middle of error handling, 
for example.

So each driver really has a /slight different/ version of "try to 
complete this request", which has the obvious effects on BIO_RW_FAILFAST.

No clue about DASD, but in SATA's case I bet that a media or transfer 
error could be returned to the system more rapidly, while we continue to 
try to recover in the background.  libata doesn't have any direct 
knowledge of fail-fast at this point, IIRC.

But overall it's a job where you must examine each driver, or set of 
drivers :/

	Jeff


