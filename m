From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: VIA SATAPI status
Date: Thu, 27 Jan 2005 17:47:17 -0500
Message-ID: <41F96F75.3040305@pobox.com>
References: <CE433BCC-6FC0-11D9-B91E-000A95D2AC6A@iomega.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28645 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261260AbVA0Wrb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Jan 2005 17:47:31 -0500
In-Reply-To: <CE433BCC-6FC0-11D9-B91E-000A95D2AC6A@iomega.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gp <poppitzg@iomega.com>
Cc: linux-ide@vger.kernel.org

gp wrote:
> Has anyone been able to run the sata_via driver with a SATAPI device?


In theory, nothing should be needed except to edit include/linux/libata.h:

#undef ATA_ENABLE_ATAPI         /* define to enable ATAPI support */

may also need this:
#undef ATAPI_ENABLE_DMADIR      /* enables ATAPI DMADIR bridge support*/


That configuration is not well tested, as SATAPI is very new.  Most SATA 
drivers except AHCI should work with SATAPI (AHCI needs a couple 
modifications first).

	Jeff


