From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: [PATCH] remove dead drivers/ide/ppc/swarm.c
Date: Tue, 4 May 2004 16:21:28 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.55.0405041452090.32082@jurand.ds.pg.gda.pl>
References: <200405040134.22092.bzolnier@elka.pw.edu.pl>
 <20040504111902.GA14240@linux-mips.org> <200405041428.50592.bzolnier@elka.pw.edu.pl>
 <20040504124349.GA15664@linux-mips.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:61092 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S263611AbUEDOVa
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 May 2004 10:21:30 -0400
In-Reply-To: <20040504124349.GA15664@linux-mips.org>
List-Id: linux-ide@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 4 May 2004, Ralf Baechle wrote:

> > While at swarm.c ...
> > 
> > > * Boards with SiByte processors so far have supported IDE devices via
> > > * the Generic Bus, PCI bus, and built-in PCMCIA interface.  In all
> > > * cases, byte-swapping must be avoided for these devices (whereas
> > > * other PCI devices, for example, will require swapping).
> > 
> > Why does byte-swapping must be avoided for PCI IDE
> > but not for other PCI devices?
> 
> Simply a result of the way the IDE bus is hooked up to the generic bus of
> the Sibyte chip.  I'd have to research details if you're interested ...

 I suppose the comment is incorrect, at least for the PCI bus (the two
other kinds of attachments use GPIO, so they may well be
endian-independent).  The PCI and HT I/O space accesses are done via the
non-swapping address space, so data will appear as swapped in the
big-endian configuration of the system.

 I had a brief discussion on the hack last Summer with the author of the
code, but had no time to dig more deeply into it.  Now the author is gone,
but I'll have a look at it.  Don't hold your breath, though.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
