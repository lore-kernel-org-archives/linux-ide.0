From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: devres and requesting resources
Date: Fri, 29 Feb 2008 13:55:56 +0000
Message-ID: <20080229135556.6eafe4aa@core>
References: <47C75392.3020606@garzik.org>
	<20080229112651.5b2a7f6f@core>
	<47C7F664.5040102@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50711 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754011AbYB2OGx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Feb 2008 09:06:53 -0500
In-Reply-To: <47C7F664.5040102@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

> Only rare PCI devices are shareable among multiple drivers.

Really. Let me see
	AGP & EDAC
	Serial/Parallel combo ports
	MPIIX
	CS5520
	Lots of I2C bus stuff
	VGA v 3D

There are quite a few, and some are already quite fun enough with our pci
struct model.

> sata_* at least intentionally used pci_request_regions() because it is 
> obvious from the hardware spec that multiple regions accessed by 
> multiple drivers is highly unlikely, without the driver being 
> specifically coded to support such sharing.  Such sharing code is far 
> beyond simple resource reservation, to avoid stepping on toes when there 
> is a single MMIO region and set of interrupt clearing registers.
> 
> So reading your email it sounds like there are valid cases for both 
> configurations.
> 
> Its a design choice either way, not a bug either way.

It is a flaw: devres that assumes it should grab all resources is unusable
for some other drivers - it is no longer generic and that makes it far
less useful. I've got no problem with the idea of a devres way to say
"and I want it all, mine mine mine" but that should not be the only
behaviour.

Alan
