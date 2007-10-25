From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: ahci: implement workaround for ASUS P5W-DH Deluxe
 ahci_broken_hardreset(), take #2
Date: Thu, 25 Oct 2007 02:07:17 -0400
Message-ID: <47203295.9010004@garzik.org>
References: <20071025055916.GG11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51546 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbXJYGHT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 02:07:19 -0400
In-Reply-To: <20071025055916.GG11853@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> P5W-DH Deluxe has ICH9 which doesn't have PMP support but SIMG 4726
> hardwired to the second port of AHCI controller at PCI device 1f.2.
> The 4726 doesn't work as PMP but as a storage processor which can do
> hardware RAID on downstream ports.
> 
> When no device is attached to the downstream port of the 4726, pseudo
> ATA device for configuration appears.  Unfortunately, ATA emulation on
> the device is very lousy and causes long hang during boot.
> 
> This patch implements workaround for the board.  If the mainboard is
> P5W-DH Deluxe (matched using DMI), only hardreset is used on the
> second port of AHCI controller @ 1f.2 and the hardreset doesn't depend
> on receiving the first FIS and just proceed to IDENTIFY.
> 
> This workaround fixes bugzilla #8923.
> 
>   http://bugzilla.kernel.org/show_bug.cgi?id=8923
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Okay, here's improved version.  p5wdh hardreset is sufficiently
> different from vt8251, so it now has its own hardreset and ops.  It
> now also has two secs + 150ms delay after hardreset so that devices
> which are slow to respond after hardreset don't fail.  Most devices
> will respond in time unless it's spinning up.  Spin up is handled by
> reset retrials.  Also, it sets BSY before initiating BSY and performs
> CLO afterward if BSY isn't cleared during the wait.
> 
> Change from the first take are minor but make the workaoround fit the
> problem better.  Tested on a setup which behaves the same way as
> P5W-DH (non-PMP capable ICH AHCI + SIMG 4726) with some number of
> harddrives and ATAPI devices.  Everything including hotplug works
> fine.
> 
>  drivers/ata/ahci.c |  144 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 144 insertions(+)

applied


