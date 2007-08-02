From: Mark Lord <liml@rtr.ca>
Subject: Re: No equivalent for ide-scsi available with the new PATA drivers?
Date: Thu, 02 Aug 2007 08:24:50 -0400
Message-ID: <46B1CD12.3020800@rtr.ca>
References: <46A4D91C.3090509@redhat.com> <20070723175239.54b721f1@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3957 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755533AbXHBMYv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Aug 2007 08:24:51 -0400
In-Reply-To: <20070723175239.54b721f1@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chuck Ebbert <cebbert@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
> On Mon, 23 Jul 2007 12:36:44 -0400
> Chuck Ebbert <cebbert@redhat.com> wrote:
> 
>> People with IDE tape drives are complaining there's no ide-scsi
>> driver available anymore with the new PATA layer. Is anyone
>> working on one?
> 
> It would make no sense. The libata layer is already using the SCSI
> midlayer so compliant devices should already appear with the st driver.
> 
> We might need some tape detect logic, but I don't have any tape devices
> so its up to someone with a tape drive handy to help out...

I have a PATA tape drive here somewhere.
Does anyone out there want it, with the understanding that it be
used to test/improve libata tape support?

One thing about ATAPI tape drives, is that they generally won't "stream"
with the generic SCSI st code.  Instead, many of them will do a *very* sluggish
stop/start stop/start stop/start kind of action when reading/writing bulk
data.  To get them to stream continously requires more driver intelligence,
*especially* when sharing a cable with some other device.

With an appropriate driver, tailored for ATAPI tape drives, they can run
at full speed while sharing a channel with another active ATA/ATAPI device,
both drives in use at the same time.

Cheers
