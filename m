From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [RFC] Read/Write Buffer support
Date: Sat, 15 Mar 2008 11:49:29 -0600
Message-ID: <20080315174929.GY613@parisc-linux.org>
References: <20080315153730.GX613@parisc-linux.org> <47DC04CD.7060209@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:33931 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbYCORtq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Mar 2008 13:49:46 -0400
Content-Disposition: inline
In-Reply-To: <47DC04CD.7060209@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Sat, Mar 15, 2008 at 01:18:05PM -0400, Jeff Garzik wrote:
> >+	local_irq_save(flags);
> >+
> >+	buflen = ata_scsi_rbuf_get(cmd, &rbuf);
> >+
> >+	memset(rbuf, 0, buflen);
> >+	rbuf[0] = desc ? 0xff : 0x0;
> >+	rbuf[1] = 0x0;
> >+	rbuf[2] = 0x2;
> >+	rbuf[3] = 0x0;
> >+
> >+	ata_scsi_rbuf_put(cmd, rbuf);
> >+
> >+	local_irq_restore(flags);
> >+}
> 
> use ata_scsi_rbuf_fill() rather than recreating it manually

ata_scsi_rbuf_fill() calls args->done(cmd).  Now, I can split the common
part of ata_scsi_rbuf_fill into a different function if you'd like, but
see below.

> >+	/* XXX: fewer than 4 bytes in the page?  Doomed. */
> >+	sg->offset += 4;
> >+	sg->length -= 4;
> 
> I'm quite uncomfortable skipping any amount of validation.

Two things ... first, this is just a cheesy hack.  I'd like (but I don't
see) a generic way to say "I've filled in the first N bytes of this
scatterlist, please adjust and continue".  That's something that should
go in lib/scatterlist.c, IMO.

Second, and more seriously, libata already makes much worse assumptions
than this about scatterlists; it's just that the person who wrote them
didn't know it (or didn't flag it).  Look at the simulation of an
INQUIRY, for example.  It calls:

        ata_scsi_rbuf_fill(&args, ata_scsiop_inq_std);

which does:

        buflen = ata_scsi_rbuf_get(cmd, &rbuf);
	rc = actor(args, rbuf, buflen);

ata_scsi_rbuf_get() does:

        buf = kmap_atomic(sg_page(sg), KM_IRQ0) + sg->offset;
	buflen = sg->length;

ata_scsiop_inq_std() (before it checks buflen) does:

        memcpy(rbuf, hdr, sizeof(hdr));

So if a user can persuade the kernel to do an SG transfer directly to
userspace and sets up the address one byte before the end of the page,
they can persuade libata to write 4 bytes into the page after KM_IRQ0.
Which is probably hard to exploit in a meaningful way, but could
certainly cause crashes and/or corruption.

> Style in libata is "FIXME" or "TODO" not "XXX".  Please help with 
> consistency, it makes grepping easier.

Fine by me.

> Plus, I dunno about you, but I'm not a porn star :)

Matthew "Spankalicious" Wilcox.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
