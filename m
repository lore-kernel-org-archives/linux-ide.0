From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Fri, 12 Aug 2005 09:40:12 +0100
Message-ID: <1123836012.22460.16.camel@localhost.localdomain>
References: <200508111424.43150.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:20932 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750709AbVHLI3Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Aug 2005 04:29:16 -0400
In-Reply-To: <200508111424.43150.bjorn.helgaas@hp.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org

On Iau, 2005-08-11 at 14:24 -0600, Bjorn Helgaas wrote:
> IA64 boxes only have PCI IDE devices, so there's no need to blindly poke
> around in I/O port space.  Poking at things that don't exist causes MCAs
> on HP ia64 systems.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Nak-by: Alan Cox <alan@redhat.com>

Assuming all IA-64 boxes are PCI or better then you actually want to
edit include/asm-ia64/ide.h and edit ide_default_io_base where someone
years ago cut and pasted x86-32 values so that case 2-5 are removed.
Then you will just probe the compatibility mode PCI addresses for system
IDE channels.


