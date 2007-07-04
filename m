From: Tejun Heo <htejun@gmail.com>
Subject: Re: how to handle pata_via when controller not in fully-pci-native
 mode (two irqs?)
Date: Wed, 04 Jul 2007 17:55:39 +0900
Message-ID: <468B608B.50803@gmail.com>
References: <467C689E.3050800@genesi-usa.com>	<20070623103349.23cad9b7@the-village.bc.nu>	<467CE8FA.2040304@genesi-usa.com>	<20070623105344.3ece6db1@the-village.bc.nu>	<467CF1E6.8000905@genesi-usa.com>	<4689FBCB.90608@gmail.com>	<468A04A0.1020003@genesi-usa.com>	<20070703131736.5ddc0b89@the-village.bc.nu>	<468A41CC.6030203@genesi-usa.com>	<20070703143809.5064fa35@the-village.bc.nu>	<468A5223.4050906@genesi-usa.com> <20070703145334.2bc9b773@the-village.bc.nu> <468A5532.9020600@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:40902 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760186AbXGDIzo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 04:55:44 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1503717nze
        for <linux-ide@vger.kernel.org>; Wed, 04 Jul 2007 01:55:44 -0700 (PDT)
In-Reply-To: <468A5532.9020600@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Matt Sealey wrote:
> Well, let's put the class code as "native" since the chip is made "native",
> in a platform file somewhere. Then, we can have a configuration option in
> the platform code which allows users to choose whether the IDE configuration
> is reworked to steer to a single IRQ or two IRQs. That way they can choose
> which driver they are using (they cannot use both, and compiling in both is
> stupid, so..)
> 
> Then pata_via can just work. It does seem easier now to do this in the
> platform support thing. As long as it only affects brand new kernels and
> is only enabled when libata pata_via is enabled (we can make it depend on
> it) then it should work fine, although having it in some other config
> page seems pretty quirky. I don't know how you would suggest to do it..
> have CONFIG_FIX_PEGASOS_IDE in drivers/ata/Kconfig and code in
> arch/powerpc/platforms/chrp which recognises it? This patch idea has to
> get past two teams now, though.. and modifying chip registers that early
> in CHRP initialisation seems to be quirky in itself (I don't think PCI
> is up yet) :D

I forgot about the PCI resource fix up done for legacy hosts.  I think
making the host legacy is the best way to take here considering that -
no change for both ide and libata, just some fix up in platform code.
ATA native/legacy thing doesn't mean much.  It's just how the resources
are allocated.  Is there any specific reason to use native mode?

-- 
tejun
