From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Enabling MSI on SATAII150
Date: Sun, 26 Jun 2005 23:54:59 -0400
Message-ID: <42BF7893.4050508@pobox.com>
References: <20050611021814.riaatwh8ztskw4g4@www.nucleodyne.com>	 <42AC6310.7030809@rtr.ca> <1118598197.25250.20.camel@driver>	 <42ACFFED.9050701@pobox.com> <1119834710.13331.654.camel@driver>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:50893 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261795AbVF0DzK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 23:55:10 -0400
In-Reply-To: <1119834710.13331.654.camel@driver>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kallol@nucleodyne.com
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Kallol Biswas wrote:
> Hello Jeff,
>           We have been using the sx8 driver on a MIPS based custom
> platform.
> It seems the line based interrupt mechanism is broken on the system.
> 
> SATA1150 controller supports MSI interrupt like other PCI-X devices.
> 
> Unfortunately we do not have access to the controller's technical
> specification yet.
> 
> Would it be possible to send us a reply detailing how to enable
> MSI interrupt on the adapter?

Just add pci_enable_msi() and pci_disable_msi() calls to the driver, 
much like drivers/scsi/ahci.c in 2.6.12-git8.

	Jeff



