From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC] Read/Write Buffer support
Date: Sat, 15 Mar 2008 18:48:03 -0400
Message-ID: <47DC5223.6080105@garzik.org>
References: <20080315153730.GX613@parisc-linux.org> <47DC04CD.7060209@garzik.org> <20080315174929.GY613@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54804 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752884AbYCOWsG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Mar 2008 18:48:06 -0400
In-Reply-To: <20080315174929.GY613@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-ide@vger.kernel.org

Matthew Wilcox wrote:
> On Sat, Mar 15, 2008 at 01:18:05PM -0400, Jeff Garzik wrote:
>>> +	local_irq_save(flags);
>>> +
>>> +	buflen = ata_scsi_rbuf_get(cmd, &rbuf);
>>> +
>>> +	memset(rbuf, 0, buflen);
>>> +	rbuf[0] = desc ? 0xff : 0x0;
>>> +	rbuf[1] = 0x0;
>>> +	rbuf[2] = 0x2;
>>> +	rbuf[3] = 0x0;
>>> +
>>> +	ata_scsi_rbuf_put(cmd, rbuf);
>>> +
>>> +	local_irq_restore(flags);
>>> +}
>> use ata_scsi_rbuf_fill() rather than recreating it manually
> 
> ata_scsi_rbuf_fill() calls args->done(cmd).  Now, I can split the common
> part of ata_scsi_rbuf_fill into a different function if you'd like, but
> see below.

No, you're right.  My bad:  rbuf_fill is for completely emulated 
commands, not translated commands.


> Second, and more seriously, libata already makes much worse assumptions
> than this about scatterlists; it's just that the person who wrote them
> didn't know it (or didn't flag it).  Look at the simulation of an
> INQUIRY, for example.  It calls:
[...]
> So if a user can persuade the kernel to do an SG transfer directly to
> userspace and sets up the address one byte before the end of the page,
> they can persuade libata to write 4 bytes into the page after KM_IRQ0.
> Which is probably hard to exploit in a meaningful way, but could
> certainly cause crashes and/or corruption.

You arrived at the proper conclusion -- it doesn't happen in practice 
for a variety of reasons, the main one being that it's largely in the 
realm of something the superuser must do intentionally, the way kernel 
and userland code is written today.

Thus, the code intentionally avoids the silly complexity for a case that 
never truly happens outside of synthetic superuser experiments.

Remember, this and all the other code originated in the days of "if 
(use_sg)", when scatterlists were not used often for !(read|write) commands.


>> Style in libata is "FIXME" or "TODO" not "XXX".  Please help with 
>> consistency, it makes grepping easier.
> 
> Fine by me.
> 
>> Plus, I dunno about you, but I'm not a porn star :)
> 
> Matthew "Spankalicious" Wilcox.

<grin>

	Jeff


P.S.  I encourage others to investigate making the libata SCSI simulator 
an optional kernel module.

Long term, a preferred solution would be to use SCSI layer for ATAPI 
devices, and a kernel block device for ATA devices.

	Jeff



