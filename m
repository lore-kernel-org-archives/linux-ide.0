From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: Add support for Long Logical Sectors and Long
 Physical Sectors
Date: Wed, 6 Aug 2008 10:06:47 +0100
Message-ID: <20080806100647.21529284@lxorguk.ukuu.org.uk>
References: <1217957207-23116-1-git-send-email-matthew@wil.cx>
	<1217957207-23116-3-git-send-email-matthew@wil.cx>
	<20080805214651.621263f5@lxorguk.ukuu.org.uk>
	<20080806022255.GC2055@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47726 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759627AbYHFJZd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Aug 2008 05:25:33 -0400
In-Reply-To: <20080806022255.GC2055@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com, Matt_Domsch@dell.com, Matthew Wilcox <willy@linux.intel.com>

On Tue, 5 Aug 2008 20:22:55 -0600
Matthew Wilcox <matthew@wil.cx> wrote:

> On Tue, Aug 05, 2008 at 09:46:51PM +0100, Alan Cox wrote:
> > > + * Some commands are specified to transfer (a multiple of) 512 bytes of data
> > > + * while others transfer a multiple of the number of bytes in a sector.  This
> > > + * function knows which commands transfer how much data.
> > 
> > 	static u32 ata_sector_or_block[]={...};
> > 
> > 	if (test_bit(tf->cmd, &ata_sector_or_block))
> > 
> > looks so much more elegant than a giant switch statement and I suspect
> > produces far better code
> 
> Probably ... I did consider it, but I think I was too influenced by the
> existing READ/WRITE LONG code.
> 
> > > + * ATA supports sector sizes up to 2^33 - 1.  The reported sector size may
> > > + * not be a power of two.  The extra bytes are used for user-visible data
> > > + * integrity calculations.  Note this is not the same as the ECC which is
> > > + * accessed through the SCT Command Transport or READ / WRITE LONG.
> > > + */
> > > +static u64 ata_id_sect_size(const u16 *id)
> > 
> > word 106 is not defined in early ATA standards so it would be wise to
> > check that ATA8 is reported by the drive - and trust the relevant bits
> > for ATA7/8 as appropriate.
> 
> I'm not sure that's necessary.  The spec says to check whether words are
> valid by doing the & 0xc000 == 0x4000 test.

What early spec says what state word 106 is in ? Healthy paranoia is a
good idea in the IDE world because its all a bit murky in the early days
and you get some quite strange ident data from early devices - one reason
for 0xC000 = 0x4000 is that some early drives use 0xFFFF for unknown words
for example!

> good migration path?  We could have the driver set a flag, or call into
> the driver from the midlayer to check whether it can cope with a
> particular sector size.

On the driver side I need to know so I can control the FIFO so I guess
knowing when you start/end planning to use large sector sizes. The driver
could do it per command but the cost is almost certainly not worth it as
I'd expect us to stick to a size. A driver method would do the trick
nicely if it could return -EOPNOTSUPP or similar.

Alan
