From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv important note
Date: Thu, 19 Jan 2006 12:05:06 -0500
Message-ID: <43CFC6C2.60607@rtr.ca>
References: <43CD07D5.30302@pobox.com> <E1EytdC-0006DE-IS@highlab.com>	 <43CD46B7.4000907@rtr.ca> <1137581636.10890.81.camel@localhost.localdomain>	 <43CE6965.9040408@pobox.com> <1137613505.25727.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:46496 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932539AbWASRFW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jan 2006 12:05:22 -0500
In-Reply-To: <1137613505.25727.6.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Erik Slagter wrote:
>
>>sata_qstor
>
> Bummer. I silently hoped it would be using ahci, but I will dream on ;-)

It has a UHCI interface rather than AHCI.

There is an alternative SCSI LLD for it that supports all of the goodies
(native and legacy tagged queuing, RAID 0/1/10, hot ("live") insertion/removal,
etc.. but it is probably a bit out of date now.  Last updated a year ago.
And not in the main tree.

Cheers
