From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 9/13] ATA ACPI: check SATA/PATA more carefully
Date: Thu, 23 Feb 2006 00:30:04 +0000
Message-ID: <1140654604.8672.29.camel@localhost.localdomain>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
	 <20060222140008.3832951a.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:21950 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751015AbWBWA0D (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Feb 2006 19:26:03 -0500
In-Reply-To: <20060222140008.3832951a.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com

On Mer, 2006-02-22 at 14:00 -0800, Randy Dunlap wrote:
> +	if (ap->legacy_mode) {
>  		err = pata_get_dev_handle(dev, &dev_handle, &pcidevfn);
>  		if (err < 0) {
>  			if (ata_msg_probe(ap))

ap->legacy mode tells you if one of a subset of PCI controllers is in
native or legacy compatibility mode. It tells you nothing about whether
the controller is SATA or PATA. In fact it may even be both at once as
there may be a SATA bridge on one channel in some configurations. The
field is also meaningless for PCI controllers that are not class IDE.

The cable type field will tell you in some situations if we are PATA or
SATA but we actually don't always know at the moment. We probably have
the info for 99.9% of cases if needed it just isnt ap->legacy_mode, its
cable type plus the PATA/SATA bridge knobbling check.

Alan
