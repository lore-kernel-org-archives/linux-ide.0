From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] PCI: tune up ICH4 quirk for broken BIOSes
Date: Sat, 08 Jan 2011 00:29:00 +0100
Message-ID: <4D27A1BC.4080802@gmail.com>
References: <1294327066-23518-1-git-send-email-jslaby@suse.cz> <201101061224.40596.bjorn.helgaas@hp.com> <4D277B33.1000508@gmail.com> <201101071603.29999.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201101071603.29999.bjorn.helgaas@hp.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jiri Slaby <jslaby@suse.cz>, jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Thomas Renninger <trenn@suse.de>
List-Id: linux-ide@vger.kernel.org

On 01/08/2011 12:03 AM, Bjorn Helgaas wrote:
> On Friday, January 07, 2011 01:44:35 pm Jiri Slaby wrote:
>> On 01/06/2011 08:24 PM, Bjorn Helgaas wrote:
>>> Theoretically, ACPI tells us about the GPIO/TCO/etc. regions in a
>>> generic way via namespace devices or something in the static tables.
>>> Is that generic information missing, or is it there and Linux is
>>> ignoring it?  If we're ignoring it, I'd rather fix that.
>>
>> It works for most boxes I would say. Try to google for "claimed by ICH4
>> ACPI/GPIO/TCO", it reports sane ranges like 0400-047f or 4000-407f.
> 
> My point is that BIOS should be telling the OS about GPIO/TCO/etc.
> regions via an ACPI mechanism, and, ideally, we would use that rather
> than reading the address out of chipset-dependent registers.
> 
> Even though PMBASE says the ACPI registers occupy 128 bytes from
> 0x100-0x17f, it's likely there's no actual conflict between the
> last 16 bytes and the IDE device.

I wouldn't say so. According to the datasheet 0x60-0x7f of the space
(i.e. 0x160-0x17f here) is for TCO registers. There:
0x10 -- Software IRQ Generation Register (i.e. 0x170)
0x11-0x1f -- reserved (0x171-0x17f)

So at least 0x170 should be conflicting. Unless TCO is unused/disabled
and not mapped there at all. May be that the case?

> ACPI probably reports this region via the FADT (the GPE PM register
> blocks) and possibly a PNP0C02 device.  These will probably report
> something that doesn't conflict with the legacy IDE ports, i.e., a
> subset of the 0x100-0x17f range.
> 
> Ooooh, I notice in the bugzilla that something's wrong with SMBIOS
> (comment 29) and ACPI is disabled because we couldn't find the
> RSDP (dmesg in comment 27).  What sort of machine is this, anyway?
> We didn't find PNPBIOS, either.

Hmm, it looks like some old crap. What exact information you would like
to know? I've just asked if ACPI is not disabled in BIOS. There should
be no machine without ACPI running still in the 21st century, I think.

thanks,
-- 
js
