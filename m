From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Another project for you...  :)
Date: Thu, 15 Jun 2006 07:47:26 -0400
Message-ID: <449148CE.5080604@pobox.com>
References: <1149751860.29552.79.camel@forrest26.sh.intel.com>	 <44883BAE.7070406@pobox.com>	 <1149820043.5721.7.camel@forrest26.sh.intel.com> <4488E6F6.10306@pobox.com>	 <1150272114.7132.58.camel@forrest26.sh.intel.com>	 <20060614081919.f2652c0e.rdunlap@xenotime.net> <1150358367.7132.100.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:61671 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030263AbWFOLrf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jun 2006 07:47:35 -0400
In-Reply-To: <1150358367.7132.100.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, htejun@gmail.com, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

zhao, forrest wrote:
> According to ACPI spec 3.0, _GTM and _STM are IDE-only objects, _SDD is
> SATA-only object. And in your patch you used field "legacy_mode" of
> "struct ata_probe_ent" in order to distinguish between IDE and SATA.
> But after reading the code of ata_pci_init_one(), I found that
> "legacy_mode" is used to distinguish between legacy mode and native PCI
> mode of IDE controller. Am I right? Or did I miss anything?
> If I'm right, I'll fix it during the porting of your patch.

You are correct, you should use cbl==SATA or ATA_FLAG_SATA to check for 
SATA.  legacy-vs-native is not an accurate check.

	Jeff


