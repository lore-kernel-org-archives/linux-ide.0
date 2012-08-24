From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH v2] ahci: implement aggressive SATA device sleep support
Date: Fri, 24 Aug 2012 10:46:44 +0000
Message-ID: <43EB3AB3EEFE8D43B525F4D2EAF507E107E1A41A@SCYBEXDAG03.amd.com>
References: <1345761072-2123-1-git-send-email-shane.huang@amd.com>
 <503647B3.6050706@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:48441
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758778Ab2HXKqy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Aug 2012 06:46:54 -0400
In-Reply-To: <503647B3.6050706@pobox.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Aaron Lu <aaron.lwe@gmail.com>, "Huang, Shane" <Shane.Huang@amd.com>

Jeff,

> 2) If we are going to unconditionally add ATA_SECT_SIZE bytes to every 
> ata_device structure, let's at least move the ata_read_log_page() call 
> outside of the devslp test, so that others may have this information 
> even if the device does not support devslp.

Agreed, the info in that page is not limited to DevSlp variables.
Should I also move it outside of the ata_dev_configure() function?
Do you have better place to suggest?


> 3) please define constants in linux/ata.h for sata_settings information, 
> rather than using hexidecimal constants ("magic numbers").

OK, I will define ATA_ID_FEATURE_SUPP to replace all the 78.


> 4) is it wise to issue SET_FEATURES / SATA_DEVSLP prior to programming 
> the host controller?  that order seems wrong.

Per our understanding, there is no sequence requirement on this,
please correct me if you see risk.


Thanks,
Shane

