From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Early ATA devices
Date: Wed, 1 Aug 2007 16:31:16 +0100
Message-ID: <20070801163116.57dbac1d@the-village.bc.nu>
References: <20070801014137.4ab39e94@the-village.bc.nu>
	<46B08F05.9080306@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32902 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758774AbXHAPYJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 11:24:09 -0400
In-Reply-To: <46B08F05.9080306@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Wed, 01 Aug 2007 09:47:49 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Alan Cox wrote:
> > #1	We assume identify works. Early ATA actually lists this command
> > as optional
> 
> ITYM we assume identify command exists on the device?
> 
> We certainly do not assume IDENTIFY command, if exists, succeeds.

We assume that it exists and that it will succeed. In any other situation
we skip the device.
 
> What is the proper probing method -- notice if command-aborted is 
> returned and do something from there?

Yes. A good question is what as we then don't know geometry. I know
understand how PC BIOS geometry reporting works in detail so one option
is to write a drivers/firmware/pc_geometry.c library which knows how to
handle this crap for us. Thankfully any even prehistoric might still boot
Linux PC should have EDD2.0 and anything older we care about FDPT tables.

We'd end up with an API something like

	int pcgeo_get_geometry_isa(ioport, devno, struct ...)
	int pcgeo_get_geometry_pci(pci_dev, devno, ....)

which means we can also push user configuration of geometry into that
module and share it between hd, oldide, old scsi, whatever.

[and this stuff is more screwed up than IDE ...]

> > #2	We don't allow for INIT_DEV_PARAMS failing which it may do on
> > some early IDE pre ATA devices
> 
> Suggested handling?  Ignore device, since we don't know what state its 
> in, if this fails?

I stuck a test patch in my tree and emulating this sequence it works to
just skip the aborted command. A drive which lacks this is fixed geometry
so the geometry we want to set is already set and a failure is
meaningless (which is different to an early ATA drive which may have
multiple emulated geometries).

Alan
