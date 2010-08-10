From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Tue, 10 Aug 2010 23:23:00 +0100
Message-ID: <20100810232300.2bb59ec2@linux.intel.com>
References: <20100810155559.7620.79711.stgit@localhost.localdomain>
	<4C61888D.4000806@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39561 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933536Ab0HJXAO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Aug 2010 19:00:14 -0400
In-Reply-To: <4C61888D.4000806@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

> > +static int is_intel_ider(struct pci_dev *dev)
> > +{
> > +	/* For Intel IDE the value at 0xF8 is only zero on IDE-R
> > +	   interfaces */
> 
>     Preferred style for multi-line comments is:

This driver uses the style I have throughout.

> > @@ -134,6 +173,10 @@ static int ata_generic_init_one(struct pci_dev
> > *dev, const struct pci_device_id if ((id->driver_data &
> > ATA_GEN_CLASS_MATCH) && all_generic_ide == 0) return -ENODEV;
> >  
> > +	if (id->driver_data && ATA_GEN_INTEL_IDER)
> 
>     I think you mean & here, rather than &&...

Oh yes most definitely, that would have unfortunate consequences.

Thanks
Alan
