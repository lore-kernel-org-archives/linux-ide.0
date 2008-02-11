From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/9] libata: PCI device should be powered up before being
 accessed
Date: Mon, 11 Feb 2008 14:24:42 -0500
Message-ID: <47B0A0FA.6060003@garzik.org>
References: <12016853433196-git-send-email-htejun@gmail.com> <12016853434040-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56829 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756527AbYBKTYt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Feb 2008 14:24:49 -0500
In-Reply-To: <12016853434040-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, akira2.iguchi@toshiba.co.jp, leoli@freescale.com

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

Any objections, anyone?

I would like to merge this for 2.6.25, as it is IMO bug fixes.

	Jeff



