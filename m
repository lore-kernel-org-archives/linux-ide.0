From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
Date: Mon, 4 Dec 2006 13:56:46 +0100 (MET)
Message-ID: <20061204125646.GA28600@aepfle.de>
References: <20061130165202.GA23205@aepfle.de>
 <20061204123854.GA28159@aepfle.de>
 <FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:18810 "EHLO
	mo-p07-ob.rzone.de") by vger.kernel.org with ESMTP id S1758764AbWLDM4x
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Dec 2006 07:56:53 -0500
Content-Disposition: inline
In-Reply-To: <FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On Mon, Dec 04, Segher Boessenkool wrote:

> >--- a/arch/powerpc/kernel/pci_64.c
> >+++ b/arch/powerpc/kernel/pci_64.c
> >@@ -1234,6 +1234,14 @@ static void __devinit fixup_resource(str
> > 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> > 	unsigned long start, end, mask, offset;
> >
> >+	/*
> >+	 * tell the core code that this ressource is unassigned
> >+	 * fixes p630 winbond IDE with libata
> >+	 */
> >+	if (res->start == 0) {
> >+		res->flags = 0;
> >+		return;
> >+	}
> > 	if (res->flags & IORESOURCE_IO) {
> > 		offset = (unsigned long)hose->io_base_virt - pci_io_base;
> 
> Please make this run on pSeries only; on a PowerMac for

I could just match for winbond an start == 0.
