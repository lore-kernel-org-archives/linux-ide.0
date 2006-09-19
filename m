From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/20] libata: kill ata_host_stop()
Date: Tue, 19 Sep 2006 00:46:20 -0400
Message-ID: <450F761C.5070309@pobox.com>
References: <11559779703875-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38045 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752033AbWISEqc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Sep 2006 00:46:32 -0400
In-Reply-To: <11559779703875-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> As all the current LLDs are PCI, ata_pci_host_stop() should be used,
> which BTW is effectively identical to ata_host_stop().  Convert all
> LLDs to use ata_pci_host_stop() and kill ata_host_stop().

NAK, they are not equivalent replacements:

* ata_host_stop checks mmio_base before calling iounmap.  Most of the 
drivers you change do not use ioremap (thus it's really a no-op call for 
them)

* ata_pci_host_stop not only unmaps unconditionally, it calls 
pci_iounmap().  Only drivers which have previously used pci_iomap() 
should use this helper.

This patch may make sense later in the patch series, when 
ata_pci_host_stop presumably works for all iomap-converted drivers, but 
not really as the first patch?


