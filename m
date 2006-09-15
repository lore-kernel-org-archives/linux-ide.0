From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] piix: Use refcounted interface when searching for a
	450NX
Date: Fri, 15 Sep 2006 15:44:37 +0100
Message-ID: <1158331477.29932.69.camel@localhost.localdomain>
References: <1158329678.29932.41.camel@localhost.localdomain>
	 <450AB54F.5000905@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51132 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751516AbWIOOVI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Sep 2006 10:21:08 -0400
In-Reply-To: <450AB54F.5000905@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Ar Gwe, 2006-09-15 am 18:14 +0400, ysgrifennodd Sergei Shtylyov:
> > -	while((pdev=pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454NX, pdev))!=NULL)
> > +	while((pdev=pci_get_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454NX, pdev))!=NULL)
> >  	{
> >  		/* Look for 450NX PXB. Check for problem configurations
> >  		   A PCI quirk checks bit 6 already */
> 
>     Shouldn't pci_put_dev() be called after the bridge device no longer needed?
> I assume it's not needed anymore after this function is finished...

pci_get_device gets called repeatedly to walk each device. Each call
drops the reference to the previous device (the one passed in).


