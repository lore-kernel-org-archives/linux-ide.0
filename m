From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_mv important note
Date: Wed, 18 Jan 2006 11:14:29 -0500
Message-ID: <43CE6965.9040408@pobox.com>
References: <43CD07D5.30302@pobox.com> <E1EytdC-0006DE-IS@highlab.com>	 <43CD46B7.4000907@rtr.ca> <1137581636.10890.81.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:1974 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030371AbWARQOo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jan 2006 11:14:44 -0500
In-Reply-To: <1137581636.10890.81.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Erik Slagter wrote:
> On Tue, 2006-01-17 at 14:34 -0500, Mark Lord wrote:
> 
>>Sebastian Kuzminsky wrote:
>>
>>>Can anyone recommend a 4xSATA (or more) controller on a PCI-X card that
>>>_is_ ready for production use?  eSATA ports are prefered but not required.
>>>Support for hotplug, power management (spindown) and SMART is prefered
>>>but not required.
>>
>>The Pacific Digital QStor cards come in PCIX variants,
>>and support SATA2.  Hotplug et al is supported in the hardware,
>>but not in the Libata driver.  ATAPI is not supported at all.
> 
> 
> Using which driver? (just curious)

sata_qstor

	Jeff


