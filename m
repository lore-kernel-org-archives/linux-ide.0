From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Fix a logic error in ahci_init_one()
Date: Fri, 14 Apr 2006 04:47:05 -0400
Message-ID: <443F6189.7050204@pobox.com>
References: <1144999881.24774.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:11493 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965120AbWDNIrI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Apr 2006 04:47:08 -0400
In-Reply-To: <1144999881.24774.9.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: linux-ide@vger.kernel.org

zhao, forrest wrote:
> Fix an bug in error handling, also variable
> pci_dev_busy has no use, remove it.
> 
> Signed-off-by: Zhao Forrest <forrest.zhao@intel.com>

What logic error do you see?

pci_dev_busy has a clear use, as illustrated by the code:  if the PCI 
regions are reserved by another device, the device is in use, therefore 
we should avoid killing the device with pci_disable_device().

	Jeff



