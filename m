From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH/RFC 0/7] SATA ACPI suspend/resume support
Date: Thu, 22 Dec 2005 10:31:53 -0800
Message-ID: <20051222103153.15a988f6.randy_d_dunlap@linux.intel.com>
References: <871x09nmin.fsf@marrow.phys.tohoku.ac.jp>
	<20051220105514.01815cba.randy_d_dunlap@linux.intel.com>
	<87zmmtthtv.fsf@marrow.phys.tohoku.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:395 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030298AbVLVSbY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Dec 2005 13:31:24 -0500
In-Reply-To: <87zmmtthtv.fsf@marrow.phys.tohoku.ac.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp>
Cc: linux-ide@vger.kernel.org

On 22 Dec 2005 21:52:12 +0900
Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp> wrote:

> Randy Dunlap <randy_d_dunlap@linux.intel.com> writes:
> 
> > > The screen is cleared and the following is displayed:
> > > 
> > > Stopping tasks: ==========|
> > > acpi_bus-0201 [57] bus_set_power         : Device is not power manageable
> > > PM: Entering mem sleep
> > 
> > I've asked for some clarification on this message, including
> > how serious (problematic) it is to the suspend process,
> > but have received no answer yet (on the acpi-devel mailing
> > list).  It appears to mostly be a debugging information message.
> 
> I hope the following information is useful.
> I changed part of drivers/acpi/bus.c
> 
>         if (!device->flags.power_manageable) {
>                 ACPI_DEBUG_PRINT((ACPI_DB_WARN,
>                                   "Device is not power manageable\n"));
>                 return_VALUE(-ENODEV);
>         }
> 
> to
> 
>         if (!device->flags.power_manageable) {
>                 ACPI_DEBUG_PRINT((ACPI_DB_WARN,
>                                   "Device %s is not power manageable\n",
>                                   device->kobj.name));
>                 return_VALUE(-ENODEV);
>         }
>         
> And the kobj.name included in the warning was:
> 
> acpi_bus-0202 [57] bus_set_power         : Device IDE0 is not power manageable
> 
> Looks like this is related to a hard drive controller?

Yes, but from looking at the code, it still doesn't look
like a critical error to me, just a warning.
Nevertheless, we should get your patch merged IMO.

Thanks,
---
~Randy
