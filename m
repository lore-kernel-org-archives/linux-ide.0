From: Jeff Garzik <jgarzik@pobox.com>
Subject: [sata] Promise PATA port on PDC2037x SATA
Date: Thu, 25 Mar 2004 20:37:07 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40638943.9010206@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27612 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263856AbUCZBhV
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Mar 2004 20:37:21 -0500
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>


Anybody wanna give this a quick test?  It doesn't actually _do_ anything 
yet, except attempt to detect the PATA port.

Latest libata...

http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.25-libata14.patch.bz2

http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.5-rc2-bk6-libata1.patch.bz2

BitKeeper repositories:
	http://gkernel.bkbits.net/libata-2.[46]

The latter 2.6 patch applies to the current BK tree, will be -bk6 when 
that snapshot is generated tonight.  It _should_ apply to earlier 
2.6.5-rc2, but applying to earlier kernels you -may- need to 
s/pci_dma_mapping_error/pci_dma_error/, or completely remove the 
pci_dma_[mapping_]error() check.

	Jeff




