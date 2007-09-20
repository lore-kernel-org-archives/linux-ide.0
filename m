From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Add a horkage entry for DRQ mishandling (atapi
 tapes)
Date: Thu, 20 Sep 2007 22:42:17 +0100
Message-ID: <20070920224217.1c89dda9@the-village.bc.nu>
References: <20070920152751.6b707705@the-village.bc.nu>
	<46F2E04A.2000201@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47460 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752420AbXITVf3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 17:35:29 -0400
In-Reply-To: <46F2E04A.2000201@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>, Albert Lee <albertcc@tw.ibm.com>

> According to information I have received, some ATA (and possibly ATAPI?) 
> devices intentionally return some data in these cases.  In the case of 
> certain ATA devices, this returned data permits inspection of the 
> incorrected data.

News to me. ATA like ST-506/ST-412 exposes error data on I/O READ/WRITE
via the READ_BUFFER functionality but its basically useless without a lot
of knowledge of the drive on anything post ST-412 era.

Got any references ?

The other possibility is to whine but accept it happens - on the other
hand being lax about HSM errors is asking for corruption and it seems
to be unique to this tape device.

(and someone please don't tell me early pre ATAPI standard devices are
trying to return the sense data in this way or I'll be ill)

Alan
