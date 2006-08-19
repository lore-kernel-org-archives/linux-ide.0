From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/20] libata: kill ata_host_stop()
Date: Sat, 19 Aug 2006 10:51:39 -0400
Message-ID: <44E7257B.3090902@pobox.com>
References: <11559779703875-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47766 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751524AbWHSOv4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Aug 2006 10:51:56 -0400
In-Reply-To: <11559779703875-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> As all the current LLDs are PCI, ata_pci_host_stop() should be used,
> which BTW is effectively identical to ata_host_stop().  Convert all
> LLDs to use ata_pci_host_stop() and kill ata_host_stop().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

This patch is broken because now several drivers which do not do

	mmio_base = pci_iomap()

now unconditionally call pci_iounmap().

	Jeff



