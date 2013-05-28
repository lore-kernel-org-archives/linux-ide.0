From: Tejun Heo <tj@kernel.org>
Subject: Re: 88SE9172 additional PCI ID: 1b4b:9172
Date: Tue, 28 May 2013 09:22:34 +0900
Message-ID: <20130528002234.GB18531@mtj.dyndns.org>
References: <20130527233117.30056.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:64692 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758252Ab3E1AWv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 May 2013 20:22:51 -0400
Received: by mail-pa0-f49.google.com with SMTP id bi5so7212366pad.8
        for <linux-ide@vger.kernel.org>; Mon, 27 May 2013 17:22:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130527233117.30056.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: linux-ide@vger.kernel.org

On Mon, May 27, 2013 at 07:31:17PM -0400, George Spelvin wrote:
> On a Gigabyte X79-UP4 motherboard, which is documented as having
> 3x 88SE9172, lspci -nn gives me:
> 
> 05:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller [1b4b:9172] (rev 11)
> 06:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller [1b4b:9172] (rev 11)
> 07:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller [1b4b:9172] (rev 11)
> 08:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9123 PCIe SATA 6.0 Gb/s controller [1b4b:9123] (rev 11)
> 
> (The fourth is an expansion card I have pluggied into a PCIE x1 slot.)
> 
> drivers/ata/ahci.c lists:
> 	{ PCI_DEVICE(0x1b4b, 0x917a),
> 	  .driver_data = board_ahci_yes_fbs },	/* 88se9172 */
> 	{ PCI_DEVICE(0x1b4b, 0x9192),
> 	  .driver_data = board_ahci_yes_fbs },	/* 88se9172 on some Gigabyte */

I don't think it's a typo.

> Is that second one a typo, or do we need a third line for the 0x9172 PCI ID?
> For now, I have added the third line and it's mostly working.

And we'll need a separate entry

> (If I enable VT-d and the IOMMU, the devices are recognized but not the
> disks plugged into them, but I'm still working on figuring that out.)

when the device gets working.

Thanks!

-- 
tejun
