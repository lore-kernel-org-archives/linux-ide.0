From: Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v2] ata: add AMD Seattle platform driver
Date: Mon, 8 Feb 2016 12:12:13 -0600
Message-ID: <56B8DA7D.6010400@amd.com>
References: <1452789071-4090-1-git-send-email-brijesh.singh@amd.com>
 <4743985.XZ7D12RurV@wuerfel> <56B0F786.9010504@amd.com>
 <3134806.iILWebdeN8@wuerfel> <56B4DA8B.2050609@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1bon0075.outbound.protection.outlook.com ([157.56.111.75]:11854
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751327AbcBHSOz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Feb 2016 13:14:55 -0500
In-Reply-To: <56B4DA8B.2050609@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: brijesh.singh@amd.com, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, hdegoede@redhat.com, linux-ide@vger.kernel.org, Graeme Gregory <graeme@xora.org.uk>

Hi Arnd,

On 02/05/2016 11:23 AM, Brijesh Singh wrote:
> Hi,
> 
>>> }
>>>
>>> Windows driver folks were okay to look at second resource field to map the SGPIO register and program the
>>> registers to blink the LEDs. I think as per ACPI spec, its legal to pass more than one block in resource
>>> template and since AML method is not mandatory for non standard enclosure management hence its entirely
>>> possible that some BIOS vendors may not implement it at all. But if they implement and decide
>>> to expose either AML method or register map but not both then Windows driver may break.
>>
>> I don't have access to the Windows source code. Is this in the
>> architecture-independent part of their kernel, or only done on ARM64?
>> How do they decide what the second memory range is for?
>>
>> If this is now a de-facto extension to the PCI_CLASS_STORAGE_SATA_AHCI binding,
>> it should probably be put into the next version of the AHCI spec, and then
>> there is no problem using it.
>>
> I don't have Windows code either and do not know the implementation details. I was told by the AMD folks 
> working on Windows drivers for Seattle that they do not need any changes in BIOS DSDT to get the LEDs blinking.
> 
> This is not a de-facto extension of SATA_AHCI binding, you can call this method as a SoC hack to support the LEDs.
> We are working with whatever BIOS is already available to enable the LEDs blinking.
> 

I am not sure what I can do next, given the SoC and BIOS limitation it seems like platform driver is best choice to enable this feature.
Do you have any review feedback on driver itself ? if not, then can we get this patch in?

-Brijesh
