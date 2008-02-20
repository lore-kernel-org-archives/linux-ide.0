From: Mark Lord <mlord@pobox.com>
Subject: Re: What's needed for PMP support?
Date: Wed, 20 Feb 2008 14:03:43 -0500
Message-ID: <47BC798F.6070900@pobox.com>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com>
 <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rune.pobox.com ([208.210.124.79]:45509 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbYBTTDt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Feb 2008 14:03:49 -0500
In-Reply-To: <4738F935.1000708@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
>
> The following things are needed for a LLD to support PMP.
..
> I think that's about it.  Feel free to ask if something isn't clear.
..

Tejun, I've added PMP to sata_mv, and am now trying to get it
to work with a Marvell PM attached.

And the behaviour I see is very bizarre.

After hard+soft resets, the PM signature is found,
and libata interrogates the PM registers.

It successfully reads register 0, and then register 1.
But all subsequent registers read out (incorrectly) as zeros.

I've traced the taskfiles in/out, and it all looks proper
except for the actual data coming back from the PM.

After some experimentation, I found that all of the PM registers
were readable, if I simple inserted a  sata_pmp_read(link, 0, &junk)
in front of each issue of sata_pmp_read(link, reg, &r_val).

Then the PM is recognized and all, but fails port enumerations
probably due to either my hack or the same original bug (whatever that is?)

I'm confused.

The PM itself works fine here on sata_sil24 and AHCI(jmicron),
so it's obviously the sata_mv driver or chipset that's being weird.

Ever seen anything like this before?
I'm trying to use stock libata functions for all of this where possible,
so there's not really that much new/necessary code in sata_mv for this.
I do force the PMP value for outgoing-FIS's (non standard register for it),
but that's about all that's custom here.

The driver uses ATA register mode emulation for all commands
other than READ/WRITE disk stuff, including for the PM register accesses.

Ever seen anything like this before?

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
