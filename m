From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Promise SATA TX4 300 port timeout with sata_promise in 2.6.22, kernel panic in 2.6.23
Date: Mon, 12 Nov 2007 11:25:41 +0100 (MET)
Message-ID: <200711121025.lACAPf3S017955@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:42910 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756939AbXKLKZr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Nov 2007 05:25:47 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, i.d.stratford@gmail.com
Cc: linux-ide@vger.kernel.org, mikpe@it.uu.se

On Mon, 12 Nov 2007 13:12:19 +0900, Tejun Heo wrote:
>I Stratford wrote:
>> The purpose of the mail is to document and share my experience in the
>> hope that someone might find it useful, either for debugging their own
>> TX4 300-centric system issues or figuring out what is up with
>> sata_promise and the TX4 300 in 3Gbps mode. I also wish to offer my
>> somewhat unique promise-based system as a test environment for either
>> the timeout or kernel panic issues. I obviously have some basic need
>> for data integrity of the RAID5, but this system is not in production
>> and is therefore more available for testing purposes than the average
>> machine with 22 Promise SATA ports..  :)
>
>[cc'ing Mikael Pettersson]
>
>It seems those 3Gbps promise controllers have hard time getting out of
>transmission errors.  Is it because hardreset doesn't work?  Can we fix it?
>
>Also, if 3Gbps can't be made reliable on those controllers, how about
>limiting it to 1.5Gbps by default with appropriate warning messages?
>Without PMP, it's not like we're gonna earn anything by driving the
>thing at 3Gbps.

There are two things going on here:

First, a workaround for a HW erratum affecting 2nd-generation
chips like the SATA300 TX4 was included in kernel 2.6.24-rc2.
Outstanding bug reports for 2nd-generation chips in older kernels
are not unlikely to be related to this erratum, so we should not
butcher the driver because of issues reported against old kernels.

Secondly, Stratford's system is seriously overloaded:
- a desktop mainboard
- worked with 6 mainboard and 8 Promise 150 TX4 ports
- problems began when two Promise 300 TX4 cards and
  more disks were added
On several occasions we've traced people's problems to
overtaxed system components (cooling, PSU, PCI busses).
OTOH, it may be that Stratford's problem is directly related
to the HW erratum, in which case 2.6.24-rc2 should solve it.

/Mikael
