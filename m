From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PCI Constants Update for SATA Driver
Date: Sun, 27 Feb 2005 13:08:42 -0500
Message-ID: <42220CAA.90702@pobox.com>
References: <1109526163.19325.2.camel@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38855 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261489AbVB0SJC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Feb 2005 13:09:02 -0500
In-Reply-To: <1109526163.19325.2.camel@forge.intermeta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Henning Schmiedehausen <hps@intermeta.de>
Cc: Linux IDE Mailingliste <linux-ide@vger.kernel.org>

Henning Schmiedehausen wrote:
> Hi,
> 
> having the various constants in pci_ids.h is a really good thing for
> grepping through the kernel source. And if they were used, it would be
> even better (if you e.g. are looking for which driver claims an SIImage
> 3112 card...). However, the sata_xxx.c files in the drivers/scsi
> directory are notorious for not using the PCI Ids but just hard coded
> numbers.
> 
> This patch tries to fix this. It is against the 2.6.10 tree from Fedora
> Core 3 but should apply to a regular 2.6.10 too.

"Notorious", heh.  This is quite intentional.

PCI device ids are just random numbers that vendors pick out of thin 
air.  Device id symbolic constants have little value, and creates churn 
whereby every kernel hacker is patching include/linux/pci_ids.h.

	Jeff


