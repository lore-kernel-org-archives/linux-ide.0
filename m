From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 01/15] ide: include <asm/ide.h> only when needed
Date: Wed, 04 Feb 2009 23:20:06 +0900 (JST)
Message-ID: <20090204.232006.01916235.anemo@mba.ocn.ne.jp>
References: <20090201174916.19144.11318.sendpatchset@localhost.localdomain>
	<Pine.LNX.4.64.0902020847410.11930@anakin>
	<200902021927.25177.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:57901 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688AbZBDOUG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Feb 2009 09:20:06 -0500
In-Reply-To: <200902021927.25177.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: geert@linux-m68k.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, apw@canonical.com

On Mon, 2 Feb 2009 19:27:25 +0100, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > +#include <asm/ide.h>
> > 
> > Did you try checkpatch.pl?
> 
> Sure.
> 
> This driver uses stuff from <asm-mips/ide.h>.
> 
> [ I guess I could put '-mips' there to silence warnings on tx493{8,9}.c,
>   however I don't know of the way to get rid of ide-io-std.c's one... ]

BTW, tx4939ide_{in,out}put_data_swap and
tx4939ide_{in,out}put_data_swap do exactly same thing.

If byte-swapped version of ide_{in,out}put_data() were available by
ide core, they can be used instead.  The byte-swapped version of
default_tp_ops would much helps such queer big-endian platforms.  Is
it worth to bloat ide core? ;-)

---
Atsushi Nemoto
