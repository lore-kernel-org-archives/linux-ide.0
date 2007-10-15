From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] drivers/ata: add support to Freescale 3.0Gbps SATA Controller
Date: Mon, 15 Oct 2007 13:45:06 +0200
Message-ID: <200710151345.07515.arnd@arndb.de>
References: <2A6F278C5B66C4459AF4013E77A40CD3FCBB59@zin33exm20.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.179]:62232 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756812AbXJOLpQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Oct 2007 07:45:16 -0400
In-Reply-To: <2A6F278C5B66C4459AF4013E77A40CD3FCBB59@zin33exm20.fsl.freescale.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kalra Ashish-B00888 <ashish.kalra@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Li Yang-r58472 <LeoLi@freescale.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Monday 15 October 2007, Kalra Ashish-B00888 wrote:
> Thanks for your comments and feedback.
> 
> Actually, for PowerPC platforms iowrite32/ioread32 internally call
> writel/readl, which are again mapped to out_le32/in_le32,

This is correct on 6xx and e500 for now, but it's a little more
complicated than that in general:

iowriteXX/ioreadXX are either the simple readX/writeX wrappers
from arch/powerpc/kernel/iomap.c, or the more complex functions
from lib/iomap.c, depending on whether any of the active platforms
has set CONFIG_PPC_INDIRECT_IO.

writeX/readX can either map directly to out_leXX/in_leXX, or do
something more complicated, again depending on the platform.
In general, writeX/readX may need to consider PCI specific error
handling or synchronization requirements, while out_leXX/in_leXX
are low-level accessors that should only be used by device drivers
when they are used on directly connected (non-PCI) devices.

Since iowriteXX/ioreadXX is supposed to be the most generic
variant covering both PCI MMIO (writeX/readX) and PCI PIO
(outX/inX) transfers, it would make sense to extend them to
also do SOC MMIO (out_leXX/in_leXX/out_beXX/in_beXX) and
DCR (dcr_write/dcr_read) accesses in the future.

	Arnd <><
