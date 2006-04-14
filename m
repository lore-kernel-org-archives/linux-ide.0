From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH] Fix a logic error in ahci_init_one()
Date: Fri, 14 Apr 2006 17:12:58 +0800
Message-ID: <1145005978.24774.14.camel@localhost.localdomain>
References: <1144999881.24774.9.camel@localhost.localdomain>
	 <443F6189.7050204@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6835 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S965125AbWDNJXr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Apr 2006 05:23:47 -0400
In-Reply-To: <443F6189.7050204@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Fri, 2006-04-14 at 04:47 -0400, Jeff Garzik wrote:
> zhao, forrest wrote:
> > Fix an bug in error handling, also variable
> > pci_dev_busy has no use, remove it.
> > 
> > Signed-off-by: Zhao Forrest <forrest.zhao@intel.com>
> 
> What logic error do you see?
> 
> pci_dev_busy has a clear use, as illustrated by the code:  if the PCI 
> regions are reserved by another device, the device is in use, therefore 
> we should avoid killing the device with pci_disable_device().
> 
> 	Jeff

Oh, one PCI device can be probed by multiple drivers. It's first
time for me to meet such case.
Please forgive my ignorance.

Forrest
