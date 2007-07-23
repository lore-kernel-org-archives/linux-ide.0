From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: No equivalent for ide-scsi available with the new PATA drivers?
Date: Mon, 23 Jul 2007 12:17:00 -0500
Message-ID: <1185211020.3417.19.camel@localhost.localdomain>
References: <46A4D91C.3090509@redhat.com>
	 <20070723175239.54b721f1@the-village.bc.nu>  <46A4DEF3.4050106@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:54016 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757550AbXGWRRE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jul 2007 13:17:04 -0400
In-Reply-To: <46A4DEF3.4050106@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, 2007-07-23 at 13:01 -0400, Chuck Ebbert wrote:
> On 07/23/2007 12:52 PM, Alan Cox wrote:
> >> People with IDE tape drives are complaining there's no ide-scsi
> >> driver available anymore with the new PATA layer. Is anyone
> >> working on one?
> > 
> > It would make no sense. The libata layer is already using the SCSI
> > midlayer so compliant devices should already appear with the st driver.
> > 
> > We might need some tape detect logic, but I don't have any tape devices
> > so its up to someone with a tape drive handy to help out...
> 
> I should have posted this earlier:

It looks like an error handling issue ... which command was being
executed at the time the tape at ata2.01 went into the error state?

I haven't looked, but it's entirely possible that it's a simple timeout
issue:  libata does some of its own error handling, but the tape
commmands have to run with timeouts set to huge values (because it can
take so long to rewind a tape or write a long block).

James


