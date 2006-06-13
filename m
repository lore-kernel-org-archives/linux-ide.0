From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 06/10] libata: implement new Power Management framework
Date: Tue, 13 Jun 2006 07:59:00 -0400
Message-ID: <448EA884.705@pobox.com>
References: <11501274293403-git-send-email-htejun@gmail.com> <1150179928.7132.19.camel@forrest26.sh.intel.com> <448E7DBE.7010000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47248 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932076AbWFML7U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jun 2006 07:59:20 -0400
In-Reply-To: <448E7DBE.7010000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Please read ata_pci_init_one() and ata_pci_init_legacy_port() in 
> libata-bmdma.c.  It's for IDE controllers in legacy mode (not native 
> PCI) mode.

Just to be picky:  ata_pci_init_one() is for native or legacy mode. 
ata_pci_init_legacy_port() is [obviously] only referring to legacy mode.

	Jeff


