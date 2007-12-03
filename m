From: Mark Lord <liml@rtr.ca>
Subject: Re: Enabling MSI in sata_nv
Date: Mon, 03 Dec 2007 12:28:15 -0500
Message-ID: <47543CAF.9060003@rtr.ca>
References: <47537304.2030801@overt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1970 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbXLCR2Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 12:28:16 -0500
In-Reply-To: <47537304.2030801@overt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Philip Langdale <philipl@overt.org>
Cc: linux-ide@vger.kernel.org

Philip Langdale wrote:
> Hi all,
> 
> At least for my hardware (MCP55), the sata controller supports MSI
> and it seems that turning it on is as simple as inserting the call
> to pci_enable_msi - after that it Just Works(tm).
> 
> Are there any gotchas that I'm missing? Would a patch to do this
> be accepted?
..

Don't even dream about it for now.  The driver is unstable enough
without throwing MSI into the works.

Maybe in the new year, once we get it more up to spec.

Cheers
