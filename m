From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] PCI: tune up ICH4 quirk for broken BIOSes
Date: Fri, 07 Jan 2011 21:44:35 +0100
Message-ID: <4D277B33.1000508@gmail.com>
References: <1294327066-23518-1-git-send-email-jslaby@suse.cz> <201101061224.40596.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49093 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab1AGUok (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jan 2011 15:44:40 -0500
In-Reply-To: <201101061224.40596.bjorn.helgaas@hp.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jiri Slaby <jslaby@suse.cz>, jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Thomas Renninger <trenn@suse.de>

On 01/06/2011 08:24 PM, Bjorn Helgaas wrote:
> On Thursday, January 06, 2011 08:17:46 am Jiri Slaby wrote:
>> There are BIOSes out there where they provide ACPI mapping that
>> conflicts with fixed one. Then e.g. an IDE controller doesn't work due
>> to I/O space conflict:
>> pci 0000:00:1f.1: address space collision: [io  0x0170-0x0177] conflicts with 0000:00:1f.0 [io  0x0100-0x017f]
>>
>> 0x0170-0x0177 for IDE controllers is created in pci_setup_device.
>> 0x0100-0x017f for the ICH4 ISA bridge is created in quirk_ich4_lpc_acpi
> 
> This might be the right thing to do, but it feels hacky to add more
> magic numbers (">= 0x180"), so I'd like to understand it better.

Yes, definitely, it's a hack, but I haven't found anything better. So I
dropped the patch in for discussion.

> (Is there a bugzilla for this? 

Only a novell (opensuse) bugzilla:
https://bugzilla.novell.com/show_bug.cgi?id=558740

> Is it a regression?  Sounds like an
> old machine where we should have seen this before.)

Yes, a regression. 2.6.31 and newer doesn't work. 2.6.27 did. I don't
know what kernel exactly in between is first defunct.

> My guess is that we found this "conflict" and tried to move the
> controller, but it's hardwired to stay at 0x170 when in compatibility
> mode.  So the hardware is really still at 0x170, but Linux thinks it
> moved it elsewhere, so it doesn't work.

Sorry I didn't get this paragraph.

> The fixed IDE resources in pci_setup_device() make sense to me; I
> think section 2.1 of the PCI IDE spec justifies specific OS knowledge
> of the compatibility mode regions.
> 
> But I don't know the quirk_ich4_lpc_acpi() history, and this quirk
> is the sort of information the OS should not have to know about.

It's from ICH4 specs. For ICH4, the addresses of where to look for ACPI
and GPIO are specified in the PCI BUS conf space.

So we look at 0x40 in that space and find 0x101, so we reserve
0x100-0x17f which conflicts with legacy IDE which is 0x170-0x17f.

> Theoretically, ACPI tells us about the GPIO/TCO/etc. regions in a
> generic way via namespace devices or something in the static tables.
> Is that generic information missing, or is it there and Linux is
> ignoring it?  If we're ignoring it, I'd rather fix that.

It works for most boxes I would say. Try to google for "claimed by ICH4
ACPI/GPIO/TCO", it reports sane ranges like 0400-047f or 4000-407f.

> The main reason for claiming I/O regions is to keep us from placing
> another device on top of them.  But we've had PCIBIOS_MIN_IO = 0x1000
> forever, which should keep us from putting anything below that anyway
> (at least for PCI devices).  So there must be some other reason for
> claiming space in this quirk.

Anyway, this ACPI space may be below 0x1000 as can be seen above. From
the ICH standard, it can be anywhere...

thanks,
-- 
js
