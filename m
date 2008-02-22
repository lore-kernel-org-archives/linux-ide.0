From: Mark Lord <liml@rtr.ca>
Subject: Re: ata-piix.c (and libata.ko) in RHEL5.1 (build 78 currently) -
 this kernel is 2.6.18 baqsed
Date: Fri, 22 Feb 2008 11:40:43 -0500
Message-ID: <47BEFB0B.9070808@rtr.ca>
References: <6853F62BE9A693419863D51D4554A9E3012BE92B@EXNA.corp.stratus.com> <20080222151010.GC30920@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4161 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbYBVQkp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Feb 2008 11:40:45 -0500
In-Reply-To: <20080222151010.GC30920@devserv.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>, jgarzik@pobox.com, "Petrakis, Peter" <Peter.Petrakis@stratus.com>, "Duval, Dan" <Dan.Duval@stratus.com>, "Dailey, Nate" <Nate.Dailey@stratus.com>, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Fri, Feb 22, 2008 at 09:52:45AM -0500, Richardson, Charlotte wrote:
>> There is a hack in its probe routine that disables this. I've disabled the hack and ran a long test of
>> hotplugs yesterday (added and removed a DVD drive connected to the ESB2 IDE - this is Intel
>> device 0x269E) for 26 cycles, and it all appears to function properly. There are other things that do
> 
> It ought to work fine for ICH4 or so and later (older ICH you can only warm
> plug). Be sure to test the released RHEL as I know the dev tree has completely
> broken all hot plug disk support and hangs a lot if you do. Jeff I assume
> knows the status of fixing that.
..

I've missed the front part of this thread, but from the above
message it sounds like somebody is trying to do hotplug on ICH4/5/6/.. 

Correct?

I have previously worked on ICH5 hotplug for a client.
The pieces that were needed there were:

1) Emulate SCR_STATUS reads by reading ICH5 PCS.
If it indicates drive presence, return 0x113 for SCR_STATUS,
otherwise return zero.

2) PCS seems to work fine for detecting *inserted* drives,
but does not find *removed* drives very well.  To get it to
see unplug events, We had to first clear the port bit in the PCS,
wait a usec, then write 0x0003 back into PCS.
Then poll PCS for drive present, typically 5-6usec, sometimes longer.
If not present, we're done.  Otherwise wait for drive !BUSY (~60msec).
Ugly as all can be, but it worked.

3) It is critical to ensure that the ATA "ctl" register is never
written to when no drive is attached.  This means bracketing the SRST
sequence to first do a PCS detection before permitting the SRST.
If "ctl" is accessed with no drive attached, the machine locks up hard.

Or at least that's what we were able to figure out in the time available.

What are you guys doing?

-ml
