From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 01/15] ide: include <asm/ide.h> only when needed
Date: Thu, 5 Feb 2009 22:14:31 +0100
Message-ID: <200902052214.31483.bzolnier@gmail.com>
References: <20090201174916.19144.11318.sendpatchset@localhost.localdomain> <200902021927.25177.bzolnier@gmail.com> <20090204.232006.01916235.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:40866 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbZBEVeq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Feb 2009 16:34:46 -0500
In-Reply-To: <20090204.232006.01916235.anemo@mba.ocn.ne.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: geert@linux-m68k.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, apw@canonical.com

On Wednesday 04 February 2009, Atsushi Nemoto wrote:
> On Mon, 2 Feb 2009 19:27:25 +0100, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > > +#include <asm/ide.h>
> > > 
> > > Did you try checkpatch.pl?
> > 
> > Sure.
> > 
> > This driver uses stuff from <asm-mips/ide.h>.
> > 
> > [ I guess I could put '-mips' there to silence warnings on tx493{8,9}.c,
> >   however I don't know of the way to get rid of ide-io-std.c's one... ]
> 
> BTW, tx4939ide_{in,out}put_data_swap and
> tx4939ide_{in,out}put_data_swap do exactly same thing.
> 
> If byte-swapped version of ide_{in,out}put_data() were available by
> ide core, they can be used instead.  The byte-swapped version of
> default_tp_ops would much helps such queer big-endian platforms.  Is
> it worth to bloat ide core? ;-)

Seems to be a good idea and it may also help some other host drivers
(ide-h8300.c?).

Thanks,
Bart
