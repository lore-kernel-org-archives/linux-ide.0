From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22] remove Intel combined mode quirk
Date: Fri, 09 Mar 2007 11:33:45 -0500
Message-ID: <45F18C69.2040904@garzik.org>
References: <20070309160127.GA10226@havoc.gtf.org> <20070309172947.79ef61bf@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57580 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767372AbXCIQdr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 11:33:47 -0500
In-Reply-To: <20070309172947.79ef61bf@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Alan Cox wrote:
>>     Signed-off-by: Jeff Garzik <jeff@garzik.org>
> 
> Acked-by: Alan Cox <alan@redhat.com>
> 
> and you can remove even more code as pci_request_resources() will now
> just do the right thing for all cases.

pci_request_regions() you mean?

	Jeff



