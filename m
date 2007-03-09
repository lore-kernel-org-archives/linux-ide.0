From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 05/12] libata: convert legacy PCI host handling to new
 init model
Date: Fri, 09 Mar 2007 12:46:10 -0500
Message-ID: <45F19D62.1070809@garzik.org>
References: <11734389353821-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58232 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767446AbXCIRqN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 12:46:13 -0500
In-Reply-To: <11734389353821-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Convert legacy PCI host handling to alloc-init-attach model.
> ata_init_legacy_host(), ata_request_legacy_irqs() and
> ata_pci_init_bmdma() are separated out and follow the new init model.
> 
> The two legacy handling functions use separate ata_legacy_devres
> instead of generic devm_* resources.  This reduces devres overhead for
> legacy hosts which was a bit high because it didn't use PCI/iomap
> merged resoruces.
> 
> ata_pci_init_one() is rewritten in terms of the aboved functions but
> native mode handling is still using the old method.  Conversion will
> be completed when native mode handling is updated.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-sff.c |  436 +++++++++++++++++++++++++++++++++-------------
>  1 files changed, 312 insertions(+), 124 deletions(-)

ACK patches 5-12


