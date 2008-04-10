From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [BUG] linux-next: Tree for April 10 - kernel panic while loading
 ata driver on powermac
Date: Thu, 10 Apr 2008 08:14:39 -0400
Message-ID: <47FE04AF.1080103@garzik.org>
References: <20080410181404.b76939a6.sfr@canb.auug.org.au>	<47FDEAFA.10407@linux.vnet.ibm.com>	<47FDEFC8.9070105@garzik.org> <20080410123230.7203f626@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50509 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755382AbYDJMO7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Apr 2008 08:14:59 -0400
In-Reply-To: <20080410123230.7203f626@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE mailing list <linux-ide@vger.kernel.org>

Alan Cox wrote:
> On Thu, 10 Apr 2008 06:45:28 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> Kamalesh Babulal wrote:
>>> Hi Stephen,
>>>
>>> The next-20080410 kernel panics while bootup over the PowerMac G5 box, while
>>> loading the ATA driver.
>> IDE driver, you mean.
> 
> Jeff - we may in the kernel world use IDE v ATA to distinguish between
> the two drivers but both are still ATA drives and I don't think its too
> fair to respond this way, especially to someone who has gone to the
> trouble of capturing a very good trace.

Sure.  The main goal was to copy Bart and linux-ide.  That was just an 
aside.

	Jeff



