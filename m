From: Jeff Garzik <jeff@garzik.org>
Subject: More Promise chipset specs opened
Date: Thu, 02 Nov 2006 00:46:16 -0500
Message-ID: <45498628.9090105@garzik.org>
References: <45497E3A.6060103@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35238 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752680AbWKBFqT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Nov 2006 00:46:19 -0500
In-Reply-To: <45497E3A.6060103@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Jeff Garzik wrote:
> Promise has given me permission to post hardware programming info for 
> one of their chips (Linux driver: sata_promise), PDC20319.  This also 
> marks the first open chipset for Promise (AFAIK), so let's give them a 
> round of applause.

I missed an email from Promise which supplied even more chipset docs to 
open.  Whoops.  The entire line supported by sata_promise.c should now 
be open:

2037x:
http://gkernel.sourceforge.net/specs/promise/pdc2037x%20series%20development%20guide.pdf.bz2

20319 (updated link, updated doc):
http://gkernel.sourceforge.net/specs/promise/pdc20319%20development%20guide.pdf.bz2

205xx (the newer NCQ chips):
http://gkernel.sourceforge.net/specs/promise/pdc205xx%20development%20guide%201.0.pdf.bz2

Cheers,

	Jeff


