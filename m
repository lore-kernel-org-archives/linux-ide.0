From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH 7/7] SATA ACPI debug-only output
Date: Wed, 14 Dec 2005 14:42:43 -0800
Message-ID: <20051214144243.0bc1b1ac.randy_d_dunlap@linux.intel.com>
References: <20051213160110.193e3f61.randy_d_dunlap@linux.intel.com>
	<20051213161028.7b459b23.randy_d_dunlap@linux.intel.com>
	<43A09B7E.8020402@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:27837 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S965036AbVLNWj2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Dec 2005 17:39:28 -0500
In-Reply-To: <43A09B7E.8020402@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, axboe@suse.de

On Wed, 14 Dec 2005 17:23:58 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Randy Dunlap wrote:
> > From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> > 
> > Add some extra debug-only output.
> > 
> >  
> >  	status = acpi_get_devices(NULL, get_devices, winfo, NULL);
> > -	if (ACPI_FAILURE(status))
> > +	if (ACPI_FAILURE(status)) {
> > +		DEBPRINT("acpi_get_devices failed\n");
> 
> don't invent your own debugprint, use libata's

DPRINTK() is too verbose for me.  Would you accept something
that just does debug printing for probe/discovery/enumeration and
not on every I/O?  then I could use the probe/discovery/enumeration
level of debug printing.

---
~Randy
