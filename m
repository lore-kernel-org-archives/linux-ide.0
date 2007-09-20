From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Add a horkage entry for DRQ mishandling (atapi
 tapes)
Date: Thu, 20 Sep 2007 17:04:10 -0400
Message-ID: <46F2E04A.2000201@garzik.org>
References: <20070920152751.6b707705@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47704 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751649AbXITVEP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Sep 2007 17:04:15 -0400
In-Reply-To: <20070920152751.6b707705@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>, Albert Lee <albertcc@tw.ibm.com>

Alan Cox wrote:
> This will allow us to handle the tape drive problems Mark Lord reported
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

According to information I have received, some ATA (and possibly ATAPI?) 
devices intentionally return some data in these cases.  In the case of 
certain ATA devices, this returned data permits inspection of the 
incorrected data.

I dunno about ATAPI devices, but it sounds like returning data here may 
be an unspecified but known behavior.

As such, it sounds like this warrants some core changes and not simply 
as a horkage bit?

	Jeff


