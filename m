From: Jeff Garzik <jeff@garzik.org>
Subject: Disabling ADMA?  (was Re: [PATCH] drivers/ata: Add the SW NCQ support
 to sata_nv for MCP51/MCP55/MCP61)
Date: Sat, 07 Jul 2007 11:39:17 -0400
Message-ID: <468FB3A5.9000008@garzik.org>
References: <15F501D1A78BD343BE8F4D8DB854566B059FE131@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35521 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201AbXGGPjU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Jul 2007 11:39:20 -0400
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B059FE131@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kuan Luo <kluo@nvidia.com>, hancockr@shaw.ca, Peer Chen <pchen@nvidia.com>, Allen Martin <AMartin@nvidia.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-ide@vger.kernel.org

Kuan Luo wrote:
> 	@@ -1714,3 +2761,6 @@ module_init(nv_init);
> 	 module_exit(nv_exit);
> 	 module_param_named(adma, adma_enabled, bool, 0444);
> 	 MODULE_PARM_DESC(adma, "Enable use of ADMA (Default: true)");
> 	+module_param_named(ncq, ncq_enabled, bool, 0444);
> 	+MODULE_PARM_DESC(ncq, "Enable use of NCQ (Default: false)");

After looking through sata_nv bug reports, I am leaning towards 
disabling ADMA by default, and wanted to solicit comments.

While admittedly not knowing the root cause, it seems like every current 
outstanding sata_nv bug report that remains after switching out hardware 
can be solved by setting module option 'adma' to zero.  That's my first 
suggestion upon any bugzilla sata_nv bug, and it usually works.  You can 
look through bugs assigned to or CC'd to jgarzik@pobox.com (kernel.org 
bugs) jgarzik@redhat.com (redhat.com bugs) for examples.

I still need to review the SWNCQ patch in detail, but I presume it is 
possible to still use SWNCQ without ADMA?

On a side note, I would rather default SWNCQ to 'on'.

	Jeff




