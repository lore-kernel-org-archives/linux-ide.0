From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: how to handle pata_via when controller not in fully-pci-native
 mode (two irqs?)
Date: Tue, 03 Jul 2007 14:54:58 +0100
Message-ID: <468A5532.9020600@genesi-usa.com>
References: <467C689E.3050800@genesi-usa.com>	<20070623103349.23cad9b7@the-village.bc.nu>	<467CE8FA.2040304@genesi-usa.com>	<20070623105344.3ece6db1@the-village.bc.nu>	<467CF1E6.8000905@genesi-usa.com>	<4689FBCB.90608@gmail.com>	<468A04A0.1020003@genesi-usa.com>	<20070703131736.5ddc0b89@the-village.bc.nu>	<468A41CC.6030203@genesi-usa.com>	<20070703143809.5064fa35@the-village.bc.nu>	<468A5223.4050906@genesi-usa.com> <20070703145334.2bc9b773@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:2856 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbXGCNyO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 09:54:14 -0400
In-Reply-To: <20070703145334.2bc9b773@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Well, let's put the class code as "native" since the chip is made "native",
in a platform file somewhere. Then, we can have a configuration option in
the platform code which allows users to choose whether the IDE configuration
is reworked to steer to a single IRQ or two IRQs. That way they can choose
which driver they are using (they cannot use both, and compiling in both is
stupid, so..)

Then pata_via can just work. It does seem easier now to do this in the
platform support thing. As long as it only affects brand new kernels and
is only enabled when libata pata_via is enabled (we can make it depend on
it) then it should work fine, although having it in some other config
page seems pretty quirky. I don't know how you would suggest to do it..
have CONFIG_FIX_PEGASOS_IDE in drivers/ata/Kconfig and code in
arch/powerpc/platforms/chrp which recognises it? This patch idea has to
get past two teams now, though.. and modifying chip registers that early
in CHRP initialisation seems to be quirky in itself (I don't think PCI
is up yet) :D

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Alan Cox wrote:
> On Tue, 03 Jul 2007 14:41:55 +0100
> Matt Sealey <matt@genesi-usa.com> wrote:
> 
>> The chip isn't in legacy mode. We never set it to legacy mode. Legacy mode would not work.
>> It's set to native mode. However the PCI class code does not reflect this :)
> 
> By the time the OS has booted to the point the IDE layer runs the PCI
> class code has been read and pci->resource[] arrays have been set up for
> the legacy addresses not the PCI BAR ones.
> 
> So with a current kernel at the point the pci header quirks run you can
> load the PCI bar values back into the pci->resource[] array. The code is
> designed to allow for this. Unfortunately libata then ignores the values
> provided because some changes haven't been made that have been pending
> for ages. I'll push the relevant trivial bits to Andrew today after
> testing them
> 
>> The old Via driver checked the host controller configuration space, rather
>> than trust the PCI class code and the ATA specs, it seems? Well, you would
>> know since you wrote it? 
> 
> Not those bits.
> 
> The intended code flow is this
> 
> 	pci probe
> 		early quirk
> 		class IDE legacy
> 			Load the resources 0 to 3 specially
> 		header quirk
> 
> 	resource tree reserved	
> 
> 	libata
> 		Use resource 0-3 for legacy or native
> 
> Right now the last bit is using hardcoded numbers that need fixing up.
> 
> Alan
