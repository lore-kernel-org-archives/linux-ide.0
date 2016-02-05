From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ata: add AMD Seattle platform driver
Date: Fri, 05 Feb 2016 15:50:51 +0100
Message-ID: <3134806.iILWebdeN8@wuerfel>
References: <1452789071-4090-1-git-send-email-brijesh.singh@amd.com> <4743985.XZ7D12RurV@wuerfel> <56B0F786.9010504@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:50443 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbcBEOvM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Feb 2016 09:51:12 -0500
In-Reply-To: <56B0F786.9010504@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, hdegoede@redhat.com, linux-ide@vger.kernel.org, Graeme Gregory <graeme@xora.org.uk>

On Tuesday 02 February 2016 12:37:58 Brijesh Singh wrote:
> Hi,
> 
> On 02/02/2016 08:08 AM, Arnd Bergmann wrote:
> > On Monday 01 February 2016 16:15:59 Brijesh Singh wrote:
> >>>
> >>> This is where we really need the ACPI maintainers to explain the
> >>> general policy for dealing with firmware updates.
> >>>
> >>> I would assume that adding the feature in a later firmware version
> >>> is a compatible change, and the feature is non-essential (the
> >>> device will work fine with the generic SATA driver, except
> >>> the LEDs don't blink), so it's not a big deal, it's just what
> >>> you get for having the firmware shipped before the driver is
> >>> reviewed (don't do that).
> >>>
> >>
> >> Agreed, the driver should have been reviewed earlier. And now changes in firmware will also require
> >> them changing other OSes drivers.
> > 
> > Can you explain that? I would expect the addition of some AML methods
> > to be a compatible change.
> > 
> 
> current DSDT entry looks like this:
> 
> Device (SATA0)
> {
> .....
> 
>  Name(_CRS, ResourceTemplate()
>  {
>    Memory32Fixed(ReadWrite, 0xE03000000, 0x000010000)  /* SATA block address */
>    Interrupt(ResourceConsumer, Level, ActiveHigh Exclusive,,,) { 387}
>    Memory32Fixed(ReadWrite, 0xE00000078, 1)  /* SGPIO register */
> }
>   
> ......
> }
> 
> Windows driver folks were okay to look at second resource field to map the SGPIO register and program the
> registers to blink the LEDs. I think as per ACPI spec, its legal to pass more than one block in resource
> template and since AML method is not mandatory for non standard enclosure management hence its entirely
> possible that some BIOS vendors may not implement it at all. But if they implement and decide
> to expose either AML method or register map but not both then Windows driver may break.

I don't have access to the Windows source code. Is this in the
architecture-independent part of their kernel, or only done on ARM64?
How do they decide what the second memory range is for?

If this is now a de-facto extension to the PCI_CLASS_STORAGE_SATA_AHCI binding,
it should probably be put into the next version of the AHCI spec, and then
there is no problem using it.


	Arnd
