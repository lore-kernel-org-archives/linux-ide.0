From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 01/15] ide: include <asm/ide.h> only when needed
Date: Sun, 08 Feb 2009 00:35:36 +0900 (JST)
Message-ID: <20090208.003536.72707389.anemo@mba.ocn.ne.jp>
References: <498B7D09.6040100@ru.mvista.com>
	<200902061721.46813.bzolnier@gmail.com>
	<498CB3CF.8070306@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:53361 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684AbZBGPfk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Feb 2009 10:35:40 -0500
In-Reply-To: <498CB3CF.8070306@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: bzolnier@gmail.com, geert@linux-m68k.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, apw@canonical.com

On Sat, 07 Feb 2009 01:03:59 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > config CONFIG_IDE_BE_IO
> > 	bool
> 
>     If it was that simple... Normally the BE case gets handled automagically 
> (moreover, there is MIPS option that additionally controls I/O and memory 
> space byte swapping). The case we have to address for TX493x is actually where 
> the usual magic fails (or actually the code just doesn't want to use that 
> option). So this doesn't look like a good name to me...

Well, for TX493x (MIPS), we have CONFIG_SWAP_IO_SPACE for big endian
and it works fine for PCI-IDE host controllers.  For SoC internal
controllers, no swapping is needed for both endian, thus custom tp_ops
is needed only for big endian.

So ... IDE_BE_IO looks actually not best name for this case.  It is
IDE_RAW_IO or something.  But IDE_RAW_IO might not fit for other
cases.  IDE_SWAPPED_IO?  Any other good name?

---
Atsushi Nemoto
