From: richard kennedy <richard@rsk.demon.co.uk>
Subject: Re: pata_via cd/dvd timeout problems
Date: Wed, 05 Sep 2007 09:50:10 +0100
Message-ID: <1188982210.3075.9.camel@castor.rsk.org>
References: <124748.3608.qm@web54408.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:2999 "EHLO
	anchor-post-36.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756024AbXIEIuW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 04:50:22 -0400
In-Reply-To: <124748.3608.qm@web54408.mail.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vlad <vladc6@yahoo.com>
Cc: linux-ide@vger.kernel.org

On Tue, 2007-09-04 at 17:40 -0700, Vlad wrote:
> Hi,
> 
> > I have both a dvd RW drive & a cd rom drive connected
> > the second ide interface on my motherboard with a via
> > chipset, using pata_via I see timeout messages in the
> > log & after some time both drives lockup and are
> > unable to mount any disks. 
> 
> I would suggest trying the following things:
> 
> 1) Add both drives ("_NEC DVD_RW ND-3520" and "TSSTcorpDVD-ROM
> TS-H352A") to ata_device_blacklist in drivers/ata/libata-core.c using
> the ATA_HORKAGE_NODMA and ATA_HORKAGE_MAX_SEC_128 keywords and then
> recompile the kernel.
> 
> 2) Move the CD and DVD RW drives to a computer with another chipset to
> determine whether they or the chipset are to blame.
> 
> Vlad
> 
Thanks for the suggestion I'll give it a try.

Unfortunately I don't have another machine to try these drives in. But
they both worked OK under the old ide code -- the problems only started
with the move to libata.

I guess the commands timing out are udev probing to see if a disk has
been inserted ?

thanks
Richard

