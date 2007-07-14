From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] libata: use ->proto_mask in drivers
Date: Sat, 14 Jul 2007 09:56:38 +0100
Message-ID: <20070714095638.6e34794e@the-village.bc.nu>
References: <20070714081526.GA26878@havoc.gtf.org>
	<20070714081728.GB27006@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48333 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751708AbXGNIuJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jul 2007 04:50:09 -0400
In-Reply-To: <20070714081728.GB27006@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Sat, 14 Jul 2007 04:17:28 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> 
> Review definitely helps here...

Without knowing what the precise semantics are that is hard. Every
SFF_DMA case may not be supporting DMA depending upon the configuration
so it should probably be set by ata_pci_init_one for all the normal SFF
devices.

Thus I would say
- Drop every user of ata_pci_init_one from the patch

in ata_pci_init_one set it to SFF
in ata_pci_init_bmdma set it to SFF + DMA on success

and while we are at it this would nicely fix your TODO in
ata_pci_init_bmdma by testing the class when copying the modes over.

Alan
