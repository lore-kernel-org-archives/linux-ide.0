From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: Another project for you...  :)
Date: Thu, 15 Jun 2006 15:59:27 +0800
Message-ID: <1150358367.7132.100.camel@forrest26.sh.intel.com>
References: <1149751860.29552.79.camel@forrest26.sh.intel.com>
	 <44883BAE.7070406@pobox.com>
	 <1149820043.5721.7.camel@forrest26.sh.intel.com> <4488E6F6.10306@pobox.com>
	 <1150272114.7132.58.camel@forrest26.sh.intel.com>
	 <20060614081919.f2652c0e.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57460 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751322AbWFOILx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Jun 2006 04:11:53 -0400
In-Reply-To: <20060614081919.f2652c0e.rdunlap@xenotime.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: jgarzik@pobox.com, htejun@gmail.com, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On Wed, 2006-06-14 at 08:19 -0700, Randy.Dunlap wrote:
> On Wed, 14 Jun 2006 16:01:54 +0800 zhao, forrest wrote:
> 
> > On Thu, 2006-06-08 at 23:11 -0400, Jeff Garzik wrote:
> > > Forrest,
> > > 
> > > BTW, if you are looking for useful libata projects, it would really be 
> > > nice to resurrect Randy Dunlap's SATA ACPI patches, update those for the 
> > > current libata-dev.git#upstream, and get those in.
> > 
> > Randy,
> > 
> > Could you confirm if your latest SATA-ACPI patch is at this URL?
> > http://www.xenotime.net/linux/SATA/2.6.16-rc4/libata-rollup-2616-rc4.patch
> 
> Yes, correct.

According to ACPI spec 3.0, _GTM and _STM are IDE-only objects, _SDD is
SATA-only object. And in your patch you used field "legacy_mode" of
"struct ata_probe_ent" in order to distinguish between IDE and SATA.
But after reading the code of ata_pci_init_one(), I found that
"legacy_mode" is used to distinguish between legacy mode and native PCI
mode of IDE controller. Am I right? Or did I miss anything?
If I'm right, I'll fix it during the porting of your patch.

Thanks,
Forrest
