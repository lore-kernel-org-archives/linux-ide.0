From: Alan Cox <alan@linux.intel.com>
Subject: Re: piix vs ata_piix device ID tables
Date: Mon, 4 Oct 2010 10:21:45 +0100
Message-ID: <20101004102145.2f34cc62@linux.intel.com>
References: <1286164252.3916.312.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39606 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754333Ab0JDKL2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Oct 2010 06:11:28 -0400
In-Reply-To: <1286164252.3916.312.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: David Miller <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Mon, 04 Oct 2010 04:50:52 +0100
Ben Hutchings <ben@decadent.org.uk> wrote:

> When I converted the Debian kernel configurations over from IDE to
> libata-based drivers, I compared the device ID tables for all the PCI
> drivers.  I found that ata_piix handles most of the same devices as
> piix while pata_oldpiix and pata_mpiix each handle one more.
> However, 2 device IDs in piix are not in the device ID tables of any
> libata-based driver:
> 
> PCI_DEVICE_ID_INTEL_82371FB_0 == 0x122e (PIIX function 0)
> 
> piix seems to treat this the same as PCI_DEVICE_ID_INTEL_82371FB_1 ==
> 0x1230, which is handled by pata_oldpiix.  (This is weird; function 0
> is supposed to be the ISA bridge!)

Given that pre PIIX3 devices (MPIIX and PIIX original) never worked in
the old IDE code (well sometimes semi-worked by accident because the
BIOS values were right and they didn't break anything) I wouldn't draw
any conclusions.

> PCI_DEVICE_ID_INTEL_82801DB_1 == 0x24c1 (ICH4 device 31 function 1)
> 
> piix seems to treat this the same as most other ICH PATA interfaces,
> which are handled by ata_piix.
> 
> Does anyone know why these aren't handled by the libata-based drivers?

I don't know about 0x24C1 however it isn't listed in the Intel ICH
programming manual so given we've also had no reports about it I
suspect it's an error in the PIIX driver ?

Alan
