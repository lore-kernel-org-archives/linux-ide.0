From: Vlad <vladc6@yahoo.com>
Subject: Re: pata_via cd/dvd timeout problems
Date: Tue, 4 Sep 2007 17:40:26 -0700 (PDT)
Message-ID: <124748.3608.qm@web54408.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web54408.mail.yahoo.com ([206.190.49.138]:34485 "HELO
	web54408.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754669AbXIEArH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Sep 2007 20:47:07 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: richard kennedy <richard@rsk.demon.co.uk>
Cc: linux-ide@vger.kernel.org

Hi,

> I have both a dvd RW drive & a cd rom drive connected
> the second ide interface on my motherboard with a via
> chipset, using pata_via I see timeout messages in the
> log & after some time both drives lockup and are
> unable to mount any disks. 

I would suggest trying the following things:

1) Add both drives ("_NEC DVD_RW ND-3520" and "TSSTcorpDVD-ROM
TS-H352A") to ata_device_blacklist in drivers/ata/libata-core.c using
the ATA_HORKAGE_NODMA and ATA_HORKAGE_MAX_SEC_128 keywords and then
recompile the kernel.

2) Move the CD and DVD RW drives to a computer with another chipset to
determine whether they or the chipset are to blame.

Vlad


       
____________________________________________________________________________________
Pinpoint customers who are looking for what you sell. 
http://searchmarketing.yahoo.com/
