From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/5] ata: add Broadcom AHCI SATA3 driver for STB chips
Date: Thu, 30 Apr 2015 10:47:30 +0200
Message-ID: <15526942.nNoly2gL9m@wuerfel>
References: <1429757950-28789-1-git-send-email-computersforpeace@gmail.com> <2143403.KdtLGyP3SG@wuerfel> <20150427215541.GB32500@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:60482 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbbD3Irt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Apr 2015 04:47:49 -0400
In-Reply-To: <20150427215541.GB32500@ld-irv-0074>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com

On Monday 27 April 2015 14:55:41 Brian Norris wrote:
> On Fri, Apr 24, 2015 at 09:46:01AM +0200, Arnd Bergmann wrote:
> > On Thursday 23 April 2015 09:46:11 Brian Norris wrote:
> > > On Thu, Apr 23, 2015 at 09:43:55AM +0200, Arnd Bergmann wrote:
> > > > On Wednesday 22 April 2015 19:59:08 Brian Norris wrote:
> 
> [snip]
> > > So we have a PHY driver, but it doesn't cover everything. Did you want
> > > me to write a second PHY driver?? I'm not sure how that'd work...
> > 
> > I think this is all fine, I mainly wanted to make sure that it had been
> > considered and that a decision was made after comparing the options.
> > What I'd really like to see is that you put this summary into the
> > patch description, because any reviewer will wonder about this.
> > You can use a 'Link: https://lkml.org/lkml/2015/3/18/940' tag behind
> > your signed-off-by to reference the earlier discussion, in addition to
> > the summary.
> 
> I summarized most of the conclusions in the cover letter, but I suppose
> a plain link to the original thread could do the job too.

Ok. I missed the description in the cover letter, that was my mistake.
Having more information in the part before the "---" line in the
patch description would be good here. 

> > If you can configure the endianess of the AHCI core through software,
> > it would be best to always set it to little-endian unconditionally,
> > so you can just use readl() or readl_relaxed() all the time.
> 
> We're already doing this in the driver as written, at least for the
> three configurations that have been tested (MIPS LE, MIPS BE, ARM LE).
> IIUC, you're focusing on ARM BE? This is not in any support plan for
> these chips.

I don't care if you want to provide official support for that configuration,
this is just about not writing code that is obviously broken in
configurations that are otherwise valid.

> But to straighten out what you're saying (correct me if I'm wrong), it
> seems like you're saying that on a (theoretical) BCM7xxx ARM in BE mode,
> the chip will come up in LE as normal, all busing will be configured for
> LE mode, and the BE kernel would only later change CPU endianness.

Correct, this is how all ARMv7 SoCs work.

> This would mean that AHCI should be left as it was -- in LE mode -- whereas
> this driver submission would actually configure AHCI to do its own
> internal swapping, effectively making it BE mode again. And that would
> be wrong.

Yes. I wasn't sure how the register for the swapping is defined though,
whether you set it to 'LE' vs 'BE', or to 'swap' vs 'noswap'.

> Now I think this has a few problems:
> 
> 1. ARM BE is not (and won't be) supported on these chips. There has been
> no plan and no testing, and I'm sure we'd run into more problems than
> those you're suggesting here.

There are usually three problems that happen when someone first tries
out a BE kernel on a new ARM platform:

a) secondary CPUs need to be switched into big-endian mode when they initially
   come out of reset:

diff --git a/arch/arm/mach-bcm/headsmp-brcmstb.S b/arch/arm/mach-bcm/headsmp-brcmstb.S
index 199c1ea58248..d7fe25502f54 100644
--- a/arch/arm/mach-bcm/headsmp-brcmstb.S
+++ b/arch/arm/mach-bcm/headsmp-brcmstb.S
@@ -26,6 +26,7 @@ ENTRY(brcmstb_secondary_startup)
          * Ensure CPU is in a sane state by disabling all IRQs and switching
          * into SVC mode.
          */
+ARM_BE8(setend be)
         setmode	PSR_I_BIT | PSR_F_BIT | SVC_MODE, r0
 
         bl      v7_invalidate_l1

b) drivers that use __raw_readl() instead readl_relaxed()

We already have an army of people that hunt down these drivers to convert them
to use readl_relaxed(). In your case, doing that would have the side-effect
of breaking the MIPS parts, so please do everyone and yourself a favor and
write the driver to work correctly from the start, so we don't need to write
that patch.

c) DMA descriptors that have gone wrong: As the endianess of a DMA master
device is fixed, you have to make sure that any data that is read by the
device is stored in device endianess, usually by defining the DMA
descriptors like 

struct ahci_cmd_hdr {
        __le32                  opts;
        __le32                  status;
        __le32                  tbl_addr;
        __le32                  tbl_addr_hi;
        __le32                  reserved[4];
};

and then using cpu_to_le32 (or cpu_to_be32 for big-endian devices) to store
the descriptor data in memory. Most drivers get this right, and we have
tools available to help you there. Doing a byte swap on the bus does not
work for DMA in general, because that would swap both the descriptors
and the data you want to transfer, which has to remain in address order
as a byte stream.

> 2. To get ARM BE working properly, I'm not confident we'd do (only)
> runtime 'setend' endianness switching. We're more likely to get a
> bus-level endianness switch and be back with a native-endian driver
> again. But then, I'm only speculating (as you are).

We have a ton of SoCs that just work in BE mode, and none of them were "designed"
to support it. Having a register to switch the bus endianess is considered
a mistake on most CPU architectures, and if there is one, we definitely
won't turn it on.

> > > Huh? I'm fine with a driver-specific helper to abstract this out, but
> > > why the MIPS fiddling? I'm fairly confident that in *all*
> > > configurations, this piece of the IP is wired up to work in native
> > > endianness, so it should never be doing an endian swap. The
> > > readl_relaxed() you're adding looks like it would just break the
> > > (theoretical) ARM BE case.
> > > 
> > > I understand that you don't like bare __raw_{read,write}l(), but some IP
> > > is just wired this way.
> > 
> > Kevin Cernekee recently introduced the "native-endian" DT property that
> > you can use to do runtime detection if that is necessary (i.e. you can't
> > tell the endianess from the CPU architecture, and you can't set it either).
> 
> I've seen that series. That works fine for IP that's shared on other
> systems, and that's what Broadcom has to work with. But I'm not sure
> that's worth doing on Broadcom-only IP, which is *always* accessed in
> native endianness.

Just get the concept of "native endianess" out of your head when you have
something that is not MIPS, it doesn't exist. ;-) 
In Linux, each device has its own endianess, and the drivers are written
to support it that way.

> > Using __raw_readl() in driver code just means that the driver is not
> > endian-aware at all, and we don't do that any more: new drivers that
> > can be used on ARM must be written in a way that works on both
> > little-endian and big-endian, and it's a good idea to use endian-safe
> > code on other architectures too.
> > 
> > It's ok to special-case MIPS here when you know that MIPS is weird. If
> > you don't want that, use run-time detection instead.
> 
> I'm not sure I come to the same conclusions as you. ARM BE is never
> tested on these chips, so if you're really stuck on "handling" it
> (without testing), I'm almost more inclined to put in compile
> dependencies instead. e.g.:
> 
> #if defined(CONFIG_ARM) && defined(CONFIG_CPU_BIG_ENDIAN)
> #error ARM BE not supported
> #endif
> 
> Or maybe Kconfig deps instead. Or maybe a 'native-endian' DT property,
> and we just fail to probe for !native-endian.

Those would all still be bugs. Don't write code that is known to be
broken when the simple and documented way to write a driver makes it
work.

> Now, this particular case is pretty trivial, and I'm sure I could just
> do what you say (since really, I don't care about ARM BE anyway), but I
> guarantee these same questions will come up over and over again on
> newly-upstreamed Broadcom drivers, where many of them are intentionally
> written for native endianness (because that's how the hardware works for
> all supported use cases) and have never been tested (and likely never
> will) on big endian ARM. To add extra levels of indirection (either
> conditional, or function pointers) to something as low-level as a
> register access, and for reasons that look almost 100% theoretical,
> seems excessive.

Making it architecture-dependent is fine, as I said. Just special-case
the MIPS-BE configuration here at compile-time, and it will be fine.

> If, however, you really have strong arguments for doing the extra work
> (and not testing it, and almost definitely never using it), then I can
> try and make sure we don't run across these problems in the future. I
> won't be too happy about it, but at least I won't have to waste my time
> on these discussions.

What I really want you to understand is the importance of writing correct
code that works even in cases you have not tested. We have put a lot of
thought into the MMIO register accessors over the years, trying to make
them foolproof, but you should not try to outsmart them if you don't know
the full story.

Note that a lot of the complexity of readl/writel stems from x86 having
very specific semantics: Hardware is assumed to always have little-endian
registers because that's what x86 has, and we do a lot of cache
and write buffer syncs because x86 is fully ordered on MMIO accesses.
(readl_relaxed avoids a lot of that overhead and you can use that
if you know what you are doing).

	Arnd
