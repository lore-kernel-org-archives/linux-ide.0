From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH 7/7] SATA ACPI debug-only output
Date: Wed, 14 Dec 2005 15:08:17 -0800
Message-ID: <20051214150817.5dcd12ac.randy_d_dunlap@linux.intel.com>
References: <20051213160110.193e3f61.randy_d_dunlap@linux.intel.com>
	<20051213161028.7b459b23.randy_d_dunlap@linux.intel.com>
	<43A09B7E.8020402@pobox.com>
	<20051214144243.0bc1b1ac.randy_d_dunlap@linux.intel.com>
	<43A09FB8.2070700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:20422 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S965042AbVLNXEt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Dec 2005 18:04:49 -0500
In-Reply-To: <43A09FB8.2070700@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, axboe@suse.de, petkov@uni-muenster.de

On Wed, 14 Dec 2005 17:42:00 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Randy Dunlap wrote:
> > On Wed, 14 Dec 2005 17:23:58 -0500
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> > 
> > 
> >>Randy Dunlap wrote:
> >>
> >>>From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> >>>
> >>>Add some extra debug-only output.
> >>>
> >>> 
> >>> 	status = acpi_get_devices(NULL, get_devices, winfo, NULL);
> >>>-	if (ACPI_FAILURE(status))
> >>>+	if (ACPI_FAILURE(status)) {
> >>>+		DEBPRINT("acpi_get_devices failed\n");
> >>
> >>don't invent your own debugprint, use libata's
> > 
> > 
> > DPRINTK() is too verbose for me.  Would you accept something
> > that just does debug printing for probe/discovery/enumeration and
> > not on every I/O?  then I could use the probe/discovery/enumeration
> > level of debug printing.
> 
> Dig up the patches from Borislav Petkov on linux-ide that made debug 
> messages more fine-grained.  Then we can specific things on and off at 
> runtime...

OK, I found 1/2 in the archive but not 2/2.
Borislav, did you send 2/2?  Can you resend it, please?

---
~Randy
