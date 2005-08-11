From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.12.3] PCI/libata INTx cleanup
Date: Thu, 11 Aug 2005 15:01:32 -0400
Message-ID: <42FBA08C.5040103@pobox.com>
References: <20050803204709.8BA0720B06@lns1058.lss.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:39335 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932367AbVHKTBi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 15:01:38 -0400
In-Reply-To: <20050803204709.8BA0720B06@lns1058.lss.emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>

Brett Russ wrote:
> Simple cleanup to eliminate X copies of the same function in libata.  
> Moved pci_enable_intx() to pci.c, added pci_disable_intx() as well, 
> and use them throughout libata and msi.c.
> 
> Signed-off-by: Brett Russ <russb@emc.com>

Though there is nothing wrong with this patch, I would prefer a single 
function, pci_intx(), as found in drivers/scsi/ahci.c.

Would you be willing to move that one to the PCI layer, eliminate the 
multiple copies of pci_enable_intx(), and replace the calls to 
pci_enable_intx() with calls to pci_intx() ?

	Jeff


