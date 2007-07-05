From: Tejun Heo <htejun@gmail.com>
Subject: Re: how to handle pata_via when controller not in fully-pci-native
 mode (two irqs?)
Date: Thu, 05 Jul 2007 11:28:26 +0900
Message-ID: <468C574A.9010509@gmail.com>
References: <467C689E.3050800@genesi-usa.com>	<20070623103349.23cad9b7@the-village.bc.nu>	<467CE8FA.2040304@genesi-usa.com>	<20070623105344.3ece6db1@the-village.bc.nu>	<467CF1E6.8000905@genesi-usa.com>	<4689FBCB.90608@gmail.com>	<468A04A0.1020003@genesi-usa.com>	<20070703131736.5ddc0b89@the-village.bc.nu>	<468A41CC.6030203@genesi-usa.com>	<20070703143809.5064fa35@the-village.bc.nu>	<468A5223.4050906@genesi-usa.com> <20070703145334.2bc9b773@the-village.bc.nu> <468A5532.9020600@genesi-usa.com> <468B608B.50803@gmail.com> <468BF013.7030601@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:5967 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756067AbXGEC2e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 22:28:34 -0400
Received: by py-out-1112.google.com with SMTP id u77so4153873pyb
        for <linux-ide@vger.kernel.org>; Wed, 04 Jul 2007 19:28:33 -0700 (PDT)
In-Reply-To: <468BF013.7030601@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello, Matt.

Matt Sealey wrote:
> Tejun Heo wrote:
>> I forgot about the PCI resource fix up done for legacy hosts.  I think
>> making the host legacy is the best way to take here considering that -
>> no change for both ide and libata, just some fix up in platform code.
>> ATA native/legacy thing doesn't mean much.  It's just how the resources
>> are allocated.  Is there any specific reason to use native mode?
> 
> Yes, legacy mode means there are several "io ports" mapped into the
> 0 thru 0x1000 addresses. This might work in Linux, granted, but I am
> not sure it is a good idea in the first place.
> 
> Mapping io ports to anywhere but the PCI io space is just an ugly
> solution. The ATA native/legacy thing means a lot, as there is no
> "legacy" on PowerPC. It's a PCI device, so we should try and fix up
> it's actions as a PCI device, however, making it truly conform will
> break any "not entirely compatible" drivers break (via8cxxx being
> the biggest culprit). Therefore no firmware fixes for thee.

For libata, being native or legacy doesn't really mean that much.  With
the patch posted yesterday[1], the only difference is how IRQs are
requested.  Other than that, libata initializes aa legacy controller the
same way as a native controller, so you can use mmio exactly the same way.

> I do think we can knock it into full PCI native mode from the platform
> fixups though, as a kernel option. Old drivers will work fine, old
> kernels will work fine, and optionally old behaviour can be left, but
> anyone building a new kernel with pata_via and no via8cxxx (i.e. all
> new distributions) can enable the new behaviour.

That would work too but if you do PCI header fix up for legacy host,
nothing needs to be changed and nothing needs to be selected during
boot.  Both via82cxxx and pata_via would just work.  The controller's
PCI BARs contain valid values on entering kernel, right?  The only thing
you have to do is flipping the legacy bit in platform PCI fix up code.

-- 
tejun

[1] http://article.gmane.org/gmane.linux.ide/20357
