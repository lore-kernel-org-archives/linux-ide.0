From: Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v2] ata: add AMD Seattle platform driver
Date: Tue, 2 Feb 2016 12:37:58 -0600
Message-ID: <56B0F786.9010504@amd.com>
References: <1452789071-4090-1-git-send-email-brijesh.singh@amd.com>
 <5709817.yQT8N3CaLj@wuerfel> <56AFD91F.4030008@amd.com>
 <4743985.XZ7D12RurV@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1bon0096.outbound.protection.outlook.com ([157.56.111.96]:36352
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754894AbcBBSke (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Feb 2016 13:40:34 -0500
In-Reply-To: <4743985.XZ7D12RurV@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: brijesh.singh@amd.com, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, hdegoede@redhat.com, linux-ide@vger.kernel.org, Graeme Gregory <graeme@xora.org.uk>

Hi,

On 02/02/2016 08:08 AM, Arnd Bergmann wrote:
> On Monday 01 February 2016 16:15:59 Brijesh Singh wrote:
>>>
>>> This is where we really need the ACPI maintainers to explain the
>>> general policy for dealing with firmware updates.
>>>
>>> I would assume that adding the feature in a later firmware version
>>> is a compatible change, and the feature is non-essential (the
>>> device will work fine with the generic SATA driver, except
>>> the LEDs don't blink), so it's not a big deal, it's just what
>>> you get for having the firmware shipped before the driver is
>>> reviewed (don't do that).
>>>
>>
>> Agreed, the driver should have been reviewed earlier. And now changes in firmware will also require
>> them changing other OSes drivers.
> 
> Can you explain that? I would expect the addition of some AML methods
> to be a compatible change.
> 

current DSDT entry looks like this:

Device (SATA0)
{
.....

 Name(_CRS, ResourceTemplate()
 {
   Memory32Fixed(ReadWrite, 0xE03000000, 0x000010000)  /* SATA block address */
   Interrupt(ResourceConsumer, Level, ActiveHigh Exclusive,,,) { 387}
   Memory32Fixed(ReadWrite, 0xE00000078, 1)  /* SGPIO register */
}
  
......
}

Windows driver folks were okay to look at second resource field to map the SGPIO register and program the
registers to blink the LEDs. I think as per ACPI spec, its legal to pass more than one block in resource
template and since AML method is not mandatory for non standard enclosure management hence its entirely
possible that some BIOS vendors may not implement it at all. But if they implement and decide
to expose either AML method or register map but not both then Windows driver may break.

I believe most of BIOS vendors are using above DSDT block for SATA and by implementing the platform driver
we could enable this feature right away in Linux OS. We do prefer to use generic driver however given the current situation platform driver seems a reasonable choice. I wish SoC designer had implemented the full 
enclosure management per SATA spec.


> 	Arnd
> 
