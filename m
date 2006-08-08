From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 0/2]ACPI support for SATA/PATA
Date: Tue, 8 Aug 2006 10:52:15 -0700
Message-ID: <20060808105215.fee7c26d.rdunlap@xenotime.net>
References: <1153899345.4957.59.camel@forrest26.sh.intel.com>
	<44C786D8.5060801@rtr.ca>
	<1153964697.4957.67.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:61848 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030207AbWHHRtf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Aug 2006 13:49:35 -0400
Received: from midway.site ([71.117.253.75]) by xenotime.net for <linux-ide@vger.kernel.org>; Tue, 8 Aug 2006 10:49:31 -0700
In-Reply-To: <1153964697.4957.67.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Mark Lord <liml@rtr.ca>, jgarzik@pobox.com, htejun@gmail.com, linux-ide@vger.kernel.org

On Thu, 27 Jul 2006 09:44:57 +0800 zhao, forrest wrote:

> On Wed, 2006-07-26 at 11:14 -0400, Mark Lord wrote:
> > zhao, forrest wrote:
> > > Hello, all
> > > 
> > > In ACPI spec 3.0, section 9.9 defines 4 objects for PATA/SATA:
> > > 
> > > _GTF is for both PATA and SATA, which is used to return ATA task file
> > > needed to re-init the drive;
> > > _SDD is SATA-only object, which is used to inform the platform of the
> > > type of device attached to a port;
> > > _GTM and _STM are PATA-only objects, which are used to get/set PATA
> > > timing information(i.e. PIO and DMA speed).
> > 
> > It seems to be quite common for ICH*M notebooks to use the SATA ports
> > to attach PATA drives with PATA->SATA bridge chips in the middle.
> > 
> > In this case, one would expect the _GTM and _STM objects to be necessary,
> > even though Linux thinks it's a SATA situation.
> > 
> 
> Hi Mark,
> 
> I re-read the section 9.9 of ACPI spec 3.0, but didn't find any
> description about how to deal with "PATA->SATA bridge". Is this version
> of APCI spec outdated?
> Would you please point me to spec(or document), which has the
> description of how to deal with "PATA->SATA bridge"?

(I would have said SATA->PATA bridge. :)

No docs.  When I was at Intel, I asked the (MPG) BIOS people about
this.  Their reply was something like (IIRC), "You do whatever ACPI
commands that the host side thinks it is talking to."
In other words, use SATA commands here.
However, I had added some code to attempt to handle this,
although Jens and Alan (and maybe Jeff) all told me that it was
incorrect:  I attempted to use some flag (e.g., <legacy_mode>,
but I'm not sure which name exactly) to determine the full
configuration, but that idea was nack-ed.

Probably the best thing to do is ask them or some other
(Intel) BIOS people what they think about it and what their
recommendation is.

---
~Randy
