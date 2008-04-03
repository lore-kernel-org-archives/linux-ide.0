From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Thu, 3 Apr 2008 18:50:34 +0100
Message-ID: <20080403185034.759022ce@the-village.bc.nu>
References: <200804021524.27222.elendil@planet.nl>
	<200804022210.26736.linux@rainbow-software.org>
	<20080402202225.GJ24237@csclub.uwaterloo.ca>
	<200804022235.01433.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46918 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750960AbYDGUx6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Apr 2008 16:53:58 -0400
In-Reply-To: <200804022235.01433.linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Frans Pop <elendil@planet.nl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Wed, 2 Apr 2008 22:34:58 +0200
Ondrej Zary <linux@rainbow-software.org> wrote:

> On Wednesday 02 April 2008 22:22:25 Lennart Sorensen wrote:
> > On Wed, Apr 02, 2008 at 10:10:23PM +0200, Ondrej Zary wrote:
> > > I mean S320BIDE.EXE - that's for this machine only.
> >
> > Hmm, I missed that one.  I wonder how they do it.  Well ISA did support
> > bus mastering DMA although it seems rare to implement it.  Or it could
> > be VLB style.
> 
> I suspect that the IDE controller is integrated into the Toshiba chipset but 
> does not appear as a separate PCI device. It could be controlled by some 
> registers of the "host-bridge" or some other device.

Toshiba Piccolo series. PCI chipset integrated IDE, not supported as
Toshiba refused to even answer emails about it. If you want it to work
you need to find out what registers their driver writes to

Alan
