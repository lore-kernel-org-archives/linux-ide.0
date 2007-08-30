From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: ATAPI tape drives broken with libata
Date: Thu, 30 Aug 2007 12:11:39 -0400
Message-ID: <46D6EC3B.8090306@redhat.com>
References: <46D5F97B.3050808@redhat.com> <20070830005006.6951265a@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:39447 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757168AbXH3QLp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Aug 2007 12:11:45 -0400
In-Reply-To: <20070830005006.6951265a@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, craig48@swbell.net

On 08/29/2007 07:50 PM, Alan Cox wrote:
> 
> Device Ready, Seek Complete, Data Request, Error
> 
> DRQ and Error together is a bit odd to say the least
> 
> It then commits suicide and falls off the bus. That may be due to the
> fact we use SRST on ATAPI device errors still rather than trying an ATAPI
> reset first. Shouldn't matter though.
> 
> Since you are the lucky owner of the object in question can you dump the
> contents of the packet command going to the device when this occurs ?
> 

I don't have it, it's a Fedora user. Maybe I should ask Mark Lord if he'll
send me the one he has.

IAC how do I dump the packet? Use ata_scsi_dump_cdb()?

