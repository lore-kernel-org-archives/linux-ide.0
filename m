From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC][DOC] writing IDE driver guidelines
Date: Sat, 15 May 2004 13:34:30 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040515173430.GA28873@havoc.gtf.org>
References: <200405151923.50343.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([216.162.42.101]:49064 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262388AbUEOReh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 May 2004 13:34:37 -0400
Content-Disposition: inline
In-Reply-To: <200405151923.50343.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Marc Singer <elf@buici.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, May 15, 2004 at 07:23:50PM +0200, Bartlomiej Zolnierkiewicz wrote:
> - do not believe in popular myth that driver code
>   can be of less quality than core kernel code

chuckle :)


> - don't copy without thinking ugly and bogus code
>   (there is still lot of such in IDE)

Agreed, but I think most driver authors will not know what is ugly
and bogus code, otherwise they would probably not copy it... (I hope!)


> - host drivers should request/release IO resource
>   themelves and set hwif->mmio to 2

Don't you mean, hwif->mmio==2 for MMIO hardware?


> - ide_init_hwif_ports() is obsolete and dying,
>   define IDE_ARCH_NO_OBSOLETE_INIT in <asm/ide.h>

hmmmm.  Please consider reversing this:

Make ide_init_hwif_ports() present _only_ if IDE_ARCH_OBSOLETE_INIT
is defined.

Then add that define for all arches that still use ide_init_hwif_ports().


> - define ide_default_irq(), ide_init_default_irq()
>   and ide_default_io_base() to (0)

Maybe provide generic definitions, so that new arches don't even
have to care about this?

	Jeff



