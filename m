From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH/RFC 0/7] SATA ACPI suspend/resume support
Date: Sat, 17 Dec 2005 14:06:00 -0800
Message-ID: <20051217140600.394b9ad1.rdunlap@xenotime.net>
References: <20051213161058.594e93e6.randy_d_dunlap@linux.intel.com>
	<43A09CAE.8090302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:30897 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964974AbVLQWF2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Dec 2005 17:05:28 -0500
Received: from midway ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Sat, 17 Dec 2005 14:05:27 -0800
In-Reply-To: <43A09CAE.8090302@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: randy_d_dunlap@linux.intel.com, linux-ide@vger.kernel.org, axboe@suse.de, akpm@osdl.org

On Wed, 14 Dec 2005 17:29:02 -0500 Jeff Garzik wrote:

> Randy Dunlap wrote:
> > This is an update to the SATA suspend/resume patches
> > to use ACPI methods (specifically _SDD and _GTF).
> > This patch series applies to 2.6.15-rc5-git3.
> > 
> > It boots but needs lots of testing & review/comments,
> > as well as adding a call to write taskfiles on
> > COMRESET event(s) (at least on async. loss of signal) and
> > freeing ata_device->gtf_address on module unload.
> > 
> > The patchset begins with the libata suspend/resume patch from
> > Jens Axboe and builds on that.
> 
> overall:
> 
> * we do need some way of sending BIOS settings to the devices, so I 
> grudgingly accept this, in concept.
> 
> * needs a command line arg that disables ACPI use.  libata=noacpi[, 
> option...] would be my suggestion.

Jeff, please clarify on this module option.

A module_param() that parallels atapi_enabled (like 'noacpi')
won't allow for additional ",option" values after it.  It would
be a simple int.

Are you suggesting a string parameter (charp) and
in-module parsing of a comma-separated option string?
If so, why?  I don't think that is necessary.

> * currently assumes that to_pci_dev(struct device *) is valid for all 
> cases.  so, need some way to limit calling the ATA ACPI functions, 
> depending on runtime hardware configuration.
> 
> * at least one endian bug spotted

---
~Randy
