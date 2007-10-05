From: "Martin K. Petersen" <mkp@mkp.net>
Subject: Re: [PATCH] pata_cs5536: ATA driver for Geode companion chip (MSR)
Date: Fri, 05 Oct 2007 15:00:50 -0400
Message-ID: <yq1hcl575el.fsf@sermon.lab.mkp.net>
References: <20071003233012.GA8721@cosmic.amd.com>
	<yq1przva76x.fsf@sermon.lab.mkp.net>
	<20071004165819.003b86c6@the-village.bc.nu>
	<20071004160834.GA28667@cosmic.amd.com>
	<yq13awq857h.fsf_-_@sermon.lab.mkp.net>
	<20071005130127.6165e2e3@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jaguar.mkp.net ([192.139.46.146]:56478 "EHLO jaguar.mkp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754832AbXJETAv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Oct 2007 15:00:51 -0400
In-Reply-To: <20071005130127.6165e2e3@the-village.bc.nu> (Alan Cox's message of "Fri\, 5 Oct 2007 13\:01\:27 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jordan Crouse <jordan.crouse@amd.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> pata_cs5536.c relies on Geode Machine Specific Registers to
>> configure the ATA function and uses the correct PIO timings for the
>> chip.

Alan> Any reason for not supporting both methods ? Though I guess as
Alan> you say msr is sufficient.

Given that we don't have a good way to detect failure other than
libata failing to set PIO timings, I think it's going to be
unnecessary complexity.  As I wrote, the BIOS versions all behaved
differently (in a previous rev. the written value would look ok in the
PCI config register but not trickle back to MSR space).

In any case the friendly firmware fairy left me a working BIOS this
morning.  Byte-aligned PCI config space accesses do the right thing.
So as far as I'm concerned the case has been solv-ed.  I'm now
officially agnostic.

Jordan: You're probably dealing with issues like this more frequently
than we are.  What's your preference for pata_cs5536.c?  MSR or PCI?

-- 
Martin K. Petersen      http://mkp.net/
