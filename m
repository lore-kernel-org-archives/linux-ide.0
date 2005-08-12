From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.12.3] PCI/libata INTx cleanup
Date: Fri, 12 Aug 2005 17:30:24 -0400
Message-ID: <42FD14F0.5030500@pobox.com>
References: <20050803204709.8BA0720B06@lns1058.lss.emc.com> <42FBA08C.5040103@pobox.com> <20050812171043.CF61020E8B@lns1058.lss.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:10157 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750901AbVHLVac (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Aug 2005 17:30:32 -0400
In-Reply-To: <20050812171043.CF61020E8B@lns1058.lss.emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>

Brett Russ wrote:
> Jeff Garzik wrote:

>>Though there is nothing wrong with this patch, I would prefer a single 
>>function, pci_intx(), as found in drivers/scsi/ahci.c.

> Sounds like what I did, except for the naming change.  I did away with
> pci_disable_intx() and changed the names.  Look ok?


Nope.

<thinks, and checks something>  Ahhhhh.  You were looking at an older 
kernel.Nope.  Read the implementation I referenced, in ahci.c, from 
2.6.13-rc6.  It takes a second argument:

	static void pci_intx(struct pci_dev *pdev, int enable)

Regards,

	Jeff


