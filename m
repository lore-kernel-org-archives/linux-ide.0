From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 1/1] PCI: tune up ICH4 quirk for broken BIOSes
Date: Sat, 15 Jan 2011 09:39:19 -0600
Message-ID: <4D31BFA7.90806@gmail.com>
References: <1294327066-23518-1-git-send-email-jslaby@suse.cz> <AANLkTinN40GMRL3bJ7LKDmhCYK1AYZfQ+mVYwxDP1ZQe@mail.gmail.com> <4D3025F4.6020001@gmail.com> <201101140910.07154.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43606 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557Ab1AOPjW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Jan 2011 10:39:22 -0500
In-Reply-To: <201101140910.07154.bjorn.helgaas@hp.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Thomas Renninger <trenn@suse.de>

On 01/14/2011 10:10 AM, Bjorn Helgaas wrote:
> On Friday, January 14, 2011 03:31:16 am Jiri Slaby wrote:
>> On 01/14/2011 01:15 AM, Linus Torvalds wrote:
>>> On Thu, Jan 13, 2011 at 3:19 PM, Bjorn Helgaas<bjorn.helgaas@hp.com>  wrote:
>>>>
>>>> I think we're back to the question of why we have the ICH4 quirk in
>>>> the first place, and I don't know the answer to that.
>>>
>>> Iirc, there were several laptops that didn't have the ACPI region
>>> mentioned in any of the regular places, and we'd allocate the PCMCIA
>>> IO region on top of them. The machine would boot, but if anybody ever
>>> inserted a PCCard into the machine, the first access to the IO region
>>> would generally just halt it (because it was trying to read the
>>> PCCard, but the APCI region decodes first, and then the read from that
>>> usually put the CPU in a sleep state that it would never wake up from
>>> for obvious reasons).
>>>
>>> So we do want the ICH4 quirk.
>>
>> Yes, this is an "official" way how ICH4 (and later) advertises the region.
>
> The quirk is a bug workaround, *not* the "official, planned" way to
> deal with these regions.  The official way is to use ACPI, because
> that's a generic way that doesn't require changes for new versions
> of ICH.
>
> The bug might be that BIOS didn't mention the region in the expected
> places.  Or it might be that the BIOS mentioned it, but Linux didn't
> deal with it correctly.  For example, the Linux ACPI/PNP core mostly
> ignores the resources mentioned in ACPI _CRS methods.  We only look
> at those in individual drivers.  The PNP system.c driver reserves
> PNP0C01/02 resources, but the BIOS could use other PNP IDs, and Linux
> would ignore them (PNPACPI parses them, but doesn't reserve them in
> any way).

The patch to add the quirk was added back in 2003, and I believe using 
ACPI in Linux (other than for HT sibling discovery) was an uncommon 
configuration back then. It's quite possible the resources were reserved 
in ACPI on such systems and the quirk was only needed for systems with 
ACPI disabled in either the BIOS or the kernel.
