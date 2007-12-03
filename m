From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Enabling MSI in sata_nv
Date: Mon, 03 Dec 2007 14:16:15 -0500
Message-ID: <475455FF.2060707@garzik.org>
References: <47537304.2030801@overt.org> <87f94c370712031055h4c359ee9w59fd076fedcc8b9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53440 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbXLCTQS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 14:16:18 -0500
In-Reply-To: <87f94c370712031055h4c359ee9w59fd076fedcc8b9f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Philip Langdale <philipl@overt.org>
Cc: Greg Freemyer <greg.freemyer@gmail.com>, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Greg Freemyer wrote:
> On Dec 2, 2007 10:07 PM, Philip Langdale <philipl@overt.org> wrote:
>> Hi all,
>>
>> At least for my hardware (MCP55), the sata controller supports MSI
>> and it seems that turning it on is as simple as inserting the call
>> to pci_enable_msi - after that it Just Works(tm).
>>
>> Are there any gotchas that I'm missing? Would a patch to do this
>> be accepted?
>>
>> --phil
> 
> I don't know if it is relevant, but I had to disable MSI to get a
> MCP55 NIC to work under 2.6.22.

MSI is pretty flaky, but we default it to 'on' for AHCI, which is the 
"enhanced mode" side of the sata_nv chip.

So it is likely that it works on newer boards -- but even though Mark 
Lord's response was mistaken (he thought sata_mv was being discussed), 
he was right too...  sata_nv has stability problems and I would prefer 
not to enable MSI just yet, until we cure the other problems.

	Jeff



