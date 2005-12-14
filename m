From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 7/7] SATA ACPI debug-only output
Date: Wed, 14 Dec 2005 17:42:00 -0500
Message-ID: <43A09FB8.2070700@pobox.com>
References: <20051213160110.193e3f61.randy_d_dunlap@linux.intel.com>	<20051213161028.7b459b23.randy_d_dunlap@linux.intel.com>	<43A09B7E.8020402@pobox.com> <20051214144243.0bc1b1ac.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:42713 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965045AbVLNWmE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Dec 2005 17:42:04 -0500
In-Reply-To: <20051214144243.0bc1b1ac.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: linux-ide@vger.kernel.org, axboe@suse.de, petkov@uni-muenster.de

Randy Dunlap wrote:
> On Wed, 14 Dec 2005 17:23:58 -0500
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> 
>>Randy Dunlap wrote:
>>
>>>From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
>>>
>>>Add some extra debug-only output.
>>>
>>> 
>>> 	status = acpi_get_devices(NULL, get_devices, winfo, NULL);
>>>-	if (ACPI_FAILURE(status))
>>>+	if (ACPI_FAILURE(status)) {
>>>+		DEBPRINT("acpi_get_devices failed\n");
>>
>>don't invent your own debugprint, use libata's
> 
> 
> DPRINTK() is too verbose for me.  Would you accept something
> that just does debug printing for probe/discovery/enumeration and
> not on every I/O?  then I could use the probe/discovery/enumeration
> level of debug printing.

Dig up the patches from Borislav Petkov on linux-ide that made debug 
messages more fine-grained.  Then we can specific things on and off at 
runtime...

	Jeff


