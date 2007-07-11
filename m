From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH libata-dev#upstream] libata: simplify PCI legacy SFF host
 handling
Date: Tue, 10 Jul 2007 21:38:03 -0400
Message-ID: <4694347B.2030700@garzik.org>
References: <468B620F.3010603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37639 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753506AbXGKBiH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 21:38:07 -0400
In-Reply-To: <468B620F.3010603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> With PCI resource fix up for legacy hosts.  We can use the same code
> path to allocate IO resources and initialize host for both legacy and
> native SFF hosts.  Only IRQ requesting needs to be different.
> 
> Rename ata_pci_*_native_host() to ata_pci_*_sff_host(), kill all
> legacy specific functions and use the renamed functions instead.  This
> simplifies code a lot.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
> Gee, I like it.  The BAR fixup thing was a really good idea.  :-)
> 
>  drivers/ata/libata-core.c |    4 
>  drivers/ata/libata-sff.c  |  288 +++++-----------------------------------------
>  drivers/ata/sata_nv.c     |    2 
>  drivers/ata/sata_sis.c    |    2 
>  drivers/ata/sata_uli.c    |    2 
>  drivers/ata/sata_via.c    |    2 
>  include/linux/libata.h    |    8 -
>  7 files changed, 42 insertions(+), 266 deletions(-)

applied


