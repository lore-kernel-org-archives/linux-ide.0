From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] PCI: tune up ICH4 quirk for broken BIOSes
Date: Fri, 14 Jan 2011 11:31:16 +0100
Message-ID: <4D3025F4.6020001@gmail.com>
References: <1294327066-23518-1-git-send-email-jslaby@suse.cz> <201101101140.45501.bjorn.helgaas@hp.com> <4D2ECEDC.4040804@gmail.com> <201101131619.01893.bjorn.helgaas@hp.com> <AANLkTinN40GMRL3bJ7LKDmhCYK1AYZfQ+mVYwxDP1ZQe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <AANLkTinN40GMRL3bJ7LKDmhCYK1AYZfQ+mVYwxDP1ZQe@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Thomas Renninger <trenn@suse.de>
List-Id: linux-ide@vger.kernel.org

On 01/14/2011 01:15 AM, Linus Torvalds wrote:
> On Thu, Jan 13, 2011 at 3:19 PM, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>>
>> I think we're back to the question of why we have the ICH4 quirk in
>> the first place, and I don't know the answer to that.
> 
> Iirc, there were several laptops that didn't have the ACPI region
> mentioned in any of the regular places, and we'd allocate the PCMCIA
> IO region on top of them. The machine would boot, but if anybody ever
> inserted a PCCard into the machine, the first access to the IO region
> would generally just halt it (because it was trying to read the
> PCCard, but the APCI region decodes first, and then the read from that
> usually put the CPU in a sleep state that it would never wake up from
> for obvious reasons).
> 
> So we do want the ICH4 quirk.

Yes, this is an "official" way how ICH4 (and later) advertises the region.

The original commit says:
commit df4ba87cfc2239aa85e21178fca35cf6644a6dd1
Author: Linus Torvalds <torvalds@home.osdl.org>
Date:   Thu Oct 23 17:52:25 2003 -0700

    Add a quirk for the Intel ICH-[45] to add special ACPI regions.

    This fixes resource conflicts due to IO decode that doesn't show
    up with a normal PCI probe (we do similar quirks for most other
    chipsets). Without it, the kernel doesn't know about some magic
    IO decodes for the chips.

>> Maybe you could make the ICH4 quirk only claim the region if it's
>> above PCIBIOS_MIN_IO, i.e., if it's in the area where we could put
>> another PCI device on top of it?
> 
> That may well be the best solution - we'd only mark it reserved if it
> might conflict with a dynamic allocation, and if it conflicts with
> other motherboard resources (like the IDE ports), then we don't know
> what the decode priority is anyway, so..
> 
> In this case, it looks like the legacy IDE ports get decoded before
> the dynamic BAR's. Which is not too much of a surprise (fixed
> addresses tend to be the first to get decoded).

I will attach 2 patches for this as a reply. I created 2 variants:
A is for all quirk
B is only for ICH4 and ICH6

thanks,
-- 
js
