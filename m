From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH 0/2]ACPI support for SATA/PATA
Date: Thu, 27 Jul 2006 09:44:57 +0800
Message-ID: <1153964697.4957.67.camel@forrest26.sh.intel.com>
References: <1153899345.4957.59.camel@forrest26.sh.intel.com>
	 <44C786D8.5060801@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56230 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751856AbWG0B53 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Jul 2006 21:57:29 -0400
In-Reply-To: <44C786D8.5060801@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: jgarzik@pobox.com, rdunlap@xenotime.net, htejun@gmail.com, linux-ide@vger.kernel.org

On Wed, 2006-07-26 at 11:14 -0400, Mark Lord wrote:
> zhao, forrest wrote:
> > Hello, all
> > 
> > In ACPI spec 3.0, section 9.9 defines 4 objects for PATA/SATA:
> > 
> > _GTF is for both PATA and SATA, which is used to return ATA task file
> > needed to re-init the drive;
> > _SDD is SATA-only object, which is used to inform the platform of the
> > type of device attached to a port;
> > _GTM and _STM are PATA-only objects, which are used to get/set PATA
> > timing information(i.e. PIO and DMA speed).
> 
> It seems to be quite common for ICH*M notebooks to use the SATA ports
> to attach PATA drives with PATA->SATA bridge chips in the middle.
> 
> In this case, one would expect the _GTM and _STM objects to be necessary,
> even though Linux thinks it's a SATA situation.
> 

Hi Mark,

I re-read the section 9.9 of ACPI spec 3.0, but didn't find any
description about how to deal with "PATA->SATA bridge". Is this version
of APCI spec outdated?
Would you please point me to spec(or document), which has the
description of how to deal with "PATA->SATA bridge"?

Thanks,
Forrest
