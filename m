From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH libata-dev#upstream-fixes] libata: PCI device should be
 powered up before being accessed
Date: Mon, 17 Mar 2008 08:24:32 -0400
Message-ID: <47DE6300.4070004@garzik.org>
References: <47D667DA.8050905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47500 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753238AbYCQMYf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Mar 2008 08:24:35 -0400
In-Reply-To: <47D667DA.8050905@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> PCI device should be powered up or powered up before its PCI regsiters
> are accessed.  Although PCI configuration register access is allowed
> in D3hot, PCI device is free to reset its status when transiting from
> D3hot to D0 causing configuration data to change.
> 
> Many libata SFF drivers which use ata_pci_init_one() read and update
> configuration registers before calling ata_pci_init_one() which
> enables the PCI device.  Also, in resume paths, some drivers access
> registers without resuming the PCI device.
> 
> This patch adds a call to pcim_enable_device() in init path if
> register is accessed before calling ata_pci_init_one() and make resume
> paths first resume PCI devices, access PCI configuration regiters then
> resume ATA host.
> 
> While at it...
> 
> * cmd640 was strange in that it set ->resume even when CONFIG_PM is
>   not.  This is by-product of minimal build fix.  Updated.
> 
> * In cs5530, Don't BUG() on reinit failure.  Just whine and fail
>   resume.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/pata_ali.c         |   14 +++++++++++++-
>  drivers/ata/pata_amd.c         |   16 +++++++++++++++-
>  drivers/ata/pata_artop.c       |    5 +++++
>  drivers/ata/pata_cmd640.c      |   21 ++++++++++++++++-----
>  drivers/ata/pata_cmd64x.c      |   15 ++++++++++++++-
>  drivers/ata/pata_cs5520.c      |   15 ++++++++++++++-
>  drivers/ata/pata_cs5530.c      |   18 ++++++++++++++++--
>  drivers/ata/pata_hpt366.c      |   14 +++++++++++++-
>  drivers/ata/pata_hpt37x.c      |    5 +++++
>  drivers/ata/pata_hpt3x2n.c     |    5 +++++
>  drivers/ata/pata_it821x.c      |   14 +++++++++++++-
>  drivers/ata/pata_netcell.c     |    5 +++++
>  drivers/ata/pata_ns87415.c     |    6 ++++++
>  drivers/ata/pata_optidma.c     |    5 +++++
>  drivers/ata/pata_serverworks.c |   19 ++++++++++++++++---
>  drivers/ata/pata_sil680.c      |   13 +++++++++++--
>  drivers/ata/pata_sis.c         |    6 +++++-
>  drivers/ata/pata_sl82c105.c    |    5 +++++
>  drivers/ata/pata_via.c         |   14 +++++++++++++-
>  19 files changed, 195 insertions(+), 20 deletions(-)

Did Alan ACK this?

Can this wait until 2.6.26, or is it important for 2.6.25?


