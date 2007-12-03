From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Enabling MSI in sata_nv
Date: Mon, 03 Dec 2007 14:17:57 -0500
Message-ID: <47545665.2070109@garzik.org>
References: <47537304.2030801@overt.org> <47543CAF.9060003@rtr.ca> <475443A4.4020508@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53452 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608AbXLCTSA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 14:18:00 -0500
In-Reply-To: <475443A4.4020508@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Philip Langdale <philipl@overt.org>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Mark Lord wrote:
>> Philip Langdale wrote:
>>> Hi all,
>>>
>>> At least for my hardware (MCP55), the sata controller supports MSI
>>> and it seems that turning it on is as simple as inserting the call
>>> to pci_enable_msi - after that it Just Works(tm).
>>>
>>> Are there any gotchas that I'm missing? Would a patch to do this
>>> be accepted?
>> ..
>>
>> Don't even dream about it for now.  The driver is unstable enough
>> without throwing MSI into the works.
> ..
> 
> Oh, wait a minute.. I misread "sata_nv" as "sata_mv" there.

FWIW:  Marvell says they run with MSI enabled on 6440 (mvsas) in their 
vendor driver, but not on any of the 50xx and 60xx variants supported by 
sata_mv.

Maybe that's changed in the past year with 7042, I dunno.  But that's 
the latest info I have.

	Jeff



