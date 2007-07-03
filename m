From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc7] libata: fix assigned IRQ reporting
Date: Tue, 03 Jul 2007 10:07:15 -0400
Message-ID: <468A5813.4040608@garzik.org>
References: <20070702163847.GV29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60186 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753742AbXGCOHR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 10:07:17 -0400
In-Reply-To: <20070702163847.GV29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> host->irq and host->irq2 should be set before ata_host_register() for
> IRQ reporting to work.  Move up host->irq assignment in
> ata_host_activate() and add it to ata_pci_init_one() native path and
> pata_cs5520.
> 
> The port info printing in ata_host_register() doesn't fit all the
> different controllers.  It should probably be moved out to LLDs with
> some helpers in the future.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    6 +++---
>  drivers/ata/libata-sff.c  |    5 +++--
>  drivers/ata/pata_cs5520.c |    5 +++++
>  3 files changed, 11 insertions(+), 5 deletions(-)

applied


