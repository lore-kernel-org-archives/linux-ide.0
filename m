From: Mark Lord <liml@rtr.ca>
Subject: Re: Enabling MSI in sata_nv
Date: Mon, 03 Dec 2007 12:57:56 -0500
Message-ID: <475443A4.4020508@rtr.ca>
References: <47537304.2030801@overt.org> <47543CAF.9060003@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3092 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750723AbXLCR56 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 12:57:58 -0500
In-Reply-To: <47543CAF.9060003@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Philip Langdale <philipl@overt.org>
Cc: linux-ide@vger.kernel.org

Mark Lord wrote:
> Philip Langdale wrote:
>> Hi all,
>>
>> At least for my hardware (MCP55), the sata controller supports MSI
>> and it seems that turning it on is as simple as inserting the call
>> to pci_enable_msi - after that it Just Works(tm).
>>
>> Are there any gotchas that I'm missing? Would a patch to do this
>> be accepted?
> ..
> 
> Don't even dream about it for now.  The driver is unstable enough
> without throwing MSI into the works.
..

Oh, wait a minute.. I misread "sata_nv" as "sata_mv" there.

No comment on "sata_nv".

(we really oughta rename one of those two..)
