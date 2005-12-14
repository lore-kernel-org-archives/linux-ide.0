From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC 0/7] SATA ACPI suspend/resume support
Date: Wed, 14 Dec 2005 17:29:02 -0500
Message-ID: <43A09CAE.8090302@pobox.com>
References: <20051213161058.594e93e6.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:34009 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750745AbVLNW3F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Dec 2005 17:29:05 -0500
In-Reply-To: <20051213161058.594e93e6.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: ide <linux-ide@vger.kernel.org>, axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>

Randy Dunlap wrote:
> This is an update to the SATA suspend/resume patches
> to use ACPI methods (specifically _SDD and _GTF).
> This patch series applies to 2.6.15-rc5-git3.
> 
> It boots but needs lots of testing & review/comments,
> as well as adding a call to write taskfiles on
> COMRESET event(s) (at least on async. loss of signal) and
> freeing ata_device->gtf_address on module unload.
> 
> The patchset begins with the libata suspend/resume patch from
> Jens Axboe and builds on that.

overall:

* we do need some way of sending BIOS settings to the devices, so I 
grudgingly accept this, in concept.

* needs a command line arg that disables ACPI use.  libata=noacpi[, 
option...] would be my suggestion.

* currently assumes that to_pci_dev(struct device *) is valid for all 
cases.  so, need some way to limit calling the ATA ACPI functions, 
depending on runtime hardware configuration.

* at least one endian bug spotted

