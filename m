From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: RFC: Compact Flash True IDE Mode Driver
Date: Tue, 14 Feb 2006 16:58:11 +0000
Message-ID: <1139936291.10394.47.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0602010113210.5670-100000@gate.crashing.org>
	 <58cb370e0602130235h3ab521cep47584ee634e8fc7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:3217 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422649AbWBNQzE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Feb 2006 11:55:04 -0500
In-Reply-To: <58cb370e0602130235h3ab521cep47584ee634e8fc7f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Kumar Gala <galak@kernel.crashing.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Llu, 2006-02-13 at 11:35 +0100, Bartlomiej Zolnierkiewicz wrote:
> > +static void cfide_outsl(unsigned long port, void *addr, u32 count)
> > +{
> > +       panic("outsl unsupported");
> > +}
> 
> This will panic as soon as somebody tries to enable 32-bit I/O
> using hdparm.  Please add ide_hwif_t.no_io_32bit flag and teach
> ide-disk.c:ide_disk_setup() about it (separate patch).

Seems a lot of effort for little reward. Just make cfide_outsl generate
word sized I/O instead. Ditto insl. Or even leave the panic. Only
superusers can hack around with that value and they can equally crash
the box a thousand other ways.

Alan

