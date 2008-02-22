From: Mark Lord <liml@rtr.ca>
Subject: Re: ata-piix.c (and libata.ko) in RHEL5.1 (build 78 currently) -
 this kernel is 2.6.18 baqsed
Date: Fri, 22 Feb 2008 12:37:28 -0500
Message-ID: <47BF0858.9050400@rtr.ca>
References: <6853F62BE9A693419863D51D4554A9E3012BE92B@EXNA.corp.stratus.com>	<20080222151010.GC30920@devserv.devel.redhat.com>	<47BEFB0B.9070808@rtr.ca> <20080222170312.4c849c0d@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3829 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757534AbYBVRh3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Feb 2008 12:37:29 -0500
In-Reply-To: <20080222170312.4c849c0d@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@redhat.com>, "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>, jgarzik@pobox.com, "Petrakis, Peter" <Peter.Petrakis@stratus.com>, "Duval, Dan" <Dan.Duval@stratus.com>, "Dailey, Nate" <Nate.Dailey@stratus.com>, linux-ide@vger.kernel.org

Alan Cox wrote:
>> 3) It is critical to ensure that the ATA "ctl" register is never
>> written to when no drive is attached.  This means bracketing the SRST
>> sequence to first do a PCS detection before permitting the SRST.
>> If "ctl" is accessed with no drive attached, the machine locks up hard.
> 
> At least for PATA you probably need to disable IORDY handshaking before
> the reset and probe.
..

Perhaps, but this was for SATA.
I don't even own any PATA disks nowadays.. other than a couple
that are buried inside USB/Firewire enclosures.   My last bare PATA
drive died this morning, while testing a SATA bridge on it.

That drive was one of the infamous IBM DeathStar series from early
in the decade.  R.I.P.  Or pieces, actually.  The platters make
great unbreakable "camping mirrors".  :)

Cheers
