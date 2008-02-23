From: Mark Lord <liml@rtr.ca>
Subject: Re: new ata_port_operations for .pmp_{read,write} ?
Date: Sat, 23 Feb 2008 00:15:50 -0500
Message-ID: <47BFAC06.5030805@rtr.ca>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BE17CA.6060406@rtr.ca> <47BE1833.9090501@rtr.ca> <47BE2C0C.3020801@gmail.com> <47BE2DBD.9010704@rtr.ca> <47BE2F9E.5040206@gmail.com> <47BE32B5.5020300@rtr.ca> <47BE3325.8060209@rtr.ca> <47BE4701.2030104@rtr.ca> <47BE4DFE.2030407@rtr.ca> <47BEDAF2.8000301@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3511 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbYBWFPw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Feb 2008 00:15:52 -0500
In-Reply-To: <47BEDAF2.8000301@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>, Jeff Garzik <jgarzik@pobox.com>

Mark Lord wrote:
> An alternative to all this, might be to expose the "select_pmp()"
> function shown in the sample code, and have libata-pmp.c call that,
> instead of having the new new .pmp_{read,write} functions. 
..

I wonder if this might be more viable than first thought.

Say the LLD, be it ata_piix or sata_mv or sata_svw, were to provide
an option ata_operations method for "select_pmp_port(pmp)",
which the core could invoke prior to any direct manipulation
of the shadow registers.

It would really only be needed in perhaps three or four places total
(eg. sata_pmp_read/write, and before writes to the ata "ctl" register).
This could be a reasonably tidy way for the core to keep the LLD
abreast of its intent when accessing things.

I really would like to keep the LLD code small, and have good solid
core routines for non-hardware specific functionality.  All of this stuff
I'm beginning to do with sata_mv would be trivial if I wanted to bloat
the LLD, but really.. only a tiny bit of it need be custom to sata_mv.

The existing SFF reset/probe/pmp stuff is just about exactly what
sata_mv needs.. and I feel a strong desire to not clone/duplicate
that hard-won functionality.

Much of it I can see being shared with other half-and-half chipset drivers
as we add PMP functionality to those.

Maybe that's just the embedded side me showing through?

It is tricky to define the right interfaces, though, as each chipset
does throw its own unique curve balls at us.

I may prototype this select_pmp_port() concept in sata_mv(),
and see how it works out (or not).

Cheers
